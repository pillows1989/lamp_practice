-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- ホスト: mysql
-- 生成日時: 2019 年 12 月 17 日 14:42
-- サーバのバージョン： 5.7.28
-- PHP のバージョン: 7.2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `sample`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `carts`
--

CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `carts`
--

INSERT INTO `carts` (`cart_id`, `user_id`, `item_id`, `amount`, `created`, `updated`) VALUES
(28, 1, 34, 100, '2019-11-20 16:31:11', '2019-11-20 16:35:17');

-- --------------------------------------------------------

--
-- テーブルの構造 `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `items`
--

INSERT INTO `items` (`item_id`, `name`, `stock`, `price`, `image`, `status`, `created`, `updated`) VALUES
(32, '猫', 96, 18000, 'ny1owjn3yqs0cow8w4ws.jpg', 1, '2019-08-09 09:12:30', '2019-12-17 23:39:12'),
(33, 'ハリネズミ', 98, 50000, '16scmunsexdwcosw88g0.jpg', 1, '2019-08-09 09:13:33', '2019-12-17 23:39:12'),
(34, 'CD', 98, 100, '3f3717vald0kkgsocsko.jpg', 1, '2019-11-17 18:14:30', '2019-12-17 23:39:12'),
(35, 'CD２', 100, 1000, '2gj10dg8ycg08sg8kock.jpg', 1, '2019-12-14 16:55:59', '2019-12-17 10:57:51'),
(36, 'CD３', 100, 1200, '1u1cmb7n83c0kcwo8sco.jpg', 1, '2019-12-14 16:56:18', '2019-12-17 10:57:54'),
(37, 'CD４', 100, 1300, '2o8eq8adxtc04c8cs004.jpg', 1, '2019-12-14 16:57:02', '2019-12-17 10:59:04');

-- --------------------------------------------------------

--
-- テーブルの構造 `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `order_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `orders`
--

INSERT INTO `orders` (`order_id`, `user_name`, `order_date`) VALUES
(7, 'admin', '2019-12-08 13:50:13'),
(8, 'admin', '2019-12-08 15:10:07'),
(10, 'admin', '2019-12-11 21:50:16'),
(11, 'takemura', '2019-12-11 21:51:18'),
(12, 'admin', '2019-12-11 21:52:06'),
(13, 'takemura', '2019-12-11 21:56:21'),
(14, 'takemura', '2019-12-11 21:57:06'),
(15, 'takemura', '2019-12-12 13:50:02'),
(16, 'takemura', '2019-12-14 15:28:04'),
(17, 'takemura', '2019-12-14 15:28:19'),
(18, 'takemura', '2019-12-14 15:29:04'),
(19, 'takemura', '2019-12-14 15:29:27'),
(20, 'takemura', '2019-12-14 15:29:46'),
(23, 'admin', '2019-12-14 15:31:42'),
(24, 'takemura', '2019-12-14 15:42:32'),
(25, 'takemura', '2019-12-14 15:42:32'),
(26, 'takemura', '2019-12-14 15:43:33'),
(27, 'takemura', '2019-12-14 15:43:33'),
(28, 'takemura', '2019-12-14 15:51:09'),
(29, 'takemura', '2019-12-14 15:52:03'),
(30, 'takemura', '2019-12-14 16:29:21'),
(31, 'takemura', '2019-12-14 16:29:21'),
(32, 'takemura', '2019-12-14 16:38:11'),
(33, 'admin', '2019-12-17 10:27:41'),
(34, 'admin', '2019-12-17 10:53:47'),
(35, 'admin', '2019-12-17 10:56:04'),
(36, 'admin', '2019-12-17 10:58:37'),
(37, 'admin', '2019-12-17 10:59:48'),
(38, 'admin', '2019-12-17 11:00:12'),
(39, 'admin', '2019-12-17 11:00:36'),
(40, 'admin', '2019-12-17 11:01:22'),
(41, 'takemura', '2019-12-17 23:06:35'),
(42, 'takemura', '2019-12-17 23:07:55'),
(45, 'takemura', '2019-12-17 23:39:12');

-- --------------------------------------------------------

--
-- テーブルの構造 `order_details`
--

CREATE TABLE `order_details` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `order_details`
--

INSERT INTO `order_details` (`order_id`, `product_id`, `quantity`, `price`) VALUES
(7, 32, 3, 18000),
(8, 32, 1, 18000),
(10, 32, 1, 18000),
(11, 32, 1, 18000),
(12, 32, 1, 18000),
(13, 33, 1, 50000),
(14, 34, 1, 100),
(15, 32, 1, 18000),
(16, 33, 1, 50000),
(17, 33, 1, 50000),
(18, 32, 1, 18000),
(19, 32, 6, 18000),
(20, 33, 2, 50000),
(23, 32, 1, 18000),
(24, 32, 2, 18000),
(25, 33, 2, 50000),
(26, 32, 1, 18000),
(27, 33, 1, 50000),
(28, 32, 1, 18000),
(29, 32, 3, 18000),
(30, 32, 1, 18000),
(31, 33, 1, 50000),
(32, 32, 1, 18000),
(33, 33, 1, 50000),
(34, 37, 1, 1300),
(35, 37, 1, 1300),
(36, 37, 80, 1300),
(37, 32, 70, 18000),
(38, 33, 100, 50000),
(39, 34, 100, 100),
(40, 32, 100, 18000),
(41, 34, 1, 100),
(42, 32, 1, 18000),
(43, 33, 1, 50000),
(44, 32, 1, 18000),
(45, 32, 2, 18000),
(45, 33, 1, 50000),
(45, 34, 1, 100);

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '2',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `users`
--

INSERT INTO `users` (`user_id`, `name`, `password`, `type`, `created`, `updated`) VALUES
(1, 'sampleuser', 'password', 2, '2019-08-07 01:17:12', '2019-08-07 01:17:12'),
(4, 'admin', 'admin', 1, '2019-08-07 10:45:11', '2019-08-07 10:45:11'),
(5, 'takemura', 'pillows1989', 2, '2019-11-30 10:37:28', '2019-11-30 10:37:28');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `user_id` (`user_id`);

--
-- テーブルのインデックス `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- テーブルのインデックス `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_id`,`product_id`) USING BTREE;

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- ダンプしたテーブルのAUTO_INCREMENT
--

--
-- テーブルのAUTO_INCREMENT `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- テーブルのAUTO_INCREMENT `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- テーブルのAUTO_INCREMENT `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- テーブルのAUTO_INCREMENT `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- テーブルのAUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
