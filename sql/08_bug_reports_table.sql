-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela que permite que o usuário salve queries customizadas
CREATE TABLE app.bug_reports(
      id SERIAL PRIMARY KEY,
      query_name varchar,
      user_id text,
      custom_query JSON,
      start_datetime timestamp,
      send_datetime timestamp
);