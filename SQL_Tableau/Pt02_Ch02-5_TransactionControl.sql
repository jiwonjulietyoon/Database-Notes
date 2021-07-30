/* Transaction */

BEGIN TRAN

SELECT * FROM [회원테이블]

DELETE FROM [회원테이블]

SELECT * FROM [회원테이블]

ROLLBACK

SELECT * FROM [회원테이블]



-- 작성 중..
