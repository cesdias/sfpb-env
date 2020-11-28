-- Cria nova tabela que permite que o usuário salve queries customizadas
CREATE TABLE app.custom_queries(
id SERIAL PRIMARY KEY,
user_id varchar,
custom_query JSON,
query_date date,
query_order int
);