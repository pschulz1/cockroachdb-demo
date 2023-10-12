CREATE DATABASE demo;

USE demo;

CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    price INT,
    currency STRING,
    number_of_items int,
    country STRING
);