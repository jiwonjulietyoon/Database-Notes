
/* Use database */
USE EDU;


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


/* Insert new rows */
INSERT INTO  [ȸ�����̺�]  VALUES ('A10001', '�����', '��', 33, 100000, '2020-01-01', 1);
INSERT INTO  [ȸ�����̺�]  VALUES ('A10002', '�迵ȭ', '��', 29, 200000, '2020-01-02', 0);
INSERT INTO  [ȸ�����̺�]  VALUES ('A10003', 'ȫ�浿', '��', 29, 300000, '2020-01-03', NULL);


