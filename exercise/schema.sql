#create database testdb;
use testdb;

CREATE TABLE people
(
    id INTEGER AUTO_INCREMENT,
    name TEXT,
    PRIMARY KEY (id)
);
insert into people (id, name) values (100, 'cento');
#LOAD DATA INFILE '/var/lib/mysql-files/people.csv' INTO TABLE people FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
