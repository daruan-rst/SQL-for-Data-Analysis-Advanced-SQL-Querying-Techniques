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

-- -- the following query 
        
-- 3. Joining on multiple columns

-- 5. Self joins

        
-- 6. Cross joins

    
-- 7. Union vs union all