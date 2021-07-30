/* MEMOS

-- LINE COMMENT

/*
BLOCK COMMENT
*/

[] Square brackets around table/column name when keywords, special characters, spaces are used

Highlight + F5 to run selected queries only

*/
/* ______________________________________________________________________________ */


/* Create new database */
CREATE DATABASE EDU


/* Use database */
USE EDU;   -- Use database


/* Create new table */
CREATE TABLE [회원테이블] (
	[회원번호] VARCHAR(20) PRIMARY KEY,
	[이름] VARCHAR(20),
	[성별] VARCHAR(2),
	[나이] INT,
	[가입금액] MONEY,
	[가입일자] DATE NOT NULL,
	[수신동의] BIT
);


/* Add new column to existing table */
ALTER TABLE [회원테이블] ADD [몸무게] REAL; 


/* Update column data type */
ALTER TABLE [회원테이블] ALTER COLUMN [몸무게] INT;


/* Change table name */
SP_RENAME '[회원테이블]', 'MEMBER';


/* Change column name */
SP_RENAME '[회원테이블].[몸무게]', '몸무게(kg)';


/* Empty table (delete all rows) */
TRUNCATE TABLE [MEMBER];
-- OR
DELETE FROM [회원테이블];


/* Delete entire table */
DROP TABLE [MEMBER];

