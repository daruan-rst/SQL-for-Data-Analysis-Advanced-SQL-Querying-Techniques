-- Message from Mandy Smore: 
 -- "
 -- Hi again, 
 -- Our Marketing team wants to do some analysis to identify
 -- which of our products are similar in terms of price

 -- Could you write a query to determine which products are
 -- within 25 cents of each other in terms of unit price and
 -- return a list of all the candy pairs

 -- Thanks!
 -- Mandy
 -- "

-- The result shall be displayed as  product_name | unit_price | product_name | price_diff

-- a) Connect to database (MySQL)
USE maven_advanced_sql;

-- b) Queries to view the information on the products table

SELECT * FROM products p 

-- c) Products whose price diff is within 25 cents from each other. This query will show a negative diff

SELECT p1.product_name, p1.unit_price, 
		p2.product_name, p2.unit_price, 
		(p1.unit_price - p2.unit_price) as price_diff 
FROM products p1
INNER JOIN products p2
ON p1.unit_price - p2.unit_price > -0.25
AND p1.unit_price - p2.unit_price <= 0.25
AND p1.product_id > p2.product_id 
ORDER BY price_diff DESC;

-- d) Course solution 1
SELECT p1.product_name, p1.unit_price, 
		p2.product_name, p2.unit_price, 
		p1.unit_price - p2.unit_price as price_diff 
FROM products p1
INNER JOIN products p2
ON p1.product_id <> p2.product_id
WHERE p1.unit_price - p2.unit_price BETWEEN -0.25 AND 0.25;

--  e) Course solution 2
SELECT p1.product_name, p1.unit_price, 
		p2.product_name, p2.unit_price, 
		p1.unit_price - p2.unit_price as price_diff 
FROM products p1
INNER JOIN products p2
ON p1.product_id <> p2.product_id
WHERE ABS(p1.unit_price - p2.unit_price) < 0.25
AND p1.product_name < p2.product_name 
ORDER BY price_diff DESC;

