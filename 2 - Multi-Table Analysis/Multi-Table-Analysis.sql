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

        
-- 3. Joining on multiple columns

-- 5. Self joins

        
-- 6. Cross joins

    
-- 7. Union vs union all