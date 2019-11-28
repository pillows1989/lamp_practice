<?php
require_once '../conf/const.php';
require_once MODEL_PATH . 'functions.php';
require_once MODEL_PATH . 'user.php';
require_once MODEL_PATH . 'item.php';
require_once MODEL_PATH . 'cart.php';

session_start();

if(is_logined() === false){
  redirect_to(LOGIN_URL);
}

$db = get_db_connect();
$user = get_login_user($db);


$item_id = get_post('item_id');
$token=get_post('token');

if(preg_match('/\A\d+\z/',$item_id)!==1){
  set_error('不正な処理です');
}

if(is_valid_csrf_token($token)===false){
  set_error('不正な処理です');
}

if(has_error()){
  if(add_cart($db,$user['user_id'], $item_id)){
    set_message('カートに商品を追加しました。');
  } else {
    set_error('カートの更新に失敗しました。');
  }
}



redirect_to(HOME_URL);