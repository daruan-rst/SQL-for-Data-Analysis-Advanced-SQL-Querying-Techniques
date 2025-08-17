-- Message from Mandy Smore: 
 -- "
 -- We've learned that there is a discrepancy 
 -- between our orders and products tables in the candy database.
 -- 
 -- Could you use your JOIN knowledge to figure out which 
 -- products exist in one table, but not the other?
 -- 
 -- Thanks and Happy Halloween!
 -- Mandy
 -- "

-- The result shall be displayed as product_id | product_name | product_id_in_orders

-- a) Connect to database (MySQL)
USE maven_advanced_sql;

-- b) Queries to view the information on each table

SELECT * FROM orders o 

SELECT * FROM products p 

-- c) Products that exists on the order table, but not on the products table

SELECT p.product_id, p.product_name, o.product_id  as product_id_in_orders 
FROM orders o 
LEFT JOIN products p 
ON p.product_id = o.product_id 
WHERE p.product_id IS NULL

-- d) Products that exists on the products table, but not on the order table

SELECT p.product_id, p.product_name, o.product_id  as product_id_in_orders 
FROM orders o 
RIGHT JOIN products p 
ON p.product_id = o.product_id 
WHERE o.product_id IS NULL