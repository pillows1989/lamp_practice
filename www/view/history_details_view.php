<!DOCTYPE html>
<html lang="ja">
<head>
  <?php include VIEW_PATH . 'templates/head.php'; ?>
  <title>購入明細</title>
  <link rel="stylesheet" href="<?php print(STYLESHEET_PATH . 'admin.css'); ?>">
</head>
<body>
  <?php include VIEW_PATH . 'templates/header_logined.php'; ?>
  <h1>購入明細画面</h1>

  <div class="container">
    <?php include VIEW_PATH . 'templates/messages.php'; ?>
    
    <table>
        <tr>
            <th>商品名</th>
            <th>商品価格</th>
            <th>購入数</th>
            <th>小計</th>
        </tr>
        <?php foreach($order_details as $order_detail){ ?>
        <tr>
            <td><?php print h($order_detail['name']); ?></td>
            <td><?php print h($order_detail['price']); ?></td>
            <td><?php print h($order_detail['quantity']); ?></td>
            <td><?php print h($order_detail['total']); ?></td>
        </tr>
        <?php } ?>
    </table>
        
     

    
    
  </div>
</body>
</html>