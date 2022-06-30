-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela para configuração de alertas
CREATE TABLE app.config_alertas(
      id_config SERIAL PRIMARY KEY,
      configuracao JSON,
      nome TEXT,
      descricao TEXT,
      group_id TEXT,
      procedimentos TEXT
      data_criacao timestamp NULL,
	data_fechamento timestamp NULL,
	criador text NULL,
);

-- Cria nova tabela de notificações
CREATE TABLE app.notificacoes(
      id BIGSERIAL PRIMARY KEY,
      id_evento int4,
      id_config int4,
      acao_realizada varchar,
      data_hora timestamp,
      fiscal_responsavel varchar
);

GRANT USAGE ON SCHEMA app TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA app TO hasurauser;