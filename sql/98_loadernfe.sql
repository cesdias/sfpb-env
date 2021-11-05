--CREATE USER loadernfeuser WITH PASSWORd 'ruM8ieSh';
--CREATE DATABASE loadernfe;

-- REVOKE ALL ON DATABASE loadernfe FROM public;
--ALTER DATABASE loadernfe OWNER TO loadernfeuser;
--GRANT CONNECT ON DATABASE loadernfe to loadernfeuser;
-- ALTER ROLE loadernfeuser SET search_path TO public,statistics;

-- change database and user
--\connect loadernfe loadernfeuser

-- schemas
--CREATE SCHEMA statistics;