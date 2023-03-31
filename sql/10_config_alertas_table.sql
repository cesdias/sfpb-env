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
  severidade smallint NULL DEFAULT 1,
  config_status int2 default 1,
  config_modification_date timestamp NULL,
  config_modification_user text null
);

CREATE TABLE app.config_alertas_grupos (
	id_config int4 NOT NULL,
	group_id int4 NOT NULL,
	CONSTRAINT config_alertas_grupos_pk PRIMARY KEY (id_config, group_id)
);
CREATE INDEX group_id_id_config_idx ON app.config_alertas_grupos USING btree (group_id);
CREATE INDEX id_config_group_idx ON app.config_alertas_grupos USING btree (id_config);



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
    app.nonetexttonull(regexp_replace(config_alertas.configuracao ->> 'valor'::text, ','::text, '.'::text))::double precision AS valor,
    app.nonetexttonull(regexp_replace(config_alertas.configuracao ->> 'valor_nfe'::text, ','::text, '.'::text))::double precision AS valor_nfe,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_condutor'::text) AS cpf_condutor,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_emitente'::text) AS cpf_emitente,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_destinatario'::text) AS cpf_destinatario,
    app.nonetexttonull(config_alertas.configuracao ->> 'cnpj_emitente'::text) AS cnpj_emitente,
    app.nonetexttonull(config_alertas.configuracao ->> 'cnpj_destinatario'::text) AS cnpj_destinatario,
    app.nonetexttonull(config_alertas.configuracao ->> 'cpf_emitente_nfe'::text) AS cpf_emitente_nfe,
    app.nonetexttonull(config_alertas.configuracao ->> 'cnpj_emitente_nfe'::text) AS cnpj_emitente_nfe,
    config_alertas.severidade,
    config_alertas.config_status,
    config_alertas.config_modification_date,
    config_alertas.config_modification_user
   FROM app.config_alertas;
   
GRANT ALL ON TABLE app.config_alertas_view TO hasurauser; 
GRANT ALL ON TABLE app.config_alertas_view TO postgres;

create materialized view app.config_alertas_view2
as SELECT conf.id_config,
    conf.nome,
    conf.descricao,
    string_agg(ug.group_id::text, ',') as visibility_groups,
    conf.procedimentos,
    conf.data_criacao,
    conf.data_fechamento,
    conf.criador,
    app.nonetexttonull(conf.configuracao ->> 'placa'::text) AS placa,
    app.nonetexttonull(regexp_replace(conf.configuracao ->> 'valor'::text, ','::text, '.'::text))::double precision AS valor,
    app.nonetexttonull(regexp_replace(conf.configuracao ->> 'valor_nfe'::text, ','::text, '.'::text))::double precision AS valor_nfe,
    app.nonetexttonull(conf.configuracao ->> 'cpf_condutor'::text) AS cpf_condutor,
    app.nonetexttonull(conf.configuracao ->> 'cpf_emitente'::text) AS cpf_emitente,
    app.nonetexttonull(conf.configuracao ->> 'cpf_destinatario'::text) AS cpf_destinatario,
    app.nonetexttonull(conf.configuracao ->> 'cnpj_emitente'::text) AS cnpj_emitente,
    app.nonetexttonull(conf.configuracao ->> 'cnpj_destinatario'::text) AS cnpj_destinatario,
    app.nonetexttonull(conf.configuracao ->> 'cpf_emitente_nfe'::text) AS cpf_emitente_nfe,
    app.nonetexttonull(conf.configuracao ->> 'cnpj_emitente_nfe'::text) AS cnpj_emitente_nfe,
    conf.severidade, 
    conf.config_status,
	conf.config_modification_date,
	conf.config_modification_user
   FROM app.config_alertas as conf
	  INNER JOIN app.config_alertas_grupos as ug 
	ON conf.id_config = ug.id_config
	where conf.config_status != 3
	GROUP BY conf.id_config
	with data;

CREATE INDEX id_config_view_btree_idx ON app.config_alertas_view2 USING btree (id_config);
CREATE UNIQUE INDEX id_config_view_idx ON app.config_alertas_view2 USING btree (id_config); 

CREATE OR REPLACE FUNCTION app.func_refresh_view()
RETURNS trigger LANGUAGE plpgsql 
SECURITY DEFINER
AS $$
BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY app.config_alertas_view2;
    RETURN NULL;
END;
$$;

CREATE TRIGGER func_refresh_view AFTER INSERT OR UPDATE OR DELETE
ON app.config_alertas 
FOR EACH STATEMENT EXECUTE PROCEDURE app.func_refresh_view();


CREATE TRIGGER func_refresh_view AFTER INSERT OR UPDATE OR DELETE
ON app.config_alertas_grupos 
FOR EACH STATEMENT EXECUTE PROCEDURE app.func_refresh_view();


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