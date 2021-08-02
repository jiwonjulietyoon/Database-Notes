SELECT * FROM [Order];
SELECT * FROM [Member];


/* INNER JOIN */
SELECT *
FROM [Member] AS M
INNER JOIN [Order] AS O
ON M.mem_no = O.mem_no;


/* OUTER JOIN (LEFT) */
SELECT *
FROM [Member] M
LEFT JOIN [Order] O
ON M.mem_no = O.mem_no;


/* OUTER JOIN (RIGHT) */
SELECT *
FROM [Member] M
RIGHT JOIN [Order] O
ON M.mem_no = O.mem_no;


/* FULL OUTER JOIN */    --Not supported on MySQL
SELECT *
FROM [Member] M
FULL JOIN [Order] O
ON M.mem_no = O.mem_no;


/* CROSS JOIN */
SELECT *
FROM [Member] M
CROSS JOIN [Order] O
WHERE M.mem_no = '1000001';  -- omitting this clause will result in 


/* SELF JOIN */

