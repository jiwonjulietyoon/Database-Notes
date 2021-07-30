
/* Grant privilege */
GRANT SELECT, INSERT, UPDATE, DELETE     -- privileges to grant
ON [회원테이블]
TO MWS                -- to user
WITH GRANT OPTION;    -- allows user to give other users any privileges the user has


/* Revoke privilege */
REVOKE SELECT, INSERT, UPDATE, DELETE
ON [회원테이블] 
TO MMS
CASCADE;    -- Revoke privileges of other users previously granted by the above user