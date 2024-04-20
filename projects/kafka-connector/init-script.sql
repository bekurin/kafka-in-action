grant all privileges on cdc.* to 'root'@'%' with grant option;
flush privileges;
grant all privileges on *.* to 'root'@'%' with grant option;
flush privileges;

use cdc;
drop table if exists product;
drop table if exists product_history;

CREATE TABLE product (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,0) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE product_history (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL ,
    name VARCHAR(100) NOT NULL ,
    price DECIMAL(10,0) NOT NULL
) ENGINE=InnoDB;
