-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. Subqueries in the SELECT clause
SELECT * FROM happiness_scores;

-- Average happiness score
SELECT AVG(happiness_score) FROM happiness_scores;

-- Happiness score deviation from the average
SELECT	year, country, happiness_score,
		(SELECT AVG(happiness_score) FROM happiness_scores) AS avg_hs,
        happiness_score - (SELECT AVG(happiness_score) FROM happiness_scores) AS diff_from_avg
FROM	happiness_scores;

-- 2. Subqueries in the FROM clause
SELECT * FROM happiness_scores hs 

 --  Average happiness score for each country

SELECT hs.country, AVG(hs.happiness_score) as avg_hs_by_country
FROM happiness_scores hs 
GROUP BY hs.country 

/* Return a country's happiness score for the year as well as
 the average happiness score for the country across the years */

SELECT hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM happiness_scores hs 
LEFT JOIN (SELECT hs.country, AVG(hs.happiness_score) as avg_hs_by_country
			FROM happiness_scores hs 
			GROUP BY hs.country ) AS country_hs
ON country_hs.country = hs.country
WHERE hs.country = 'United States';
            
-- 3. Multiple subqueries



-- 4. Subqueries in the WHERE and HAVING clauses


-- 5. ANY vs ALL

-- 6. EXISTS

     
-- 7. CTEs: Readability

   
-- 8. CTEs: Reusability
        


-- 9. Multiple CTEs



-- 10. Recursive CTEs



-- 11. Subquery vs CTE vs Temp Table vs View

