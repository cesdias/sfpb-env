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
    app.nonetexttonull(b.configuracao ->> 'valor'::text)::double precision AS valor,
    app.nonetexttonull(b.configuracao ->> 'cpf_proprietario'::text) AS cpf_proprietario,
    app.nonetexttonull(b.configuracao ->> 'cpf_condutor'::text) AS cpf_condutor,
    app.nonetexttonull(b.configuracao ->> 'cpf_emitente'::text) AS cpf_emitente,
    app.nonetexttonull(b.configuracao ->> 'cpf_destinatario'::text) AS cpf_destinatario,
    app.nonetexttonull(b.configuracao ->> 'cnpj_proprietario'::text) AS cnpj_proprietario,
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
    e.infmdfe_ide_uffim
   FROM app.notificacoes a
     JOIN app.config_alertas b ON b.id_config = a.id_config
     JOIN app.fatoevento c ON a.id_evento = c.id
     JOIN app.eventos_mdfe d ON a.id_evento = d.id_evento
     JOIN app.fatomdfe e ON e.protmdfe_infprot_chmdfe::text = d.chave_mdfe::text
  ORDER BY c.evento_infevento_dhregpassagem DESC;

GRANT ALL ON TABLE app.latest_notifications_dhregpassagem_view TO hasurauser; 
GRANT ALL ON TABLE app.latest_notifications_dhregpassagem_view TO postgres;