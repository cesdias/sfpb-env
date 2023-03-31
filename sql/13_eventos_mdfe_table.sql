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
    f.infmdfe_ide_uffim,
    e.data_recebimento
   FROM app.fatoevento e
     JOIN app.eventos_mdfe a ON e.id = a.id_evento
     JOIN app.fatomdfe f ON f.protmdfe_infprot_chmdfe::text = a.chave_mdfe::text
  ORDER BY e.evento_infevento_dhregpassagem DESC;
CREATE OR REPLACE VIEW app.latest_notifications_dhregpassagem_view
AS SELECT a.id,
    a.acao_realizada,
    a.data_hora,
    a.fiscal_responsavel,
    b.id_config,
    b.nome,
    b.descricao,
    b.visibility_groups AS group_id,
    b.procedimentos,
    b.data_criacao,
    b.data_fechamento,
    b.criador,
    b.placa,
    b.valor,
    b.valor_nfe,
    b.cpf_condutor,
    b.cpf_emitente,
    b.cpf_destinatario,
    b.cnpj_emitente,
    b.cnpj_destinatario,
    b.cpf_emitente_nfe,
    b.cnpj_emitente_nfe,
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
    a.data_hora_cadastro,
    c.data_recebimento
   FROM (select * from app.notificacoes WHERE notification_type = 1) as a
     JOIN app.config_alertas_view2 b ON b.id_config = a.id_config
     JOIN app.fatoevento c ON a.id_evento = c.id
     LEFT JOIN app.fatomdfe e ON e.protmdfe_infprot_chmdfe = a.protmdfe_infprot_chmdfe  
  ORDER BY a.id  DESC;
 
CREATE INDEX notification_type_idx ON app.notificacoes USING btree (notification_type) WHERE (notification_type = 1);

CREATE OR REPLACE VIEW app.nfe_notifications_view
AS SELECT n.id,
    n.id_evento,
    n.acao_realizada,
    n.data_hora,
    n.fiscal_responsavel,
    n.notification_type,
    n.protmdfe_infprot_chmdfe,
    n.data_hora_cadastro,
    n.fiscal_responsavel_cadastro,
    n.data_criacao AS notification_creation,
    f.id_fatonfe,
    f.infnfe_sqn,
    f.infprot_chnfe,
    f.infnfe_ide,
    f.infnfe_ide_mod,
    f.infnfe_ide_dhemi,
    f.infnfe_ide_dhsaient,
    f.infnfe_emit_cnpj,
    f.infnfe_emit_cpf,
    f.infnfe_dest_cnpj,
    f.infnfe_dest_cpf,
    f.infnfe_transp_veictransp_placa,
    f.infnfe_transp_reboque1_placa,
    f.infnfe_transp_reboque2_placa,
    f.infnfe_transp_reboque3_placa,
    f.infnfe_transp_reboque4_placa,
    f.infnfe_transp_reboque5_placa,
    f.infnfe_total_icmstot_vnf,
    f.infnfe_ide_nnf,
    cav.id_config,
    cav.nome,
    cav.descricao,
    cav.visibility_groups,
    cav.procedimentos,
    cav.data_criacao,
    cav.data_fechamento,
    cav.criador,
    cav.placa,
    cav.valor,
    cav.valor_nfe,
    cav.cpf_condutor,
    cav.cpf_emitente,
    cav.cpf_destinatario,
    cav.cnpj_emitente,
    cav.cnpj_destinatario,
    cav.cpf_emitente_nfe,
    cav.cnpj_emitente_nfe,
    cav.severidade,
    cav.config_status,
    cav.config_modification_date,
    cav.config_modification_user
   FROM app.notificacoes n
     JOIN app.fatonfetransito f ON n.infprot_chnfe = f.infprot_chnfe
     JOIN app.config_alertas_view2 cav ON n.id_config = cav.id_config
  WHERE n.notification_type = 2
  ORDER BY n.id DESC;
  
 