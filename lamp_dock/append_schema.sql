-- orderテーブルsql
CREATE TABLE orders (
    order_id INT(11) NOT NULL AUTO_INCREMENT ,
    user_name VARCHAR(100) NOT NULL ,
    order_date DATETIME NOT NULL ,
    PRIMARY KEY (`order_id`)
);
-- order_detailsテーブルsql
CREATE TABLE order_details (
    order_id INT(11) NOT NULL AUTO_INCREMENT ,
    product_id INT(11) NOT NULL ,
    quantity INT(11) NOT NULL ,
    PRIMARY KEY (order_id) 
);
-- produtsテーブルsql
CREATE TABLE products (
    priduct_id INT(11) NOT NULL AUTO_INCREMENT ,
    product_name VARCHAR(100) NOT NULL ,
    price INT NOT NULL ,
    PRIMARY KEY (priduct_id)
 );
