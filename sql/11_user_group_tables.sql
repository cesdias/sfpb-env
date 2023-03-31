-- change database and user
\connect datalake datalakeuser


-- Cria nova tabela Grupo
CREATE TABLE app.grupo (
	group_id serial NOT null primary key,	
	group_name text NULL,
	group_description text NULL,
	group_owner text NULL,
	group_type int2 NULL,
	group_status int2 NULL,
	group_creation_date timestamp null,
	group_modification_date timestamp null,
	group_modification_user text null,
	chat_id text NULL,
	chat_name text null,
	chat_link text null,		
	chat_creation_date timestamp null,
	chat_creation_status int2 NULL

);

-- Cria nova tabela Usuario
create table app.usuario (
	user_id serial4 NOT null primary key,
	user_login text null unique,
	user_registration_id varchar null unique,
	user_name text NULL,
	user_department text NULL,
	user_role text NULL,
	user_phone text null
);

-- Cria nova tabela Usuario Grupo
CREATE TABLE app.usuario_grupo (
	user_id int4 NULL,
	group_id int4 NULL
);

-- Cria nova tabela Municipio
CREATE TABLE app.municipio(
    municipio_id TEXT PRIMARY KEY,
    nome TEXT
);

-- Cria nova tabela Municipio Grupo
CREATE TABLE app.municipio_grupo(
    municipio_id TEXT,
    group_id TEXT
);


GRANT USAGE ON SCHEMA app TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA app TO hasurauser;