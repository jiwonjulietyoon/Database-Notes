
/* Grant privilege */
GRANT SELECT, INSERT, UPDATE, DELETE     -- privileges to grant
ON [ȸ�����̺�]
TO MWS                -- to user
WITH GRANT OPTION;    -- allows user to give other users any privileges the user has


/* Revoke privilege */
REVOKE SELECT, INSERT, UPDATE, DELETE
ON [ȸ�����̺�] 
TO MMS
CASCADE;    -- Revoke privileges of other users previously granted by the above user