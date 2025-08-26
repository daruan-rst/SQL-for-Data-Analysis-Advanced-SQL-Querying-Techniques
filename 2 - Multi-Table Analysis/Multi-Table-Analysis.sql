-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. Basic joins
SELECT * FROM happiness_scores;
SELECT * FROM country_stats;

SELECT hs.year , hs.country, hs.happiness_score, 
cs.continent 
FROM happiness_scores hs 
		INNER JOIN country_stats cs 
	ON hs.country = cs.country ;


-- 2. Join types

-- -- 2.1 INNER JOIN
SELECT hs.year , hs.country, hs.happiness_score, 
		cs.country, cs.continent 
FROM happiness_scores hs 
		INNER JOIN country_stats cs 
	ON hs.country = cs.country;

-- -- -- the following queries result in no results, 
-- -- -- since while using an inner join, we will have no null values on intersections
SELECT hs.year , hs.country, hs.happiness_score, 
		cs.country, cs.continent 
FROM happiness_scores hs 
		INNER JOIN country_stats cs 
	ON hs.country = cs.country 
	WHERE hs.country IS NULL;

SELECT hs.year , hs.country, hs.happiness_score, 
		cs.country, cs.continent 
FROM happiness_scores hs 
		INNER JOIN country_stats cs 
	ON hs.country = cs.country 
	WHERE cs.country IS NULL;

-- -- 2.2 LEFT JOIN
-- -- -- with a LEFT JOIN we keep the country from the left table
-- -- -- Every country that does not match will show as a null on the 4th and 5th columns (country and continent)

SELECT hs.year , hs.country as 'left table country', hs.happiness_score, 
		cs.country as 'right table country', cs.continent 
FROM happiness_scores hs 
		LEFT JOIN country_stats cs 
	ON hs.country = cs.country;

-- -- -- The following query will list everything from the left table except values overlapped by the right table, 
-- -- -- since the values that have null (in the filtering clause WHERE ) are those present on the left table and that did not match the ON condition

SELECT hs.year , hs.country as 'left table country', hs.happiness_score, 
		cs.country as 'right table country', cs.continent 
FROM happiness_scores hs 
		LEFT JOIN country_stats cs 
	ON hs.country = cs.country
	WHERE cs.country IS NULL;

-- -- 2.3 RIGHT JOIN
-- -- -- with a RIGHT JOIN we keep the country from the right table
-- -- -- Every country that does not match will show as a null on the 1st, 2nd and 3rd columns (year, country and happiness_score)

SELECT hs.year , hs.country as 'left table country', hs.happiness_score, 
		cs.country as 'right table country', cs.continent 
FROM happiness_scores hs 
		RIGHT JOIN country_stats cs 
	ON hs.country = cs.country;

-- -- -- The following query will list everything from the right table except values overlapped by the left table, 
-- -- -- since the values that have null (in the filtering clause WHERE ) are those present on the right table and that did not match the ON condition

SELECT hs.year , hs.country as 'left table country', hs.happiness_score, 
		cs.country as 'right table country', cs.continent 
FROM happiness_scores hs 
		RIGHT JOIN country_stats cs 
	ON hs.country = cs.country
	WHERE hs.country IS NULL;

-- -- -- If we were to mantain the condition WHERE cs.country IS NULL; from the LEFT JOIN query 
-- -- -- on our RIGHT JOIN query we would get no results, 
-- -- -- since every row from the right table is present and, therefore, 
-- -- -- there are none rows with null value for country (our join condition on ON)

-- 2.4 FULL OUTER JOIN
-- -- -- FULL OUTER JOIN does not exist on MySQL. To perform a FULL OUTER JOIN we must combine left, right and inner joins

-- Query to get all of the country present on the left table, but not on the right 
SELECT DISTINCT (hs.country)
FROM happiness_scores hs 
		LEFT JOIN country_stats cs 
	ON hs.country = cs.country
	WHERE cs.country IS NULL;

-- Query to get all of the country present on the right table, but not on the left 
SELECT DISTINCT (cs.country)
FROM happiness_scores hs 
		RIGHT JOIN country_stats cs 
	ON hs.country = cs.country
	WHERE hs.country IS NULL;

SELECT hs.year , hs.country as 'left table country', hs.happiness_score, 
		cs.country as 'right table country', cs.continent 
FROM happiness_scores hs 
		RIGHT JOIN country_stats cs 
	ON hs.country = cs.country
	WHERE cs.country IS NULL;

        
-- 3. Joining on multiple columns

SELECT * FROM happiness_scores hs;

SELECT * FROM country_stats cs;

SELECT * FROM inflation_rates ir;

SELECT * 
FROM happiness_scores hs 
INNER JOIN inflation_rates ir 
ON hs.country = ir.country_name -- If we were to end the query right here, we would have a lot of repeated rows, since our join condition only takes into account our "country" column
AND hs.`year` = ir.`year` 


-- 4. Joinning multiple tables

SELECT * FROM happiness_scores dhs;

SELECT * FROM country_stats cs;

SELECT * FROM inflation_rates ir;

SELECT hs.`year` , hs.country , hs.happiness_score , 
		cs.continent, ir.inflation_rate 
FROM happiness_scores hs 
LEFT JOIN country_stats cs  
ON hs.country = cs.country 
LEFT JOIN inflation_rates ir 
ON hs.`year` = ir.`year` 
AND hs.country  = ir.country_name;

-- 5. Self joins

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary INT,
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, salary, manager_id) VALUES
	(1, 'Ava', 85000, NULL),
	(2, 'Bob', 72000, 1),
	(3, 'Cat', 59000, 1),
	(4, 'Dan', 85000, 2);

SELECT * FROM employees

-- Example 1: Finding the employees with the same salary

SELECT e1.employee_name, e1.salary,
		e2.employee_name, e2.salary
FROM employees e1
INNER JOIN employees e2
ON e1.salary = e2.salary -- If the query ended here we would see results that matched employees with themselves (since this is a self join and asserting for equal on only one value would have repeated rows)
WHERE e1.employee_name <> e2.employee_name; -- this criteria will filter for names that are not equal to each other -> but the problem is that a biderectional relationship should be displayed twice

SELECT e1.employee_name, e1.salary,
		e2.employee_name, e2.salary
FROM employees e1
INNER JOIN employees e2
ON e1.salary = e2.salary 
WHERE e1.employee_id > e2.employee_id ; -- this trick of comparing the ids solves the problem of duplicate lines

-- Example 2: Employees that have a greater salary
    
SELECT e1.employee_id, e1.employee_name, e1.salary,
		e2.employee_name, e2.salary
FROM employees e1
INNER JOIN employees e2
ON e1.salary > e2.salary
ORDER BY e1.employee_id

-- Example 3: Employees and their managers

SELECT e1.employee_id, e1.employee_name, e1.manager_id,
		e2.employee_name AS manager_name
FROM employees e1 -- In this example we want the manager_id to column to match the employee_id
LEFT JOIN employees e2 -- Insead of using an INNER JOIN, we will use a LEFT JOIN instead. With an inner join we would be joining two tables and expect all the rows to match. With a LEFT JOIN we can use the left table as a grounding table, diplaying all the data on the output 
ON e1.manager_id = e2.employee_id;

 
-- 6. Cross joins

    
-- 7. Union vs union all