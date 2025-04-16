-- Designing the Data Model

CREATE DATABASE swiggy_data;
USE swiggy_data;

-- Restaurant table

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    area VARCHAR(100),
    city VARCHAR(100),
    address VARCHAR(500),
    price DECIMAL(10,2),
    avg_ratings DECIMAL(3,2),
    total_ratings INT,
    delivery_time INT
);


-- Food category table
CREATE TABLE food_types (
    id INT PRIMARY KEY,
    name TEXT
);

CREATE TABLE restaurant_food_type (
    restaurant_id INT,
    food_type_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id),
    FOREIGN KEY (food_type_id) REFERENCES food_types(id)
);

-- Import data 'swiggy.csv' using MySQL Workbench’s Import Wizard OR
LOAD DATA INFILE 'C:\Users\utkarsh\OneDrive\Desktop\projects data set\swiggy.csv'
INTO TABLE restaurants
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, area, city, address, price, avg_ratings, total_ratings, food_type, delivery_time);

-- Top-rated restaurants
SELECT name, avg_ratings
FROM restaurants
ORDER BY avg_ratings DESC
LIMIT 10;

--Average delivery time by area
SELECT area, AVG(delivery_time) AS avg_delivery
FROM restaurants
GROUP BY area
ORDER BY avg_delivery;

--Most common cuisines
SELECT food_types.name, COUNT(*) AS restaurant_count
FROM restaurant_food_type
JOIN food_types ON restaurant_food_type.food_type_id = food_types.id
GROUP BY food_types.name
ORDER BY restaurant_count DESC;

--Price distribution by city
SELECT city, AVG(price) AS avg_price, MIN(price), MAX(price)
FROM restaurants
GROUP BY city;

--Correlation between ratings and delivery time
SELECT avg_ratings, delivery_time
FROM restaurants
WHERE total_ratings > 50;






