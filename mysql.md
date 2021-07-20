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

 ##### Add column

```sqlite
ALTER TABLE tblName
ADD COLUMN colName DATATYPE;
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

##### Update existing record

```sql
UPDATE tblName
SET colName1 = newValue1, colName2 = newValue2
WHERE colName = value;
```

##### Delete record

```sqlite
DELETE FROM tblName
WHERE colName = value;     -- e.g) WHERE colName IS NULL
```

#### Delete table

```sql
DROP TABLE tblName;
```

#### Copy table from different database

```sql
CREATE TABLE destinationDB.tblName LIKE sourceDB.tblName;
INSERT INTO destinationDB.tblName SELECT * FROM sourceDB.tblName;
```

> Need to create table first before attempting to copy
>
> Database name may be omitted if copying within same database







.

# SELECT (table)

```sql
SELECT colName           -- mandatory
FROM tblName           -- mandatory
[WHERE colName ~~~ ]
[ORDER BY colName]
[LIMIT int]
;
```

#### SELECT: select which columns or calculated values to display

- `SELECT *` : all columns
- `SELECT colName1, colName2` : display values of only _colName1_ and _colName2_
- `SELECT DISTINCT colName`: display all values of _colName_ after eliminating duplicates
- `SELECT COUNT(*)` : display the total number of all records
  - `SELECT COUNT(DISTINCT colName)` : number of rows with unique _colName_
- `SELECT MAX(colName)` : display the maximum value of _colName_
- `SELECT AVG(colName)` : display the average value of _colName_
- `SELECT colName AS newColName` : rename _colName_ to _newColName_
  - `SELECT colName AS 'new Col Name'` : use single quotes if alias name contains spaces
- `SELECT concat(colName1, ' ', colName2) AS combinedColName`: combine multiple columns into a single new column

#### WHERE : set a specific condition for which records to select

- `WHERE colName = value` : `=`, `==`, `is`, `>`, `<`, `>=`, `<=` may also be used
  - `!=`, `<>` means 'is not equal to'
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

- `SELECT * FROM tblName GROUP BY colName;` : Select first occurring row from each distinct _colName_ group. (Total number of rows is equal to number of distinct _colName_ values)
- `SELECT District, COUNT(*) AS 'Number of Cities' FROM cities GROUP BY District;`
  - Shows district list with total number of cities per 'district' group

