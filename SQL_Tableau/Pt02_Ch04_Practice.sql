
/* 4-1 데이터 조회 (SELECT) */

/* 1. Order 테이블의 모든 열 조회 */
SELECT * 
FROM [Order];


/* 2. [shop_code] 30 이상으로만 필터 */
SELECT * 
FROM [Order]
WHERE [shop_code] >= 30;


/* 3. [mem_no] 별 [sales_amt] 합계 구하기 */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
WHERE [shop_code] >= 30
GROUP BY [mem_no];


/* 4. [sales_amt] 합계가 100000 이상으로만 필터 */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
WHERE [shop_code] >= 30
GROUP BY [mem_no]
HAVING SUM(sales_amt) >= 100000;


/* 5. [sales_amt] 합계가 높은 순으로 정렬 */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
WHERE [shop_code] >= 30
GROUP BY [mem_no]
ORDER BY [tot_amt] DESC;





/* 4-2 데이터 조회 (SELECT) + 결합 (JOIN) + 서브쿼리 (Subquery) */

/* 1. Order 테이블 기준으로 Member 테이블을 left join */
SELECT *
FROM [Order] AS Ord
LEFT JOIN [Member] AS Mem
ON Ord.Mem_no = Mem.Mem_no;


/* 2. [gender]별 [sales_amt] 합계 구하기 */
SELECT Mem.gender, SUM(Ord.sales_amt) AS tot_amt
FROM [Order] AS Ord
LEFT JOIN [Member] AS Mem
ON Ord.Mem_no = Mem.Mem_no
GROUP BY Mem.gender;


/* 3. [gender], [addr] 별 [sales_amt] 합계 구하기 */
SELECT Mem.gender, Mem.addr, SUM(Ord.sales_amt) AS tot_amt
FROM [Order] AS Ord
LEFT JOIN [Member] AS Mem
ON Ord.Mem_no = Mem.Mem_no
GROUP BY Mem.gender, Mem.addr;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* 1. [Order] 테이블의 [mem_no] 별 [sales_amt] 합계 구하기 */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
GROUP BY [mem_no];

/* 2. (1)을 FROM절 서브 쿼리를 사용하여, [Member] 테이블을 Left Join 하기 */
SELECT *
FROM (
	SELECT [mem_no], SUM(sales_amt) AS tot_amt
	FROM [Order]
	GROUP BY [mem_no]
	) AS tbl_tot_amt
LEFT JOIN [Member] AS Mem
ON tbl_tot_amt.mem_no = Mem.mem_no;


/* 3. [gender], [addr] 별 [tot_amt] 합계 구하기 */

SELECT Mem.gender, Mem.addr, SUM(tot_amt) AS 합계
FROM (
	SELECT [mem_no], SUM(sales_amt) AS tot_amt
	FROM [Order]
	GROUP BY [mem_no]
	) AS tmp
LEFT JOIN [Member] AS Mem
ON Mem.mem_no = tmp.mem_no
GROUP BY Mem.gender, Mem.addr;

