-- change database and user
\connect datalake datalakeuser


-- Cria nova tabela Grupo
CREATE TABLE app.grupo(
    group_id TEXT PRIMARY KEY,
    chat_id TEXT,
    nome TEXT
);

-- Cria nova tabela Usuario
CREATE TABLE app.usuario(
    user_id TEXT PRIMARY KEY,
    nome TEXT
);

-- Cria nova tabela Usuario Grupo
CREATE TABLE app.usuario_grupo(
    user_id TEXT,
    group_id TEXT
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