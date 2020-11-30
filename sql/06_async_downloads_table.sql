-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela que permite que o usuário salve queries customizadas
CREATE TABLE app.async_downloads(
    id SERIAL PRIMARY KEY,
    user_id text,
    custom_query JSON,
    start_datetime timestamp,
	close_datetime timestamp,
	status boolean,
    download_link varchar
);