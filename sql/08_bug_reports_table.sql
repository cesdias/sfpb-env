-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela que permite que o usuário salve queries customizadas
CREATE TABLE app.bug_reports(
      id SERIAL PRIMARY KEY,
      user_id text,
      query_info JSON,
      start_datetime timestamp,
      send_datetime timestamp
);

GRANT USAGE ON SCHEMA app TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA app TO hasurauser;