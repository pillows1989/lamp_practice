<?php

function dd($var)
{
  var_dump($var);
  exit();
}

function redirect_to($url)
{
  header('Location: ' . $url);
  exit;
}

function get_get($name)
{
  if (isset($_GET[$name]) === true) {
    return $_GET[$name];
  };
  return '';
}

function get_post($name)
{
  if (isset($_POST[$name]) === true) {
    return $_POST[$name];
  };
  return '';
}

function get_file($name)
{
  if (isset($_FILES[$name]) === true) {
    return $_FILES[$name];
  };
  return array();
}

function get_session($name)
{
  if (isset($_SESSION[$name]) === true) {
    return $_SESSION[$name];
  };
  return '';
}

function set_session($name, $value)
{
  $_SESSION[$name] = $value;
}

function set_error($error)
{
  $_SESSION['__errors'][] = $error;
}

function get_errors()
{
  $errors = get_session('__errors');
  if ($errors === '') {
    return array();
  }
  set_session('__errors',  array());
  return $errors;
}

function has_error()
{
  return isset($_SESSION['__errors']) && count($_SESSION['__errors']) !== 0;
}

function set_message($message)
{
  $_SESSION['__messages'][] = $message;
}

function get_messages()
{
  $messages = get_session('__messages');
  if ($messages === '') {
    return array();
  }
  set_session('__messages',  array());
  return $messages;
}

function is_logined()
{
  return get_session('user_id') !== '';
}

function get_upload_filename($file)
{
  if (is_valid_upload_image($file) === false) {
    return '';
  }
  $mimetype = exif_imagetype($file['tmp_name']);
  $ext = PERMITTED_IMAGE_TYPES[$mimetype];
  return get_random_string() . '.' . $ext;
}

function get_random_string($length = 20)
{
  return substr(base_convert(hash('sha256', uniqid()), 16, 36), 0, $length);
}

function save_image($image, $filename)
{
  return move_uploaded_file($image['tmp_name'], IMAGE_DIR . $filename);
}

function delete_image($filename)
{
  if (file_exists(IMAGE_DIR . $filename) === true) {
    unlink(IMAGE_DIR . $filename);
    return true;
  }
  return false;
}



function is_valid_length($string, $minimum_length, $maximum_length = PHP_INT_MAX)
{
  $length = mb_strlen($string);
  return ($minimum_length <= $length) && ($length <= $maximum_length);
}

function is_alphanumeric($string)
{
  return is_valid_format($string, REGEXP_ALPHANUMERIC);
}

function is_positive_integer($string)
{
  return is_valid_format($string, REGEXP_POSITIVE_INTEGER);
}

function is_valid_format($string, $format)
{
  return preg_match($format, $string) === 1;
}


function is_valid_upload_image($image)
{
  if (is_uploaded_file($image['tmp_name']) === false) {
    set_error('ファイル形式が不正です。');
    return false;
  }
  $mimetype = exif_imagetype($image['tmp_name']);
  if (isset(PERMITTED_IMAGE_TYPES[$mimetype]) === false) {
    set_error('ファイル形式は' . implode('、', PERMITTED_IMAGE_TYPES) . 'のみ利用可能です。');
    return false;
  }
  return true;
}
function h($str)
{
  $result = htmlspecialchars($str, ENT_QUOTES, 'UTF-8');
  return $result;
}

function random_string($len)
{
  if ($len > 128 || $len <= 0) {
    $len = 128;
  }
  return substr(hash('sha512', uniqid()), 0, $len);
}

function get_csrf_token()
{
  $token = random_string(48);
  set_session(CSRF_TOKEN, $token);
  return $token;
}

function is_valid_csrf_token($token)
{
  if ($token === '') {
    return false;
  }
  return $token === get_session(CSRF_TOKEN);
}
function get_orders($db, $user)
{
  $sql = "
    SELECT
      orders.order_id,
      order_date,
      SUM(price*quantity) as total
    FROM 
      orders
    INNER JOIN 
      order_details
    ON
      orders.order_id=order_details.order_id";
  if ($user['type'] !== USER_TYPE_ADMIN) {
    $sql .= " WHERE
        orders.user_name=?";
  }
  $sql .= " GROUP BY
        order_id
      ORDER BY
        order_id";

  return fetch_all_query($db, $sql, array($user['name']));
}
function get_order_details($db,$order_id){
  $sql= "
    SELECT
      order_id,
      product_id,
      name,
      order_details.price,
      quantity,
      SUM(order_details.price*quantity) as total
    FROM
      order_details
    INNER JOIN
      items
    ON
    product_id=item_id
    WHERE
    order_id=?
    GROUP BY
    order_id,
    product_id";

  return fetch_all_query($db, $sql, array($order_id));
}
function get_ranking($db){
  $sql="
    SELECT
      item_id,
      name,
      image,
      items.price,
      stock,
      SUM(quantity) as total
    FROM
      items
    INNER JOIN
      order_details
    ON
      item_id=product_id
    GROUP BY
      item_id
    ORDER BY
      total DESC
    LIMIT
    3";

  return fetch_all_query($db, $sql);

}