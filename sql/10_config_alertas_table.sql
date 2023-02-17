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
	criador text NULL,
  severidade smallint NULL DEFAULT 1
);

CREATE or REPLACE FUNCTION app.noneTextToNull(text) RETURNS text
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

-- app.config_alertas_view source

CREATE OR REPLACE VIEW app.config_alertas_view
AS SELECT config_alertas.id_config,
    config_alertas.nome,
    config_alertas.descricao,
    config_alertas.group_id,
    config_alertas.procedimentos,
    config_alertas.data_criacao,
    config_alertas.data_fechamento,
    config_alertas.criador,
    app.nonetexttonull(config_alertas.configuracao ->> 'placa'::text) AS placa,
    app.nonetexttonull(regexp_replace(config_alertas.configuracao ->> 'valor'::text,',','.'))::double precision AS valor,
    app.nonetexttonull(regexp_replace(config_alertas.configuracao ->> 'valor_nfe'::text,',','.'))::double precision AS valor_nfe,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_condutor'::text) AS cpf_condutor,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_emitente'::text) AS cpf_emitente,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_destinatario'::text) AS cpf_destinatario,
    app.nonetexttonull(config_alertas.configuracao ->> 'cnpj_emitente'::text) AS cnpj_emitente,
    app.nonetexttonull(config_alertas.configuracao ->> 'cnpj_destinatario'::text) AS cnpj_destinatario,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_emitente_nfe'::text) AS cpf_emitente_nfe,
    app.nonetexttonull(config_alertas.configuracao ->> 'cnpj_emitente_nfe'::text) AS cnpj_emitente_nfe,
    config_alertas.severidade
   FROM app.config_alertas;
   
GRANT ALL ON TABLE app.config_alertas_view TO hasurauser; 
GRANT ALL ON TABLE app.config_alertas_view TO postgres;


-- app.fiscal definition
-- Drop table
-- DROP TABLE app.fiscal;

CREATE TABLE app.fiscal (
	matricula_fiscal varchar NOT NULL,
	nome_fiscal text NOT NULL,
	gerencia_fiscal text NULL,
	funcao_fiscal text NULL,
	telefone_fiscal text NULL,
	CONSTRAINT fiscal_pk PRIMARY KEY (matricula_fiscal)
);

GRANT ALL ON TABLE app.fiscal TO hasurauser; 
GRANT ALL ON TABLE app.fiscal TO postgres;

-- app.event_badstats definition
-- Drop table
-- DROP TABLE app.event_badstats;

CREATE TABLE app.event_badstats (
	id varchar NOT NULL,
	cameralocation varchar NOT NULL,
	analysis_date date NOT NULL,
	time_slice int4 NOT NULL,
	quantity int4 NULL,
	CONSTRAINT event_badstats_pk PRIMARY KEY (id)
);

GRANT ALL ON TABLE app.event_badstats TO hasurauser; 
GRANT ALL ON TABLE app.event_badstats TO postgres;
-- app.event_stats definition
-- Drop table
-- DROP TABLE app.event_stats;

CREATE TABLE app.event_stats (
	cameralocation varchar NOT NULL,
	analysis_date date NOT NULL,
	time_slice int4 NOT NULL,
	quantity int4 NOT NULL DEFAULT 0,
	delay float8 NULL,
	CONSTRAINT event_stats_pk PRIMARY KEY (cameralocation, analysis_date, time_slice)
);

GRANT ALL ON TABLE app.event_stats TO hasurauser; 
GRANT ALL ON TABLE app.event_stats TO postgres;

-- Cria nova tabela de notificações
CREATE TABLE app.notificacoes(
      id BIGSERIAL PRIMARY KEY,
      id_evento int4,
      id_config int4,
      acao_realizada varchar,
      data_hora timestamp,
      fiscal_responsavel varchar,
      fiscal_responsavel2 varchar,
      notification_type smallint DEFAULT 1,
      infprot_chnfe bpchar(44),
      protMDFe_infProt_chMDFe character varying(44),
      data_hora_cadastro timestamp,
      fiscal_responsavel_cadastro varchar,
      data_criacao timestamp
);

GRANT USAGE ON SCHEMA app TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA app TO hasurauser;