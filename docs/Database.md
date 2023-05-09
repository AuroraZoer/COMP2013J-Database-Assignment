# Database

## Cloud Database

- url: 42.193.97.229
- userName: Zoe
- passWord: 7BybPneSwJHjzLRk
- dbName: zoe



## MySQL operations

### Delete tables


```mysql
#these commands will delete all tables
USE zoe;
DROP TABLE `user`;
DROP TABLE `admin`;
DROP TABLE `commodity`;
DROP TABLE `sale`;
DROP TABLE `transaction`;

```

### Create tables

```mysql
USE zoe;

CREATE TABLE `user` (
	`uid` INT ( 11 ) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR ( 100 ) NOT NULL,
	`password` VARCHAR ( 100 ) NOT NULL,
	`email` VARCHAR ( 255 ) NOT NULL,
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( `uid` ),
	UNIQUE KEY `username_unique` ( `username` ),
UNIQUE KEY `email_unique` ( `email` ) 
) ENGINE = INNODB DEFAULT CHARSET = utf8;

CREATE TABLE `admin` (
  `aid` INT(11) NOT NULL AUTO_INCREMENT,
  `admin_name` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`),
  UNIQUE KEY `admin_name_unique` (`admin_name`),
  UNIQUE KEY `email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# representing the commodity stored in warehouses.
CREATE TABLE `categories` (
    name VARCHAR(100) NOT NULL UNIQUE PRIMARY KEY
);
CREATE TABLE `commodity` (
    cid INT NOT NULL AUTO_INCREMENT,
    itemName VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    stock INT NOT NULL,
    PRIMARY KEY(cid),
    FOREIGN KEY (category) REFERENCES categories(name)
);
CREATE TABLE `sale` (
    id INT NOT NULL AUTO_INCREMENT,
    tid INT NOT NULL,
    time DATETIME NOT NULL,
    cid INT NOT NULL,
    quantity INT NOT NULL,
    soldFor FLOAT NOT NULL,
    PRIMARY KEY(id)
    );
CREATE TABLE `transaction`(
    tid INT NOT NULL AUTO_INCREMENT,
    uid INT NOT NULL,
    cid INT NOT NULL,
    quantity INT NOT NULL,
    total FLOAT NOT NULL,
    is_paid BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY(tid),
    FOREIGN KEY(uid) REFERENCES user(uid),
    FOREIGN KEY(cid) REFERENCES commodity(cid)
);

```

 ### Insert data

```
INSERT INTO `categories` (`name`) VALUES
('Books'),
('Electronics'),
('Clothing'),
('Home & Kitchen'),
('Sports & Outdoors');

INSERT INTO `commodity` (`itemName`, `category`, `price`, `stock`) VALUES
('Book 1', 'Books', 19.99, 100),
('Book 2', 'Books', 29.99, 80),

('Electronics 1', 'Electronics', 199.99, 50),
('Electronics 2', 'Electronics', 299.99, 40),

('Clothing 1', 'Clothing', 39.99, 200),
('Clothing 2', 'Clothing', 49.99, 180),

('Home & Kitchen 1', 'Home & Kitchen', 99.99, 30),
('Home & Kitchen 2', 'Home & Kitchen', 119.99, 20),


('Sports & Outdoors 1', 'Sports & Outdoors', 49.99, 100),
('Sports & Outdoors 2', 'Sports & Outdoors', 59.99, 90);
```

