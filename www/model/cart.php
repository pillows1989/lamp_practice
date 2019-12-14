<?php 
require_once 'functions.php';
require_once 'db.php';

function get_user_carts($db, $user_id){
  $sql = "
    SELECT
      items.item_id,
      items.name,
      items.price,
      items.stock,
      items.status,
      items.image,
      carts.cart_id,
      carts.user_id,
      carts.amount
    FROM
      carts
    JOIN
      items
    ON
      carts.item_id = items.item_id
    WHERE
      carts.user_id = ?
  ";
  
  return fetch_all_query($db, $sql,array($user_id));
}

function get_user_cart($db, $user_id, $item_id){
  $sql = "
    SELECT
      items.item_id,
      items.name,
      items.price,
      items.stock,
      items.status,
      items.image,
      carts.cart_id,
      carts.user_id,
      carts.amount
    FROM
      carts
    JOIN
      items
    ON
      carts.item_id = items.item_id
    WHERE
      carts.user_id = ?
    AND
      items.item_id = ?
  ";

  return fetch_query($db, $sql,array($user_id,$item_id));

}

function add_cart($db, $item_id, $user_id) {
  $cart = get_user_cart($db, $item_id, $user_id);
  if($cart === false){
    return insert_cart($db, $user_id, $item_id);
  }
  return update_cart_amount($db, $cart['cart_id'], $cart['amount'] + 1);
}

function insert_cart($db, $item_id, $user_id, $amount = 1){
  $sql = "
    INSERT INTO
      carts(
        item_id,
        user_id,
        amount
      )
    VALUES(?, ?, ?)
  ";
  
  return execute_query($db, $sql,array($item_id,$user_id,$amount));
}

function update_cart_amount($db, $cart_id, $amount){
  $sql = "
    UPDATE
      carts
    SET
      amount = ?
    WHERE
      cart_id = ?
    LIMIT 1
  ";
  
  return execute_query($db, $sql,array($amount,$cart_id));
}

function delete_cart($db, $cart_id){
  $sql = "
    DELETE FROM
      carts
    WHERE
      cart_id = ?
    LIMIT 1
  ";

  return execute_query($db, $sql,array($cart_id));
}

function purchase_carts($db, $carts,$user){
  if(validate_cart_purchase($carts) === false){
    return false;
  }
  $err_flag=false;
  $db->beginTransaction();
  if(insert_orders($db,$user)===false){
    set_error('予期せぬエラーが発生しました');
    $err_flag=true;
  }
  foreach($carts as $cart){
    
    if(update_item_stock(
        $db, 
        $cart['item_id'], 
        $cart['stock'] - $cart['amount']
      ) === false){
      set_error($cart['name'] . 'の購入に失敗しました。');
      $err_flag=true;
      break;
    }
    
    
    
    if(insert_order_details($db,$cart)===false){
      set_error('予期せぬエラーが発生しました');
      $err_flag=true;
      break;
    }
    
  }
  if(delete_user_carts($db, $carts[0]['user_id'])===false){
    set_error('予期せぬエラーが発生しました');
      $err_flag=true;
  }
  if($err_flag){
    $db->rollback();
    return false;
  }else{
    $db->commit(); 
  }
return true;

  
  
}

function delete_user_carts($db, $user_id){
  $sql = "
    DELETE FROM
      carts
    WHERE
      user_id = ?
  ";

  return execute_query($db, $sql,array($user_id));
}


function sum_carts($carts){
  $total_price = 0;
  foreach($carts as $cart){
    $total_price += $cart['price'] * $cart['amount'];
  }
  return $total_price;
}

function validate_cart_purchase($carts){
  if(count($carts) === 0){
    set_error('カートに商品が入っていません。');
    return false;
  }
  foreach($carts as $cart){
    if(is_open($cart) === false){
      set_error($cart['name'] . 'は現在購入できません。');
    }
    if($cart['stock'] - $cart['amount'] < 0){
      set_error($cart['name'] . 'は在庫が足りません。購入可能数:' . $cart['stock']);
    }
  }
  if(has_error() === true){
    return false;
  }
  return true;
}
function insert_orders($db,$user){
  $now_date = date('Y-m-d H:i:s');
  $sql="
    INSERT INTO
      orders(
        user_name,
        order_date
      )
    VALUES(?,?)";
  return execute_query($db, $sql,array($user['name'],$now_date));

}
function insert_order_details($db,$carts){
  $sql="
    INSERT INTO
      order_details(
        product_id,
        quantity,
        price
      )
      VALUES(?,?,?)";
      return execute_query($db, $sql,array($carts['item_id'],$carts['amount'],$carts['price']));
}
