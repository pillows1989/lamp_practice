<!DOCTYPE html>
<html lang="ja">
<head>
  <?php include VIEW_PATH . 'templates/head.php'; ?>
  <title>購入履歴</title>
  <link rel="stylesheet" href="<?php print(STYLESHEET_PATH . 'admin.css'); ?>">
</head>
<body>
  <?php include VIEW_PATH . 'templates/header_logined.php'; ?>
  <h1>購入履歴画面</h1>

  <div class="container">
    <?php include VIEW_PATH . 'templates/messages.php'; ?>
    <?php foreach($orders as $order){ ?>
        <table>
        <tr>
            <th>注文番号</th>
            <th>購入日時</th>
            <th>合計金額</th>
        </tr>
        <tr>
            <td><?php print $order['order_id']; ?></td>
            <td><?php print $order['order_date']; ?></td>
            <td><?php print $order['total']; ?></td>
            <td>
                <form action="<?php print(HISTORY_DETAILS_URL); ?>" method="post">
                    <input type="submit" value="購入明細へ" >
                    <input type="hidden" value="<?php print $order['order_id']?>" name="order_id">
                </form>
            </td>
        </tr>
    </table>
    
    <?php } ?>
    


    
    
  </div>
</body>
</html>