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
    time DATETIME NOT NULL,
    total FLOAT NOT NULL,
    PRIMARY KEY(tid)
    );
```

 ### Insert data



