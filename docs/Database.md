# Database

## Cloud Database

- url: 42.193.97.229
- userName: Zoe
- passWord: 7BybPneSwJHjzLRk
- dbName: zoe

## MySQL operations

### Delete tables

```mysql
#these commands will
delete all tables
USE zoe;
DROP TABLE user;
DROP TABLE admin;
DROP TABLE commodity;
DROP TABLE categories;
DROP TABLE transaction;

```

### Create tables

```mysql
CREATE DATABASE zoe; # if does not exist
USE zoe;
# if warning: SHOW WARNINGS;
# users to this application
CREATE TABLE user (
	uid INT NOT NULL AUTO_INCREMENT,
	username VARCHAR ( 100 ) NOT NULL UNIQUE,
	password VARCHAR ( 100 ) NOT NULL,
	email VARCHAR ( 255 ) NOT NULL,
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( uid ),
	UNIQUE KEY user_unique ( username, email )
) ;

# admins that have privileges such as increasing stock, etc
CREATE TABLE admin (
	aid INT NOT NULL AUTO_INCREMENT,
	admin_name VARCHAR ( 255 ) NOT NULL,
	password VARCHAR ( 255 ) NOT NULL,
	email VARCHAR ( 255 ) NOT NULL,
	create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( aid ),
	UNIQUE KEY admin_unique( admin_name, email )
) ;

# representing the commodity stored in warehouses.
CREATE TABLE categories ( category VARCHAR ( 100 ) NOT NULL UNIQUE PRIMARY KEY );

# items
CREATE TABLE commodity (
	cid INT NOT NULL AUTO_INCREMENT,
	itemName VARCHAR ( 100 ) NOT NULL,
	category VARCHAR ( 100 ) NOT NULL,
	price FLOAT NOT NULL,
	stock INT NOT NULL,
	PRIMARY KEY ( cid ),
	FOREIGN KEY (category) REFERENCES categories(category) 
);

# history of transaction.
CREATE TABLE transaction (
	tid INT NOT NULL AUTO_INCREMENT,
	uid INT NOT NULL,
	cid INT NOT NULL,
	quantity INT NOT NULL,
	total FLOAT NOT NULL,
	is_paid BOOLEAN NOT NULL DEFAULT 0,
	PRIMARY KEY ( tid ),
	FOREIGN KEY ( uid ) REFERENCES user	( uid ),
    FOREIGN KEY ( cid ) REFERENCES commodity ( cid ) 
);

```

### Insert data

```mysql
INSERT INTO admin ( admin_name, password, email ) 
VALUES 
    ('Suri', '123456', 'shuqi.dai@ucdconnect.ie');
    
    
INSERT INTO user (username, password, email)
VALUES
    ('Zoe', '123456', ' yiran.zhao3@ucdconnect.ie');

INSERT INTO categories ( category )
VALUES
	( 'Fruit' ),
	( 'Snack' ),
	( 'Vegetable' ),
	( 'Meat' ),
	( 'Drink' );

INSERT INTO commodity ( itemName, category, price, stock )
VALUES
	( 'apple', 'Fruit', 7, 30 ),
	( 'banana', 'Fruit', 5, 30 ),
	( 'orange', 'Fruit', 8, 20 ),
	( 'star fruit', 'Fruit', 8, 10 ),
	( 'bayberry', 'Fruit', 6, 20 ),
	( 'yellow peach', 'Fruit', 5, 25 ),
	( 'peach', 'Fruit', 4, 20 ),
	( 'lute', 'Fruit', 12, 5 ),
	( 'orange', 'Fruit', 4, 10 ),
	( 'watermelon', 'Fruit', 3, 10 ),
	( 'mango', 'Fruit', 7, 10 ),
	( 'cantaloupe', 'Fruit', 7, 15 ),
	( 'pomelo', 'Fruit', 4, 15 ),
	( 'kiwi fruit', 'Fruit', 6, 10 ),
	( 'pear', 'Fruit', 4, 10 ),
	( 'grape', 'Fruit', 8, 20 ),
	( 'mangosteen', 'Fruit', 25, 25 ),
	( 'durian', 'Fruit', 20, 20 ),
	( 'dragon fruit', 'Fruit', 6.5, 15 ),
	( 'pineapple', 'Fruit', 5, 10 ),
	( 'coconut', 'Fruit', 9, 10 ),
	( 'potato chips', 'Snack', 5, 100 ),
	( 'sugar', 'Snack', 0.5, 200 ),
	( 'chocolate', 'Snack', 3, 100 ),
	( 'cake', 'Snack', 8, 105 ),
	( 'jelly', 'Snack', 3, 200 ),
	( 'biscuit', 'Snack', 4, 300 ),
	( 'cereal', 'Snack', 20, 120 ),
	( 'milk tablet', 'Snack', 12, 130 ),
	( 'nori', 'Snack', 10, 130 ),
	( 'dried fruit', 'Snack', 5, 120 ),
	( 'latiao', 'Snack', 1.5, 140 ),
	( 'sausage', 'Snack', 4, 145 ),
	( 'bread', 'Snack', 6, 150 ),
	( 'chicken feet', 'Snack', 5, 155 ),
	( 'duck neck', 'Snack', 5, 150 ),
	( 'onion ring', 'Snack', 5, 50 ),
	( 'toast', 'Snack', 2, 50 ),
	( 'waffle', 'Snack', 5, 50 ),
	( 'twist', 'Snack', 3, 200 ),
	( 'beef jerky', 'Snack', 10, 100 ),
	( 'potato', 'Vegetable', 1.2, 10 ),
	( 'loofah', 'Vegetable', 6, 10 ),
	( 'mushroom', 'Vegetable', 12, 15 ),
	( 'radish', 'Vegetable', 1, 15 ),
	( 'green bean', 'Vegetable', 5, 15 ),
	( 'enoki mushroom', 'Vegetable', 5, 10 ),
	( 'pea tip', 'Vegetable', 6, 5 ),
	( 'tomato', 'Vegetable', 2.5, 15 ),
	( 'sweet potato', 'Vegetable', 0.8, 5 ),
	( 'ginger', 'Vegetable', 8.8, 5 ),
	( 'chili', 'Vegetable', 9.8, 8 ),
	( 'green vegetable', 'Vegetable', 4, 20 ),
	( 'leek', 'Vegetable', 5, 10 ),
	( 'pleurotus eryngii', 'Vegetable', 5.5, 8 ),
	( 'onion', 'Vegetable', 1.5, 10 ),
	( 'coriander', 'Vegetable', 8, 10 ),
	( 'fungus', 'Vegetable', 6, 20 ),
	( 'spinach', 'Vegetable', 4, 20 ),
	( 'lettuce', 'Vegetable', 4, 15 ),
	( 'chinese cabbage', 'Vegetable', 3, 20 ),
	( 'eggplant', 'Vegetable', 3, 10 ),
	( 'pork ribs', 'Meat', 19, 8 ),
	( 'pork belly', 'Meat', 12.5, 20 ),
	( "pig' s foot", 'Meat', 8, 8 ),
	( 'pork steak', 'Meat', 12.5, 8 ),
	( 'pork chop', 'Meat', 11.5, 8 ),
	( 'pork filling', 'Meat', 11, 7 ),
	( 'pig hind leg', 'Meat', 11.5, 10 ),
	( 'beef fillet', 'Meat', 35, 15 ),
	( 'ox tongue', 'Meat', 30, 15 ),
	( 'beef spare ribs', 'Meat', 25, 30 ),
	( 'bull foreleg', 'Meat', 33, 15 ),
	( 'ox back push', 'Meat', 33, 15 ),
	( 'Fatted cow', 'Meat', 33, 20 ),
	( 'beef kidney', 'Meat', 15, 10 ),
	( 'lamb kidney', 'Meat', 16, 10 ),
	( 'lamb spareribs', 'Meat', 32, 20 ),
	( 'leg of lamb', 'Meat', 25, 20 ),
	( 'sheep OUTER waist', 'Meat', 40, 6 ),
	( 'chicken neck', 'Meat', 5, 10 ),
	( 'chicken breast', 'Meat', 7.5, 15 ),
	( 'chicken gizzard', 'Meat', 12, 15 ),
	( 'chicken wing', 'Meat', 23, 15 ),
	( 'milk', 'Drink', 3, 150 ),
	( 'coffee', 'Drink', 8, 100 ),
	( 'tea', 'Drink', 5, 150 ),
	( 'milk tea', 'Drink', 12, 70 ),
	( 'iced black tea', 'Drink', 4, 60 ),
	( 'wangzai milk', 'Drink', 5, 50 ),
	( 'oolong tea', 'Drink', 5, 70 ),
	( 'wang laoji', 'Drink', 3, 50 ),
	( 'jasmine tea', 'Drink', 5, 60 ),
	( "honey and grapefruit water", 'Drink', 9, 80 ),
	( 'water', 'Drink', 3, 300 ),
	( 'chocolate milk', 'Drink', 4, 50 ),
	( 'strawberry milk', 'Drink', 4, 40 ),
	( 'red bull', 'Drink', 6, 50 ),
	( 'beer', 'Drink', 6, 100 ),
	( 'wine', 'Drink', 180, 80 ),
	( 'liquor', 'Drink', 225, 50 ),
	( 'lemon tea', 'Drink', 3, 80 ),
	( 'sour plum juice', 'Drink', 8, 30 ),
	( 'water soluble c', 'Drink', 6, 50 );
	
```
