-- change database and user
\connect datalake datalakeuser

-- Cria nova tabela para configuração de alertas
CREATE TABLE app.config_alertas(
      id_config SERIAL PRIMARY KEY,
      configuracao JSON,
      nome TEXT,
      descricao TEXT,
      group_id TEXT,
      procedimentos TEXT,
      data_criacao timestamp NULL,
	data_fechamento timestamp NULL,
	criador text NULL
);

CREATE or REPLACE FUNCTION noneTextToNull(text) RETURNS text
AS $$
DECLARE
 aux text := lower($1);
BEGIN
 IF aux = 'none' THEN
   RETURN null;
 ELSE 
   RETURN $1;
 END if;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE VIEW app.config_alertas_view
AS SELECT config_alertas.id_config,
    config_alertas.nome,
    config_alertas.descricao,
    config_alertas.group_id,
    config_alertas.procedimentos,
    config_alertas.data_criacao,
    config_alertas.data_fechamento,
    config_alertas.criador,
    nonetexttonull(config_alertas.configuracao ->> 'placa'::text) AS placa,
    nonetexttonull(config_alertas.configuracao ->> 'valor'::text)::double precision AS valor,
    nonetexttonull(config_alertas.configuracao ->> 'cpf_proprietario'::text) AS cpf_proprietario,
    nonetexttonull(config_alertas.configuracao ->> 'cpf_condutor'::text) AS cpf_condutor,
    nonetexttonull(config_alertas.configuracao ->> 'cpf_emitente'::text) AS cpf_emitente,
    nonetexttonull(config_alertas.configuracao ->> 'cpf_destinatario'::text) AS cpf_destinatario,
    nonetexttonull(config_alertas.configuracao ->> 'cnpj_proprietario'::text) AS cnpj_proprietario,
    nonetexttonull(config_alertas.configuracao ->> 'cnpj_emitente'::text) AS cnpj_emitente,
    nonetexttonull(config_alertas.configuracao ->> 'cnpj_destinatario'::text) AS cnpj_destinatario
   FROM config_alertas;

GRANT ALL ON TABLE app.config_alertas_view TO hasurauser; 
GRANT ALL ON TABLE app.config_alertas_view TO postgres;

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