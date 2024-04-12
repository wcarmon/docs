-- See https://www.postgresql.org/docs/current/sql-createrole.html
-- See https://www.postgresql.org/docs/current/sql-grant.html


-- ============================
-- app_user
-- ============================
CREATE ROLE app_user WITH LOGIN PASSWORD 'password2' CONNECTION LIMIT 24;
GRANT CONNECT ON DATABASE the_db_name TO app_user;
GRANT USAGE ON SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;


-- ============================
-- backup_user
-- ============================
CREATE ROLE backup_user WITH LOGIN PASSWORD 'password1' CONNECTION LIMIT 8;
GRANT CONNECT ON DATABASE the_db_name TO backup_user;
GRANT USAGE ON SCHEMA public TO backup_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO backup_user;
