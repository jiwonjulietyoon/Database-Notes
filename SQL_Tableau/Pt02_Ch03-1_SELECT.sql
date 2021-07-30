

/* Basic queries */
USE EDU;

SELECT * FROM [Member];

UPDATE [Member]
SET gender = 'male'
WHERE gender = 'man';

UPDATE [Member]
SET gender = 'female'
WHERE gender = 'women';

SELECT * FROM [Member]
WHERE gender = 'male';

/* *************************************************************** */

/* GROUP BY */

SELECT addr, COUNT(mem_no) AS [회원수집계] 
FROM [Member]
WHERE gender = 'male'
GROUP BY addr;


-- Unlike MySQL, the following will raise an error because one or more selected columns
--   are NOT contained in EITHER an aggregate function (e.g. COUNT, SUM) OR the GROUP BY clause.
SELECT *
FROM [Member]
WHERE gender = 'male'
GROUP BY addr;


SELECT addr, gender, COUNT(mem_no) AS [회원수집계]
FROM [Member]
WHERE gender = 'male'
GROUP BY addr, gender  -- group by 2 columns



/* HAVING */

SELECT addr, COUNT(mem_no) AS [회원수집계]
FROM [Member]
WHERE gender = 'male'
GROUP BY addr
HAVING COUNT(mem_no) >= 50;




/* *************************************************************** */

/* 문법 순서 및 실행 순서 */

-- 문법: SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT
-- 실행: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT