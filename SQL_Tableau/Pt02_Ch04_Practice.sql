
/* 4-1 ������ ��ȸ (SELECT) */

/* 1. Order ���̺��� ��� �� ��ȸ */
SELECT * 
FROM [Order];


/* 2. [shop_code] 30 �̻����θ� ���� */
SELECT * 
FROM [Order]
WHERE [shop_code] >= 30;


/* 3. [mem_no] �� [sales_amt] �հ� ���ϱ� */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
WHERE [shop_code] >= 30
GROUP BY [mem_no];


/* 4. [sales_amt] �հ谡 100000 �̻����θ� ���� */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
WHERE [shop_code] >= 30
GROUP BY [mem_no]
HAVING SUM(sales_amt) >= 100000;


/* 5. [sales_amt] �հ谡 ���� ������ ���� */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
WHERE [shop_code] >= 30
GROUP BY [mem_no]
ORDER BY [tot_amt] DESC;





/* 4-2 ������ ��ȸ (SELECT) + ���� (JOIN) + �������� (Subquery) */

/* 1. Order ���̺� �������� Member ���̺��� left join */
SELECT *
FROM [Order] AS Ord
LEFT JOIN [Member] AS Mem
ON Ord.Mem_no = Mem.Mem_no;


/* 2. [gender]�� [sales_amt] �հ� ���ϱ� */
SELECT Mem.gender, SUM(Ord.sales_amt) AS tot_amt
FROM [Order] AS Ord
LEFT JOIN [Member] AS Mem
ON Ord.Mem_no = Mem.Mem_no
GROUP BY Mem.gender;


/* 3. [gender], [addr] �� [sales_amt] �հ� ���ϱ� */
SELECT Mem.gender, Mem.addr, SUM(Ord.sales_amt) AS tot_amt
FROM [Order] AS Ord
LEFT JOIN [Member] AS Mem
ON Ord.Mem_no = Mem.Mem_no
GROUP BY Mem.gender, Mem.addr;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* 1. [Order] ���̺��� [mem_no] �� [sales_amt] �հ� ���ϱ� */
SELECT [mem_no], SUM(sales_amt) AS tot_amt
FROM [Order]
GROUP BY [mem_no];

/* 2. (1)�� FROM�� ���� ������ ����Ͽ�, [Member] ���̺��� Left Join �ϱ� */
SELECT *
FROM (
	SELECT [mem_no], SUM(sales_amt) AS tot_amt
	FROM [Order]
	GROUP BY [mem_no]
	) AS tbl_tot_amt
LEFT JOIN [Member] AS Mem
ON tbl_tot_amt.mem_no = Mem.mem_no;


/* 3. [gender], [addr] �� [tot_amt] �հ� ���ϱ� */

SELECT Mem.gender, Mem.addr, SUM(tot_amt) AS �հ�
FROM (
	SELECT [mem_no], SUM(sales_amt) AS tot_amt
	FROM [Order]
	GROUP BY [mem_no]
	) AS tmp
LEFT JOIN [Member] AS Mem
ON Mem.mem_no = tmp.mem_no
GROUP BY Mem.gender, Mem.addr;

