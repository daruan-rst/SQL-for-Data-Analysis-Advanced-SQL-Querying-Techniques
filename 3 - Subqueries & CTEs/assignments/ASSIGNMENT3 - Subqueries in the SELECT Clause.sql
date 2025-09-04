-- From Mandy Smore(Analyst, Maven Candies): 
 -- "
 -- Our product team plans on evaluating our product prices
 -- later this week to see if any adjustments need to be made 
 -- for next year. 

 -- Can you give me a list of our products from most to least 
 -- expensive, along with how much each product differs from 
 -- the average unit price?

 -- Thanks!
 -- Mandy
 -- "

-- RESULTS PREVIES: product_id | product_name | unit_price | avg_unit_price | diff_price

-- 0) Connect to database (MySQL)
USE maven_advanced_sql;

-- 1) Viewing the product table

SELECT * FROM products p;

-- 2) Subquery to find the average unit price

SELECT AVG(p.unit_price) FROM products p;

-- 3) Final Answer

SELECT p.product_id, p.product_name , p.unit_price, 
(SELECT AVG(p.unit_price) FROM products p) AS avg_unit_price, -- subquery from the last step
p.unit_price - (SELECT AVG(p.unit_price) FROM products p) AS diff_price
FROM products p
ORDER BY p.unit_price DESC;