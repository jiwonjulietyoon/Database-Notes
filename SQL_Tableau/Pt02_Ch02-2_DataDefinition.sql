-- LINE COMMENT

/*
BLOCK COMMENT
*/

-- Highlight + F5 to run selected queries only


/* ______________________________________________________________________________ */


/* Create new database */
CREATE DATABASE EDU


/* Use database */
USE EDU;   -- Use database


/* Create new table */
CREATE TABLE [ȸ�����̺�] (
	[ȸ����ȣ] VARCHAR(20) PRIMARY KEY,
	[�̸�] VARCHAR(20),
	[����] VARCHAR(2),
	[����] INT,
	[���Աݾ�] MONEY,
	[��������] DATE NOT NULL,
	[���ŵ���] BIT
);


/* Add new column to existing table */
ALTER TABLE [ȸ�����̺�] ADD [������] REAL; 


/* Update column data type */
ALTER TABLE [ȸ�����̺�] ALTER COLUMN [������] INT;


/* Change table name */
SP_RENAME '[ȸ�����̺�]', 'MEMBER';


/* Change column name */
SP_RENAME '[ȸ�����̺�].[������]', '������(kg)';


/* Empty table (delete all rows) */
TRUNCATE TABLE [MEMBER];


/* Delete entire table */
DROP TABLE [MEMBER];

