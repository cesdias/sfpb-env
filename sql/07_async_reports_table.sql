-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela que permite que o usuário salve queries customizadas
CREATE TABLE app.async_reports(
    id SERIAL PRIMARY KEY,
    query_name varchar,
    user_id text,
    custom_report JSON,
    start_datetime timestamp,
    close_datetime timestamp,
    send_datetime timestamp,
    status boolean,
    stats JSON,
    result JSON
);