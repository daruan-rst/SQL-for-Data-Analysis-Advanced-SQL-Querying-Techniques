-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. View the students table
SELECT * FROM students;

-- 2. The big 6
SELECT grade_level, AVG(GPA) AS avg_gpa
FROM students
WHERE school_lunch = 'Yes'
GROUP BY grade_level
HAVING avg_gpa < 3.3
ORDER BY grade_level;

-- 3. Common Keywords

-- DISTINCT
SELECT DISTINCT grade_level 
FROM students s 


-- COUNT
SELECT COUNT( DISTINCT grade_level) 
FROM students s 

-- MAX and MIN
SELECT MAX(gpa) - min(gpa) AS gpa_range
FROM students s 

-- AND
SELECT * 
FROM students s 
WHERE grade_level < 12
AND school_lunch = 'Yes';


-- IN
SELECT * 
FROM students s 
WHERE grade_level IN (9,10,11)

-- IS NULL
SELECT * 
FROM students s 
WHERE email IS NOT NULL

-- LIKE
SELECT * 
FROM students s 
WHERE email LIKE '%.edu'

-- ORDER BY
SELECT * 
FROM students s 
ORDER BY gpa DESC;


-- LIMIT
SELECT * 
FROM students s 
LIMIT 5

-- CASE statements
SELECT student_name, grade_level,
	CASE WHEN grade_level = 9 THEN 'Freshman'
		WHEN grade_level = 10 THEN 'Sophomore'
		WHEN grade_level = 11 THEN 'Junior'
		ELSE 'Senior' END AS student_class
		FROM students s;

