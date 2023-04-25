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
DROP TABLE commodity;
DROP TABLE sale;
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
CREATE TABLE commodity(
    cid INT NOT NULL AUTO_INCREMENT,
    itemName VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    stock INT NOT NULL,
    PRIMARY KEY(cid)
    );
CREATE TABLE sale(
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
    time DATETIME NOT NULL,
    total FLOAT NOT NULL,
    PRIMARY KEY(tid)
    );
```

 ### Insert data

```mysql
#add example entries for each
INSERT INTO account (aid, login, password)
VALUES
    (Null, "JPotter@hotmail.com", "123456"),
    (Null, "LilyP@gmail.com", "654321");
INSERT INTO user (uid, name, account)
VALUES
    (Null, "Lily Potter", "LilyP@gmail.com"),
    (Null, "James Potter", "JPotter@hotmail.com");

INSERT INTO commodity (cid, itemName, type, price, stock)
VALUES
    (Null, "Potato", "Vegetables", 15.45, 300),
    (Null, "Tomato", "Fruit", 19.99, 100);
INSERT INTO sale (id, tid, time, cid, quantity, soldFor)
VALUES
    (NULL, 1,'2023-04-22T20:09:09', 1, 5, 77.25), # buys potato
    (NULL, 1,'2023-04-22T20:09:09', 2, 10, 199.90); # buys tomato
INSERT INTO transaction (tid, time, total)
VALUES
    (NULL, '2023-04-22T20:10:12', 277.15);
```

