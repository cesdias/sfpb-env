-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela que permite que o usuário salve queries customizadas
CREATE TABLE app.custom_queries(
    id SERIAL PRIMARY KEY,
    user_id varchar,
    custom_query JSON,
    query_date timestamp,
    query_order int4
);