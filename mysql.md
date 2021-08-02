# Initiation

`MySQL 8.0 Command Line Client` 실행 후 비번 입력

#### Show users

> User list is in `mysql` database > `user` table.

```sql
USE mysql;
SELECT User FROM user;
```

#### Using MySQL Workbench

Database > Connect to Database

////

#### Naming conventions

- Common
  - plural form
  - use backticks ``  `...` `` when:
    - keywords, some special characters (e.g. `.`), spaces are used in column names or identifiers
- Tables
  - lowerCamelCase with `tbl` prefix (e.g `tblBooks`)
- Views
  - UpperCamelCase with `vw_` prefix (e.g `vw_Books`)

.

# Database

#### Show all databases

```sql
SHOW DATABASES;
```

#### Create new database

```sql
CREATE DATABASE dbName;
USE dbName;  -- also for switching to different database
```

#### Show current database

```sql
SELECT DATABASE();
```

#### Delete database;

```sql
DROP DATABASE dbName;
```

.

# Table 

> Need to select a specific database first with `USE dbName;`

#### Show all tables

```sql
show tables;
```

#### Create new table

```sqlite
CREATE TABLE tblName (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    address TEXT NOT NULL
);
```

- _tblName_: usually a plural form
- Data Type : `INTEGER`, `TEXT`, `REAL`
- `PRIMARY KEY` : 
  - may be labeled to one column only (usually id)
- `AUTOINCREMENT`: can only be used on integer values
  - `PRIMARY KEY` & `AUTOINCREMENT`
    - usually used on id's
    - an id number is automatically assigned to every new record inserted without a specified id.
    - the id remains unique to all records, including the deleted ones (id 1, 2, 3 중 3을 삭제한 후 새로운 레코드를 추가하면, 자동으로 4번이 부여된다.)
- other options: `DEFAULT = defaultValue`, `UNIQUE`
  - `UNIQUE`: values must be unique for each record. Multiple columns may be labeled 'UNIQUE'

#### Edit existing table

##### Change table name

```sql
ALTER TABLE oldTblName
RENAME TO newTBLName;
```

 ##### Add column

```sqlite
ALTER TABLE tblName
ADD COLUMN colName DATATYPE;
```

##### Change column name

```sql
ALTER TABLE tblName
RENAME COLUMN oldColName TO newColName;
```

##### Change column data type

```sql
ALTER TABLE tblName
ALTER COLUMN colName NEW_DATATYPE;
```

##### Delete column

```sqlite
ALTER TABLE tblName
DROP COLUMN colName;
```

##### Add new record

```sqlite
INSERT INTO tblName (colName1, colName2)
VALUES (value1, value2);
```

- `(colName1, colName2)` may be omitted if it includes all available columns
- single quotes around text or date values
  - e.g) `'Jane Doe'`, `'2021-07-29'`

##### Update existing record

```sql
UPDATE tblName
SET colName1 = newValue1, colName2 = newValue2
WHERE colName = value;
```

> To update columns of all records to a certain uniform value, omit the `WHERE` clause.

##### Delete record

```sqlite
DELETE FROM tblName
WHERE colName = value;     -- e.g) WHERE colName IS NULL
```

#### Delete table

```sql
TRUNCATE TABLE tblName;
```

```sql
DELETE FROM tblName;
```

> Empties table (delete all rows)
>
> - Drops entire table and recreates (rather than deleting row by row)

```sql
DROP TABLE tblName;
```

> Deletes entire table

#### Copy table from different database

```sql
CREATE TABLE destinationDB.tblName LIKE sourceDB.tblName;
INSERT INTO destinationDB.tblName SELECT * FROM sourceDB.tblName;
```

> Need to create table first before attempting to copy
>
> Database name may be omitted if copying within same database


#### Check column data type

##### Return column info of entire table

```sql
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblName'
ORDER BY ORDINAL_POSITION;
```

##### Return data type of a specific column

```sql
SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblName' AND COLUMN_NAME = 'colName'
```



.

# SELECT (table)

```sql
SELECT colName [AS short]          -- mandatory
FROM tblName [AS short]           -- mandatory
[JOIN tblName2 ON tblName.colName = tblName2.colName]
[WHERE colName ~~~ ]
[GROUP BY colName]
[HAVING colName ~~~]
[ORDER BY colName]
[LIMIT int]
;
```

> **[문법 순서]** SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT
> **[실행 순서]** FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT

#### SELECT: select which columns or calculated values to display

- `SELECT *` : all columns
- `SELECT colName1, colName2` : return values of only _colName1_ and _colName2_
- `SELECT longColumnName AS shortNm` : Assign alias to column name
  - `AS` may be omitted -> `SELECT longColumnName shortNm`
- `SELECT DISTINCT colName`: return all values of _colName_ after eliminating duplicates
- `SELECT COUNT(*)` : return the total number of all records
  - `SELECT COUNT(DISTINCT colName)` : number of rows with unique _colName_
- `SELECT MAX(colName)` : return the maximum value of _colName_
- `SELECT AVG(colName)` : return the average value of _colName_
- `SELECT colName AS newColName` : rename _colName_ to _newColName_
  - `SELECT colName AS 'new Col Name'` : use single quotes if alias name contains spaces
- `SELECT concat(colName1, ' ', colName2) AS combinedColName`: combine multiple columns into a single new column

#### FROM : designate source table

- `FROM fullTableName AS shortNm`: assign alias for table name
  - `SELECT colName FROM fullTableName` 
    => `SELECT shortNm.colName FROM fullTableName AS shortNm`

#### JOIN : retrieve data from multiple tables

```sql
SELECT base.col, added.col, ...
FROM baseTbl AS base
[LEFT/RIGHT] JOIN addedTbl AS added
ON base.col = added.col || USING (commonCol)

[WHERE ...]
[ORDER BY ...]
[...]
```

> Resulting table will place `baseTbl` columns on the left, and then append corresponding `addedTbl` columns on the right

> May use `USING` instead of `ON` if the matched columns have identical names. But `USING` will place the mentioned column(s) only once at the very left of the resulting table, rather than once for each table in the respective original order.

##### INNER JOIN (simple join) : intersection

- `SELECT * FROM tbl1 JOIN tbl2 ON tbl1.col = tbl2.col`
  - return intersecting records of `tbl1` and `tbl2`, where the `tbl1.col = tbl2.col` condition is met
  - 한쪽 테이블에만 들어있거나 위 조건에 의해 매칭 안 되는 레코드는 생략됨

##### OUTER (LEFT/RIGHT) JOIN : 

- ```sql
  SELECT ...
  FROM baseTbl AS base
  LEFT JOIN addedTbl AS added
  ON ....
  ```

  - Return all rows from `baseTbl` + add corresponding rows from `addedTbl` even if there are null values

- `FROM baseTbl LEFT JOIN addedTbl` == `FROM addedTbl RIGHT JOIN baseTbl`

##### CROSS JOIN:

- Return a paired combination of each row from the joined tables (when no `WHERE` clause is used)
- `ON` clause cannot be used

##### Self JOIN:





#### WHERE : set a specific condition for which records to select

- `WHERE colName = value` : `=`, `==`, `is`, `>`, `<`, `>=`, `<=` may also be used
  - `!=`, `<>` means 'is not equal to'
    - `IS NULL`, `IS NOT NULL`
- `WHERE colName LIKE 'The %'` : display records whose colName starts with "The "
  - `%word` : ends with "word"
  - `%word%` : includes "word"
- `WHERE colName BETWEEN 'A' and 'J'`: display records whose colName starts with a letter between "A" and "J" (INCLUSIVE of "A", NOT INCLUSIVE of "J")
- `WHERE colName BETWEEN 1 and 10`: display records whose colName is between 1 and 10 (INCLUSIVE of both 1 and 10)
- `WHERE colName1 = value1 AND colName2 = value2`: set multiple conditions with `AND` or `OR`
- `WHERE colName >= (SELECT AVG(colName) FROM tblName)`: select rows with column values greater than the average
- `WHERE colName IN ('value1', 'value2')` : select rows with columns with multiple possible values

#### ORDER BY : sort selected records by specified columns

- `ORDER BY colName1, colName2`: _colName1_ is the primary sorting standard while _colName2_ is the secondary standard
- `ORDER BY colName1 ASC, colName2 DESC` : DESC => sort in descending order (default is ascending order)

#### LIMIT : maximum number of selected records to display

- `LIMIT 10` : display the first 10 records from the selected & sorted list
- `LIMIT 10 OFFSET 2` : display the first 10 records AFTER ignoring the first two -> Thus, display 10 records from #3 to #12

#### GROUP BY

- `SELECT * FROM tblName GROUP BY colName;` : Select first occurring row (or, may be a random selection) from each distinct _colName_ group. (Total number of rows is equal to number of distinct _colName_ values)
  - Although MySQL will not raise an error, selecting columns that are neither contained in an aggregate function nor the GROUP BY clause is essentially meaningless, as MySQL will return random values from each group.
- `SELECT District, COUNT(*) AS 'Number of Cities' FROM cities GROUP BY District;`
  - Shows district list with total number of cities per 'district' group

#### HAVING

- Filters the results of the `GROUP BY` clause
  (similar to the `WHERE` clause, except `WHERE` filters the entire table prior to being grouped)

  ```sql
  SELECT col1, col2, COUNT(*) FROM tblName
  GROUP BY col1, col2
  HAVING COUNT(*) > 10;
  ```

  

#### Subqueries

- Usually nested within `SELECT`, `FROM`, `WHERE`

##### Within `SELECT`

- Used like a _column_

- Not really used since it virtually has the same effect as a `JOIN` clause

  ```sql
  SELECT *
  	, (SELECT colName
          FROM addedTbl AS added
          WHERE base.matchingCol = added.matchingCol) AS colName
  FROM baseTbl AS base
  ```

##### Within `FROM`

- Used like a _table_ ("inline view subquery")

- Ex) Return rows w/ max column value per group

  ```sql
  SELECT * 
  FROM (
  	SELECT groupNm, MAX(colNm) as maxVal
      FROM tblNm 
      GROUP BY groupNm
  ) AS m
  JOIN tblNm AS t
  ON t.groupNm = m.groupNm AND t.colNm = m.maxVal;
  ```
  - Multiple rows (with same max column value) may be returned per group

##### Within `WHERE`

- Ex) Return rows w/ max column value per group

  ```sql
  SELECT *
  FROM tblNm
  WHERE colNm = (
  	SELECT MAX(colNm) 
      FROM tblNm AS t
      WHERE t.groupNm = tblNm.groupNm
  );
  ```

  - Multiple rows (with same max column value) may be returned per group



# UNION

Combines the result sets of 2 or more `SELECT` statements (duplicate rows are omitted)

```sql
(SELECT ... FROM ...)
UNION
(SELECT ... FROM ...)
```



# VIEWS

Save the resulting table from an SQL statement. (Saved into `Views` within the same database) Other SQL statements can refer to this view in the same way as regular tables.

```sql
CREATE VIEW viewName AS
SELECT ....
FROM ....
```

```sql
SELECT ... FROM viewName ...
```





# Privileges

#### Grant privilege

```sql
GRANT [SELECT, INSERT, UPDATE, DELETE]
ON tblName
TO userName
[WITH GRANT OPTION];  -- allows user to give other users any privileges the user has
```

#### Revoke privilege

```sql
REVOKE [SELECT, INSERT, UPDATE, DELETE]
ON tblName
TO userName;
```





# Transaction

> A sequential group of statements to perform as a single work unit that can be committed or rolled back.
>
> If the transaction makes multiple modifications into the database:
>
> - If all modifications are successful => Transaction is committed
> - If at least one modification fails => Transaction is rolled back and all modifications are undone

(In progress..)

