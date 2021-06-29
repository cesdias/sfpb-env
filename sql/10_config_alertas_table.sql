-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela para configuração de alertas
CREATE TABLE app.config_alertas(
      id_config SERIAL PRIMARY KEY,
      configuracao JSON,
      nome TEXT,
      descricao TEXT,
      procedimentos TEXT
);

-- Cria nova tabela de notificações
CREATE TABLE app.notificacoes(
      id_evento INTEGER,
      id_config INTEGER
);

GRANT USAGE ON SCHEMA app TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA app TO hasurauser;