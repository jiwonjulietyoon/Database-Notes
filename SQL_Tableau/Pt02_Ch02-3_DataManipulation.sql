
/* Use database */
USE EDU;


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


/* Insert new rows */
INSERT INTO  [회원테이블]  VALUES ('A10001', '모원서', '남', 33, 100000, '2020-01-01', 1);
INSERT INTO  [회원테이블]  VALUES ('A10002', '김영화', '여', 29, 200000, '2020-01-02', 0);
INSERT INTO  [회원테이블]  VALUES ('A10003', '홍길동', '남', 29, 300000, '2020-01-03', NULL);


