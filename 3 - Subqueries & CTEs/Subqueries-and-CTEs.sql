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

            
-- 3. Multiple subqueries



-- 4. Subqueries in the WHERE and HAVING clauses


-- 5. ANY vs ALL

-- 6. EXISTS

     
-- 7. CTEs: Readability

   
-- 8. CTEs: Reusability
        


-- 9. Multiple CTEs



-- 10. Recursive CTEs



-- 11. Subquery vs CTE vs Temp Table vs View

