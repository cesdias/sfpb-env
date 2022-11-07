-- change database and user
\connect datalake datalakeuser

-- TODO: documentar razão da tabela
CREATE TABLE app.eventos_mdfe (
	id_evento bigserial NOT NULL,
	chave_mdfe varchar(44) NULL
);
CREATE INDEX eventos_mdfe_chave_mdfe_idx ON app.eventos_mdfe USING btree (chave_mdfe);
CREATE INDEX eventos_mdfe_id_evento_idx ON app.eventos_mdfe USING btree (id_evento);

GRANT ALL ON TABLE app.eventos_mdfe TO postgres;
GRANT ALL ON TABLE app.eventos_mdfe TO hasurauser;

CREATE OR REPLACE VIEW app.evento_passagem_mdfe_view
AS SELECT e.id,
    e.evento_chdfe,
    e.evento_tipo_dfe,
    e.evento_infevento_dhregpassagem,
    e.evento_infevento_dsreflocal,
    e.evento_infevento_dstipoveiculo,
    e.evento_infevento_nocor,
    e.evento_infevento_nomarcamodelo,
    e.evento_infevento_norodovia,
    e.evento_infevento_nrlatitude,
    e.evento_infevento_nrlongitude,
    e.evento_infevento_nrplaca,
    e.evento_infevento_nrvelocidade,
    e.evento_infevento_nrkmrodovia,
    e.evento_infevento_sguf,
    e.evento_infevento_tpsentido,
    e.evento_infevento_tpvia,
    e.evento_valor_tot_cmdfe,
    f.protmdfe_infprot_chmdfe,
    f.infmdfe_ide_ufini,
    f.infmdfe_ide_uffim
   FROM app.fatoevento e
     JOIN app.eventos_mdfe a ON e.id = a.id_evento
     JOIN app.fatomdfe f ON f.protmdfe_infprot_chmdfe::text = a.chave_mdfe::text
  ORDER BY e.evento_infevento_dhregpassagem DESC;

GRANT ALL ON TABLE app.evento_passagem_mdfe_view TO postgres;
GRANT ALL ON TABLE app.evento_passagem_mdfe_view TO hasurauser;

CREATE OR REPLACE VIEW app.latest_notifications_dhregpassagem_view
AS SELECT a.id,
    a.acao_realizada,
    a.data_hora,
    a.fiscal_responsavel,
    b.id_config,
    b.nome,
    b.descricao,
    b.group_id,
    b.procedimentos,
    b.data_criacao,
    b.data_fechamento,
    b.criador,
    app.nonetexttonull(b.configuracao ->> 'placa'::text) AS placa,
    app.nonetexttonull(regexp_replace(b.configuracao ->> 'valor'::text, ','::text, '.'::text))::double precision AS valor,
    app.nonetexttonull(regexp_replace(b.configuracao ->> 'valor_nfe'::text, ','::text, '.'::text))::double precision AS valor_nfe,
    app.nonetexttonull(b.configuracao ->> 'cpf_condutor'::text) AS cpf_condutor,
    app.nonetexttonull(b.configuracao ->> 'cpf_emitente'::text) AS cpf_emitente,
    app.nonetexttonull(b.configuracao ->> 'cpf_destinatario'::text) AS cpf_destinatario,
    app.nonetexttonull(b.configuracao ->> 'cnpj_emitente'::text) AS cnpj_emitente,
    app.nonetexttonull(b.configuracao ->> 'cnpj_destinatario'::text) AS cnpj_destinatario,
    app.nonetexttonull(b.configuracao ->> 'cpf_emitente_nfe'::text) AS cpf_emitente_nfe,
    app.nonetexttonull(b.configuracao ->> 'cnpj_emitente_nfe'::text) AS cnpj_emitente_nfe,
    c.id AS id_evento,
    c.evento_chdfe,
    c.evento_tipo_dfe,
    c.evento_infevento_dhregpassagem,
    c.evento_infevento_dsreflocal,
    c.evento_infevento_dstipoveiculo,
    c.evento_infevento_nocor,
    c.evento_infevento_nomarcamodelo,
    c.evento_infevento_norodovia,
    c.evento_infevento_nrlatitude,
    c.evento_infevento_nrlongitude,
    c.evento_infevento_nrplaca,
    c.evento_infevento_nrvelocidade,
    c.evento_infevento_nrkmrodovia,
    c.evento_infevento_sguf,
    c.evento_infevento_tpsentido,
    c.evento_infevento_tpvia,
    c.evento_valor_tot_cmdfe,
    e.protmdfe_infprot_chmdfe,
    e.infmdfe_ide_ufini,
    e.infmdfe_ide_uffim,
    b.severidade,
    a.data_hora_cadastro
   FROM app.notificacoes a
     JOIN app.config_alertas b ON b.id_config = a.id_config
     JOIN app.fatoevento c ON a.id_evento = c.id
     JOIN app.fatomdfe e ON e.protmdfe_infprot_chmdfe::text = a.protmdfe_infprot_chmdfe::text
  WHERE a.notification_type = 1 AND e.informix_stmdfeletronica = 'A'::bpchar
  ORDER BY c.evento_infevento_dhregpassagem DESC;

GRANT ALL ON TABLE app.latest_notifications_dhregpassagem_view TO hasurauser; 
GRANT ALL ON TABLE app.latest_notifications_dhregpassagem_view TO postgres;