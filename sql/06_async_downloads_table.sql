-- change database and user
\connect datalake datalakeuser

-- Tabela que armazena as informações dos downloads assíncronos.
-- Permissões: Todas as roles; Select, Insert, Update e Delete
CREATE TABLE app.async_downloads(
    id SERIAL PRIMARY KEY,
    user_id text,
    custom_query JSON,
    start_datetime timestamp,
	close_datetime timestamp,
	status boolean,
    download_link varchar
);