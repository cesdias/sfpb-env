
-- Datalake - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/datalake

-- user
CREATE USER datalakeuser WITH PASSWORD 'EQuohG2i';

-- database
CREATE DATABASE datalake;

-- privileges and permissions
REVOKE ALL ON DATABASE datalake FROM public;
ALTER DATABASE datalake OWNER TO datalakeuser;
GRANT CONNECT ON DATABASE datalake to datalakeuser;
ALTER ROLE datalakeuser SET search_path TO public,app,appmask;

-- change database and user
\connect datalake datalakeuser

--Chama pacote para o índice do dicionário
CREATE EXTENSION pg_trgm;

-- schemas
CREATE SCHEMA app;
CREATE SCHEMA appmask;

-- tables
CREATE TABLE app.label (
    id serial PRIMARY KEY,
    nomecoluna text,
    tipodado text,
    descricao text,
    anonimizacao text,
    observacao text,
    grupo text,
    tabela text,
	indice text NULL
);

INSERT INTO app.label VALUES (1, 'id_fatonfe', 'bigserial', 'Índice de fatonfe', 'não', NULL, NULL, 'fatonfe', 'btree');
INSERT INTO app.label VALUES (2, 'infprot_chnfe', 'char(44)', 'Chaves de acesso da NF-e', 'sim', 'compostas por: UF do emitente, AAMM da emissão da NFe, CNPJ do emitente, modelo, série e número da NF-e e código numérico+DV', NULL, 'fatonfe', 'btree');
INSERT INTO app.label VALUES (3, 'infnfe_sqn', 'bigint', 'Número de sequência gerado pelo ATF', 'não', NULL, 'Informações do Informix', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (4, 'informix_stnfeletronica', 'character', 'Situação da Nota Fiscal Eletrônica', 'não', 'A - Autorizada dentro do prazo; C - Cancelada; D - Denegada por irregularidade do Emitente; O - Autorizada fora do prazo; I - Denegada por irregularidade do Destinatário; U- Denegação por Destinatário não habilitado a operar na UF', 'Informações do Informix', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (5, 'informix_dhconexao', 'character varying', 'Data e hora da conexão de envio da Nota Fiscal Eletrônica', 'não', NULL, 'Informações do Informix', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (6, 'informix_nriptransmissor', 'char(18)', 'IP da conexão de envio da Nota Fiscal Eletrônica', 'sim', NULL, 'Informações do Informix', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (7, 'informix_nrportacon', 'integer', 'Porta da conexão de envio da Nota Fiscal Eletrônica', 'não', NULL, 'Informações do Informix', 'fatonfe', NULL);
INSERT INTO app.label VALUES (8, 'infnfe_ide', 'character varying', 'Identificação da NF-e', 'não', NULL, 'Grupo A. Dados da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (9, 'infnfe_ide_cuf', 'integer', 'Código da UF do emitente do Documento Fiscal', 'não', 'Número aleatório que compõe o código numérico gerado pelo emitente para cada NF-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (10, 'infnfe_ide_cnf', 'character varying', 'Código numérico para evitar acesso indevido', 'sim', 'Número aleatório que compõe o código numérico gerado pelo emitente para cada NF-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (11, 'infnfe_ide_natop', 'character varying', 'Descrição da Natureza da Operação', 'não', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (12, 'infnfe_ide_mod', 'integer', 'Código do modelo do Documento Fiscal', 'não', '55 - NF-e; 65 - NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (13, 'infnfe_ide_serie', 'character varying', 'Série do Documento Fiscal', 'sim', 'Série normal - 0-889; Avulsa Fisco - 890-899; SCAN - 900-999', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (14, 'infnfe_ide_nnf', 'character varying', 'Número do Documento Fiscal', 'sim', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (15, 'infnfe_ide_dhemi', 'timestamp with time zone', 'Data e Hora de emissão do Documento Fiscal', 'não', '(AAAA-MM-DDTHH:mm:ssTZD) Ex.: 2012-09-01T13:00:00-03:00', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (16, 'infnfe_ide_dhsaient', 'timestamp with time zone', 'Data e Hora da saída ou de entrada da mercadoria/produto', 'não', '(AAAA-MM-DDTHH:mm:ssTZD) Ex.: 2012-09-01T13:00:00-03:00', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (17, 'infnfe_ide_tpnf', 'integer', 'Tipo do Documento Fiscal', 'não', '0 - Entrada; 1 - Saída', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (18, 'infnfe_ide_iddest', 'integer', 'Identificador de Local de destino da operação', 'não', '1 - Interna; 2 -Interestadual; 3 - Exterior', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (19, 'infnfe_ide_cmunfg', 'character varying', 'Código do Município de Ocorrência do Fato Gerador', 'sim', 'Utilizar a Tabela do IBGE.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (20, 'infnfe_ide_tpimp', 'integer', 'Formato de impressão do DANFE', 'não', '0 - sem DANFE;  1 - DANFe Retrato; 2 - DANFe Paisagem; 3 - DANFe Simplificado; 4 - DANFe NFC-e; 5 - DANFe NFC-e em mensagem eletrônica', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (21, 'infnfe_ide_tpemis', 'integer', 'Forma de emissão da NF-e', 'não', '1 - Normal 2 - Contingência FS 3 - Contingência SCAN 4 - Contingência DPEC 5 - Contingência FSDA 6 - Contingência SVC - AN 7 - Contingência SVC - RS 9 - Contingência off-line NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (22, 'infnfe_ide_cdv', 'integer', 'Dígito Verificador da Chave de Acesso da NF-e', 'sim', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (23, 'infnfe_ide_tpamb', 'integer', 'Identificação do Ambiente', 'não', '1 - Produção 2 - Homologação', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (24, 'infnfe_ide_finnfe', 'integer', 'Finalidade da emissão da NF-e', 'não', '1 - NFe normal 2 - NFe complementar 3 - NFe de ajuste 4 - Devolução/Retorno', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (25, 'infnfe_ide_indfinal', 'integer', 'Indica operação com consumidor final', 'não', '0 - Não; 1 - Consumidor Final', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (26, 'infnfe_ide_indpres', 'integer', 'Indicador de presença do comprador no estabelecimento comercial no momento da operação', 'não', '0 - Não se aplica (ex.: Nota Fiscal complementar ou de ajuste), 1 - Operação presencial; 2 - Não presencial, internet; 3 - Não presencial, teleatendimento; 4 - NFC-e entrega em domicílio; 5 - Operação presencial, fora do estabelecimento; 9 - Não presencial, outros', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (27, 'infnfe_ide_procemi', 'integer', 'Processo de emissão utilizado com a seguinte codificação', 'não', '0 - Emissão de NF-e com aplicativo do contribuinte; 1 - Emissão de NF-e avulsa pelo Fisco; 2 - Emissão de NF-e avulsa, pelo contribuinte com seu certificado digital, através do sitedo Fisco; 3 - Emissão de NF-e pelo contribuinte com aplicativo fornecido pelo Fisco.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (28, 'infnfe_ide_verproc', 'character varying', 'Versão do aplicativo utilizado no processo de emissão', 'não', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (29, 'infnfe_emit_cnpj', 'char(14)', 'Número do CNPJ do emitente', 'sim', 'Tipo de dado no BD é diferente (varchar), o tipo consta na label como char(14) para evitar que a busca use nesse campo ilike', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (30, 'infnfe_emit_cpf', 'char(11)', 'Número do CPF do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (31, 'infnfe_emit_xnome', 'character varying', 'Razão Social ou Nome do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (32, 'infnfe_emit_xfant', 'character varying', 'Nome fantasia do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', 'gin');
INSERT INTO app.label VALUES (33, 'infnfe_emit_enderemit_xlgr', 'character varying', 'Logradouro do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (34, 'infnfe_emit_enderemit_nro', 'character varying', 'Número do endereço do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (35, 'infnfe_emit_enderemit_xcpl', 'character varying', 'Complemento do endereço do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (36, 'infnfe_emit_enderemit_xbairro', 'character varying', 'Bairro do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (37, 'infnfe_emit_enderemit_cmun', 'character varying', 'Código do município do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (38, 'infnfe_emit_enderemit_xmun', 'character varying', 'Nome do município do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (39, 'infnfe_emit_enderemit_uf', 'character varying', 'Sigla da UF do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (40, 'infnfe_emit_enderemit_cep', 'character varying', 'CEP - NT 2011/004 do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (41, 'infnfe_emit_enderemit_cpais', 'character varying', 'Código do país do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (42, 'infnfe_emit_enderemit_xpais', 'character varying', 'Nome do país do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (43, 'infnfe_emit_enderemit_fone', 'character varying', 'Código DDD + número do telefone (v.2.0) do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (44, 'infnfe_emit_ie', 'character varying', 'Inscrição Estadual do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (45, 'infnfe_emit_iest', 'character varying', 'Inscricao Estadual do Substituto Tributário do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (46, 'infnfe_emit_im', 'character varying', 'Inscrição Municipal do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (47, 'infnfe_emit_cnae', 'character varying', 'CNAE Fiscal do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (48, 'infnfe_emit_crt', 'character varying', 'Código de Regime Tributário do emitente', 'não', 'Este campo será obrigatoriamente preenchido com: 1 – Simples Nacional; 2 – Simples Nacional – excesso de sublimite de receita bruta; 3 – Regime Normal.', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (49, 'infnfe_dest_cnpj', 'char(14)', 'Número do CNPJ do destinatário', 'sim', 'Tipo de dado no BD é diferente (varchar), o tipo consta na label como char(14) para evitar que a busca use nesse campo ilike', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (50, 'infnfe_dest_cpf', 'char(11)', 'Número do CPF do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (51, 'infnfe_dest_idestrangeiro', 'character varying', 'Identificador do destinatário, em caso de comprador estrangeiro', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (52, 'infnfe_dest_xnome', 'character varying', 'Razão Social ou nome do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (53, 'infnfe_dest_enderdest_xlgr', 'character varying', 'Logradouro do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (54, 'infnfe_dest_enderdest_nro', 'character varying', 'Número do endereço do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (55, 'infnfe_dest_enderdest_xcpl', 'character varying', 'Complemento do endereço do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (56, 'infnfe_dest_enderdest_xbairro', 'character varying', 'Bairro do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (57, 'infnfe_dest_enderdest_cmun', 'character varying', 'Código do município do destinatário', 'sim', 'Utilizar a tabela do IBGE, informar 9999999 para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (58, 'infnfe_dest_enderdest_xmun', 'character varying', 'Nome do município do destinatário', 'sim', 'Informar EXTERIOR para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (59, 'infnfe_dest_enderdest_uf', 'character varying', 'Sigla da UF, informar EX para operações com o exterior do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (60, 'infnfe_dest_enderdest_cep', 'character varying', 'CEP do destinatário', 'sim', 'Informar EX para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (61, 'infnfe_dest_enderdest_cpais', 'character varying', 'Código de país do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (62, 'infnfe_dest_enderdest_xpais', 'character varying', 'Nome do país do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (63, 'infnfe_dest_enderdest_fone', 'character varying', 'Código DDD + número do telefone (v.2.0) do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (64, 'infnfe_dest_indiedest', 'character varying', 'Indicador da IE do destinatário', 'sim', '1 – Contribuinte ICMS pagamento à vista; 2 – Contribuinte isento de inscrição; 9 – Não Contribuinte', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (65, 'infnfe_dest_ie', 'character varying', 'Inscrição Estadual do destinatário', 'sim', 'Obrigatório nas operações com contribuintes do ICMS', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (66, 'infnfe_dest_isuf', 'character varying', 'Inscrição na SUFRAMA do destinatário', 'sim', 'Obrigatório nas operações com as áreas com benefícios de incentivos fiscais sob controle da SUFRAMA - PL_005d - 11/08/09 - alterado para aceitar 8 ou 9 dígitos', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (67, 'infnfe_dest_im', 'character varying', 'Inscrição Municipal do tomador do serviço', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (68, 'infnfe_dest_email', 'character varying', 'Informar o e-mail do destinatário', 'sim', 'O campo pode ser utilizado para informar o e-mailde recepção da NF-e indicada pelo destinatário', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe', NULL);
INSERT INTO app.label VALUES (69, 'infnfe_total_icmstot_vbc', 'numeric(16,2)', 'BC do ICMS total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (70, 'infnfe_total_icmstot_vicms', 'numeric(16,2)', 'Valor Total do ICMS', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (71, 'infnfe_total_icmstot_vicmsdeson', 'numeric(16,2)', 'Valor Total do ICMS desonerado', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (72, 'infnfe_total_icmstot_vfcpufdest', 'numeric(16,2)', 'Valor Total do ICMS relativo ao Fundo de Combate à Pobreza (FCP) para a UF de destino', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (73, 'infnfe_total_icmstot_vicmsufdest', 'numeric(16,2)', 'Valor Total do ICMS de partilha para a UF do destinatário', 'não', 'Deve ser informado quando preenchido o Grupo Tributos Devolvidos na emissão de nota finNFe = 4 (devolução) nas operações com não contribuintes do IPI. Corresponde ao total da soma dos campos id: UA04.', 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (74, 'infnfe_total_icmstot_vicmsufremet', 'numeric(16,2)', 'Valor Total do ICMS de partilha para a UF do remetente', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (75, 'infnfe_total_icmstot_vfcp', 'numeric(16,2)', 'Valor Total do FCP (Fundo de Combate à Pobreza)', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (76, 'infnfe_total_icmstot_vbcst', 'numeric(16,2)', 'BC do ICMS total ST', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (77, 'infnfe_total_icmstot_vst', 'numeric(16,2)', 'Valor Total do ICMS ST', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (78, 'infnfe_total_icmstot_vfcpst', 'numeric(16,2)', 'Valor Total do FCP (Fundo de Combate à Pobreza) retido por substituição tributária', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (79, 'infnfe_total_icmstot_vfcpstret', 'numeric(16,2)', 'Valor Total do FCP (Fundo de Combate à Pobreza) retido anteriormente por substituição tributária', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (80, 'infnfe_total_icmstot_vprod', 'numeric(16,2)', 'Valor Total dos produtos e serviços - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (81, 'infnfe_total_icmstot_vfrete', 'numeric(16,2)', 'Valor Total do Frete ', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (82, 'infnfe_total_icmstot_vseg', 'numeric(16,2)', 'Valor Total do Seguro - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (83, 'infnfe_total_icmstot_vdesc', 'numeric(16,2)', 'Valor Total do Desconto - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (84, 'infnfe_total_icmstot_vii', 'numeric(16,2)', 'Valor Total do II - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (85, 'infnfe_total_icmstot_vipi', 'numeric(16,2)', 'Valor Total do IPI - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (86, 'infnfe_total_icmstot_vpis', 'numeric(16,2)', 'Valor do PIS - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (87, 'infnfe_total_icmstot_vcofins', 'numeric(16,2)', 'Valor do COFINS - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (88, 'infnfe_total_icmstot_voutro', 'numeric(16,2)', 'Outras Despesas acessórias - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (89, 'infnfe_total_icmstot_vnf', 'numeric(16,2)', 'Valor Total da NF-e ', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (90, 'infnfe_total_icmstot_vtottrib', 'numeric(16,2)', 'Valor estimado total de impostos federais, estaduais e municipais', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (91, 'infnfe_transp_modfrete', 'character varying(1)', 'Modalidade do frete 0- Contratação do Frete por conta do Remetente (CIF); 1- Contratação do Frete por conta do destinatário/remetente (FOB); 2- Contratação do Frete por conta de terceiros; 3- Transporte próprio por conta do remetente; 4- Transporte próprio por conta do destinatário; 9- Sem Ocorrência de transporte.', 'não', NULL, 'Dados dos transportes da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (92, 'infnfe_transp_vagao', 'character varying(20)', 'Identificação do vagão (v2.0)', 'não', NULL, 'Dados dos transportes da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (93, 'infnfe_transp_balsa', 'character varying(20)', 'Identificação da balsa (v2.0)', 'não', NULL, 'Dados dos transportes da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (94, 'infnfe_transp_transporta_cnpj', 'char(14)', 'CNPJ do transportador', 'não', NULL, 'Dados do transportador', 'fatonfe', NULL);
INSERT INTO app.label VALUES (95, 'infnfe_transp_transporta_cpf', 'char(11)', 'CPF do transportador', 'não', NULL, 'Dados do transportador', 'fatonfe', NULL);
INSERT INTO app.label VALUES (96, 'infnfe_transp_transporta_xnome', 'character varying(100)', 'Razão Social ou nome do transportador', 'não', NULL, 'Dados do transportador', 'fatonfe', NULL);
INSERT INTO app.label VALUES (97, 'infnfe_transp_transporta_ie', 'character varying', 'Inscrição Estadual (v2.0)', 'não', NULL, 'Dados do transportador', 'fatonfe', NULL);
INSERT INTO app.label VALUES (98, 'infnfe_transp_transporta_xender', 'character varying(100)', 'Endereço completo', 'não', NULL, 'Dados do transportador', 'fatonfe', NULL);
INSERT INTO app.label VALUES (99, 'infnfe_transp_transporta_xmun', 'character varying(100)', 'Nome do munícipio', 'não', NULL, 'Dados do transportador', 'fatonfe', NULL);
INSERT INTO app.label VALUES (100, 'infnfe_transp_transporta_uf', 'character varying(2)', 'Sigla da UF', 'não', NULL, 'Dados do transportador', 'fatonfe', NULL);
INSERT INTO app.label VALUES (101, 'infnfe_transp_rettransp_vserv', 'numeric(16,2)', 'Valor do Serviço', 'não', NULL, 'Dados da retenção ICMS do Transporte', 'fatonfe', NULL);
INSERT INTO app.label VALUES (102, 'infnfe_transp_rettransp_vbcret', 'numeric(16,2)', 'BC da Retenção do ICMS', 'não', NULL, 'Dados da retenção ICMS do Transporte', 'fatonfe', NULL);
INSERT INTO app.label VALUES (103, 'infnfe_transp_rettransp_picmsret', 'numeric(16,2)', 'Alíquota da Retenção', 'não', NULL, 'Dados da retenção ICMS do Transporte', 'fatonfe', NULL);
INSERT INTO app.label VALUES (104, 'infnfe_transp_rettransp_vicmsret', 'numeric(16,2)', 'Valor do ICMS Retido', 'não', NULL, 'Dados da retenção ICMS do Transporte', 'fatonfe', NULL);
INSERT INTO app.label VALUES (105, 'infnfe_transp_rettransp_cfop', 'character varying', 'Código Fiscal de Operações e Prestações', 'não', NULL, 'Dados da retenção ICMS do Transporte', 'fatonfe', NULL);
INSERT INTO app.label VALUES (106, 'infnfe_transp_rettransp_cmunfg', 'character varying', 'Código do Município de Ocorrência do Fato Gerador (utilizar a tabela do IBGE)', 'não', NULL, 'Dados da retenção ICMS do Transporte', 'fatonfe', NULL);
INSERT INTO app.label VALUES (107, 'infnfe_transp_veictransp_placa', 'character varying(8)', 'Placa do veículo', 'não', NULL, 'Dados do veículo', 'fatonfe', 'btree');
INSERT INTO app.label VALUES (108, 'infnfe_transp_veictransp_uf', 'character varying(2)', 'Sigla da UF', 'não', NULL, 'Dados do veículo', 'fatonfe', NULL);
INSERT INTO app.label VALUES (109, 'infnfe_transp_reboque1_placa', 'character varying(8)', 'Placa do veículo', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (110, 'infnfe_transp_reboque1_uf', 'character varying(2)', 'Sigla da UF', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (111, 'infnfe_transp_reboque2_placa', 'character varying(8)', 'Placa do veículo', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (112, 'infnfe_transp_reboque2_uf', 'character varying(2)', 'Sigla da UF', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (113, 'infnfe_transp_reboque3_placa', 'character varying(8)', 'Placa do veículo', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (114, 'infnfe_transp_reboque3_uf', 'character varying(2)', 'Sigla da UF', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (115, 'infnfe_transp_reboque4_placa', 'character varying(8)', 'Placa do veículo', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (116, 'infnfe_transp_reboque4_uf', 'character varying(2)', 'Sigla da UF', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (117, 'infnfe_transp_reboque5_placa', 'character varying(8)', 'Placa do veículo', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (118, 'infnfe_transp_reboque5_uf', 'character varying(2)', 'Sigla da UF', 'não', NULL, 'Dados do reboque/Dolly (v2.0)', 'fatonfe', NULL);
INSERT INTO app.label VALUES (119, 'infnfe_transp_vol1_nVol', 'character varying(60)', 'Numeração dos volumes transportados', 'não', NULL, 'Dados dos volumes', 'fatonfe', NULL);
INSERT INTO app.label VALUES (120, 'infnfe_transp_vol1_qVol', 'numeric(16,2)', 'Quantidade de volumes transportados', 'não', NULL, 'Dados dos volumes', 'fatonfe', NULL);
INSERT INTO app.label VALUES (121, 'infnfe_transp_vol1_esp', 'character varying(60)', 'Espécie dos volumes transportados', 'não', NULL, 'Dados dos volumes', 'fatonfe', NULL);
INSERT INTO app.label VALUES (122, 'infnfe_transp_vol1_marca', 'character varying(60)', 'Marca dos volumes transportados', 'não', NULL, 'Dados dos volumes', 'fatonfe', NULL);
INSERT INTO app.label VALUES (123, 'infnfe_transp_vol1_pesoL', 'numeric(16,2)', 'Peso líquido (em kg)', 'não', NULL, 'Dados dos volumes', 'fatonfe', NULL);
INSERT INTO app.label VALUES (124, 'infnfe_transp_vol1_pesoB', 'numeric(16,2)', 'Peso bruto (em kg)', 'não', NULL, 'Dados dos volumes', 'fatonfe', NULL);
INSERT INTO app.label VALUES (125, 'infnfe_transp_vol1_lacres_nLacre', 'character varying(60)', 'Número dos Lacres', 'não', NULL, 'Dados dos volumes', 'fatonfe', NULL);
INSERT INTO app.label VALUES (126, 'infnfe_cobr_fat_nfat', 'character varying(60)', 'Número da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe', NULL);
INSERT INTO app.label VALUES (127, 'infnfe_cobr_fat_vorig', 'numeric(16,2)', 'Valor original da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe', NULL);
INSERT INTO app.label VALUES (128, 'infnfe_cobr_fat_vdesc', 'numeric(16,2)', 'Valor do desconto da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe', NULL);
INSERT INTO app.label VALUES (129, 'infnfe_cobr_fat_vliq', 'numeric(16,2)', 'Valor líquido da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe', NULL);
INSERT INTO app.label VALUES (130, 'infnfe_pag_vtroco', 'numeric(16,2)', 'Valor do Troco', 'não', NULL, 'Grupo YA. Formas de Pagamento', 'fatonfe', NULL);
INSERT INTO app.label VALUES (131, 'infnfe_infadic_infadfisco', 'character varying', 'Informações adicionais de interesse do Fisco (v2.0)', 'não', 'Observação UFPB: pega apenas 1.a ocorrencia', 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (132, 'infnfe_infadic_infcpl', 'character varying', 'Informações complementares de interesse do Contribuinte', 'não', NULL, 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe', 'gin');
INSERT INTO app.label VALUES (133, 'infnfe_infadic_obscont_xcampo', 'character varying', 'Grupo campo de uso livre do contribuinte', 'não', 'Informar o nome do campo no atributo xCampo e o conteúdo do campo no xTexto', 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (134, 'infnfe_infadic_obscont_xtexto', 'character varying', 'Conteúdo do campo - Informações adicionais da NF-e', 'não', NULL, 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe', NULL);
INSERT INTO app.label VALUES (135, 'id_fatoitemnfe', 'bigserial', 'Índice de fatoitemnfe', 'não', NULL, NULL, 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (136, 'infprot_chnfe', 'char(44)', 'Chaves de acesso do item da NF-e', 'sim', 'compostas por: UF do emitente, AAMM da emissão da NFe, CNPJ do emitente, modelo, série e número da NF-e e código numérico+DV', NULL, 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (137, 'infnfe_det_nitem', 'character varying', 'Dados dos detalhes da NF-e', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (138, 'infnfe_det_prod_cprod', 'character varying', 'Código do produto ou serviço', 'não', 'Preencher com CFOP caso se trate de itens não relacionados com mercadorias/produto e que o contribuinte não possua codificação própriaFormato ”CFOP9999”', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (139, 'infnfe_det_prod_cean', 'character varying', 'GTIN (Global Trade Item Number) do produto', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (140, 'infnfe_det_prod_xprod', 'character varying', 'Descrição do produto ou serviço', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', 'gin');
INSERT INTO app.label VALUES (141, 'infnfe_det_prod_ncm', 'character varying', 'Código NCM (8 posições)', 'não', 'Será permitida a informação do gênero (posição do capítulo do NCM) quando a operação não for de comércio exterior (importação/exportação) ou o produto não seja tributado pelo IPI. Em caso de item de serviço ou item que não tenham produto (Ex. transferência de crédito, crédito do ativo imobilizado, etc.), informar o código 00 (zeros) (v2.0)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (142, 'infnfe_det_prod_cfop', 'character varying', 'Cfop', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (143, 'infnfe_det_prod_ucom', 'character varying', 'Unidade comercial', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (144, 'infnfe_det_prod_qcom', 'numeric', 'Quantidade Comercial  do produto', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (145, 'infnfe_det_prod_vuncom', 'numeric', 'Valor unitário de comercialização', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (146, 'infnfe_det_prod_vprod', 'numeric', 'Valor bruto do produto ou serviço', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (147, 'infnfe_det_prod_ceantrib', 'character varying', 'GTIN (Global Trade Item Number) da unidade tributável', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (148, 'infnfe_det_prod_utrib', 'character varying', 'Unidade Tributável', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (149, 'infnfe_det_prod_qtrib', 'numeric', 'Quantidade Tributável', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (150, 'infnfe_det_prod_vuntrib', 'numeric', 'Valor unitário de tributação', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (151, 'infnfe_det_prod_vfrete', 'numeric', 'Valor Total do Frete', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (152, 'infnfe_det_prod_vseg', 'numeric', 'Valor Total do Seguro', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (153, 'infnfe_det_prod_vdesc', 'numeric', 'Valor do Desconto', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (154, 'infnfe_det_prod_voutro', 'numeric', 'Outras despesas acessórias', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (155, 'infnfe_det_prod_indtot', 'character varying', 'Indica se o valor da item (vProd) entra no valor total da NFe (vProd)', 'não', '0 – o valor do item (vProd) não compõe o valor total da NF-e (vProd), 1 – o valor do item (vProd) compõe o valor total da NF-e (vProd)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (156, 'infnfe_det_prod_comb_cprodanp', 'character varying', 'Código de produto da ANP', 'não', 'Codificação de produtos do SIMP (http://www.anp.gov.br)', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (157, 'infnfe_det_prod_comb_descanp', 'character varying', 'Descrição do Produto conforme ANP', 'não', 'Utilizar a descrição de produtos do Sistema de Informações de Movimentação de Produtos - SIMP (http://www.anp.gov.br/simp/)', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', 'gin');
INSERT INTO app.label VALUES (198, 'infnfe_det_imposto_icms_vbcfcp', 'numeric(16,2)', 'Valor da Base de cálculo do FCP - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (158, 'infnfe_det_prod_comb_pglp', 'numeric', 'Percentual do GLP derivado do petróleo no produto GLP (cProdANP=210203001)', 'não', 'Informar em número decimal o percentual do GLP derivado de petróleo no produto GLP. Valores 0 a 100', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (159, 'infnfe_det_prod_comb_pgnn', 'numeric', 'Percentual de gás natural nacional - GLGNn para o produto GLP (cProdANP=210203001).', 'não', 'Informar em número decimal o percentual do Gás Natural Nacional - GLGNn para o produto GLP. Valores de 0 a 100.', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (160, 'infnfe_det_prod_comb_pgni', 'numeric', 'Percentual de gás natural importado GLGNi para o produto GLP (cProdANP=210203001)', 'não', 'Informar em número deciaml o percentual do Gás Natural Importado - GLGNi para o produto GLP. Valores de 0 a 100.', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (161, 'infnfe_det_prod_comb_vpart', 'character varying', 'Valor de partida (cProdANP=210203001).', 'não', 'Deve ser informado neste campo o valor por quilograma sem ICMS.', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (162, 'infnfe_det_prod_comb_codif', 'numeric', 'Código de autorização / registro do CODIF.', 'não', 'Informar apenas quando a UF utilizar o CODIF (Sistema de Controle do Diferimento do Imposto nas Operações com AEAC - Álcool Etílico Anidro Combustível).', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (163, 'infnfe_det_prod_comb_qtemp', 'numeric', 'Quantidade de combustível faturada à temperatura ambiente. ', 'não', 'Informar quando a quantidade faturada informada no campo qCom (I10) tiver sido ajustada para uma temperatura diferente da', 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (164, 'infnfe_det_prod_comb_ufcons', 'character varying', 'Sigla da UF de Consumo', 'não', NULL, 'Informar apenas para operações com combustíveis ', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (165, 'infnfe_det_prod_comb_cide_qbcprod', 'numeric', 'BC do CIDE ( Quantidade comercializada)', 'não', NULL, 'CIDE Combustíveis', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (166, 'infnfe_det_prod_comb_cide_valiqprod', 'numeric', 'Alíquota do CIDE (em reais)', 'não', NULL, 'CIDE Combustíveis', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (167, 'infnfe_det_prod_comb_cide_vcide', 'numeric', 'Valor do CIDE', 'não', NULL, 'CIDE Combustíveis', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (168, 'infnfe_det_prod_comb_encerrante_nbico', 'character varying', 'Numero de identificação do Bico utilizado no abastecimento', 'não', NULL, 'Informações do grupo encerrante', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (169, 'infnfe_det_prod_comb_encerrante_nbomba', 'character varying', 'Numero de identificação da bomba ao qual o bico está interligado', 'não', NULL, 'Informações do grupo encerrante', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (170, 'infnfe_det_prod_comb_encerrante_ntanque', 'character varying', 'Numero de identificação do tanque ao qual o bico está interligado', 'não', NULL, 'Informações do grupo encerrante', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (171, 'infnfe_det_prod_comb_encerrante_vencini', 'numeric', 'Valor do Encerrante no ínicio do abastecimento', 'não', NULL, 'Informações do grupo encerrante', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (172, 'infnfe_det_prod_comb_encerrante_vencfin', 'numeric', 'Valor do Encerrante no final do abastecimento', 'não', NULL, 'Informações do grupo encerrante', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (173, 'infnfe_det_imposto_vtottrib', 'numeric', 'Valor estimado total de impostos federais, estaduais e municipais', 'não', NULL, 'Grupo M. Tributos incidentes no Produto ou Serviço', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (174, 'infnfe_det_imposto_icms_orig', 'character varying(1)', 'Origem da mercadoria - ICMS', 'não', '0 - Nacional; 1 - Estrangeira - Importação direta; 2 - Estrangeira - Adquirida no mercado interno', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (175, 'infnfe_det_imposto_icms_cst', 'character varying(3)', 'Tributação pelo ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (176, 'infnfe_det_imposto_icms_csosn', 'character varying', 'Código de situação da operação do simples nacional', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (177, 'infnfe_det_imposto_icms_vbcstret', 'numeric(16,2)', 'Valor da BC do ICMS retido anteriormente (v2.0)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (178, 'infnfe_det_imposto_icms_pst', 'numeric(16,2)', 'Aliquota suportada pelo consumidor final', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (179, 'infnfe_det_imposto_icms_vicmssubstituto', 'numeric(16,2)', 'Valor do ICMS próprio do substituto', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (180, 'infnfe_det_imposto_icms_vicmsstret', 'numeric(16,2)', 'Valor do ICMS  retido anteriormente (v2.0)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (181, 'infnfe_det_imposto_icms_vbcfcpstret', 'numeric(16,2)', 'Valor da Base de cálculo do FCP retido anteriormente', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (182, 'infnfe_det_imposto_icms_pfcpstret', 'numeric(16,2)', 'Percentual de FCP retido anteriormente por substituição tributária', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (183, 'infnfe_det_imposto_icms_vfcpstret', 'numeric(16,2)', 'Valor do FCP retido por substituição tributária', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (184, 'infnfe_det_imposto_icms_vbcstdest', 'numeric(16,2)', 'Informar o valor da BC do ICMS da UF destino', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (185, 'infnfe_det_imposto_icms_vicmsstdest', 'numeric(16,2)', 'Informar o valor da BC do ICMS da UF destino (v2.0)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (186, 'infnfe_det_imposto_icms_predbcefet', 'numeric(16,2)', 'Percentual de redução da base de cálculo efetiva - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (187, 'infnfe_det_imposto_icms_vbcefet', 'numeric(16,2)', 'Valor da base de cálculo efetiva - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (188, 'infnfe_det_imposto_icms_picmsefet', 'numeric(16,2)', 'Alíquota do ICMS efetivo', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (189, 'infnfe_det_imposto_icms_vicmsefet', 'numeric(16,2)', 'Valor do ICMS efetivo', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (190, 'infnfe_det_imposto_icms_modbc', 'character varying', 'Modalidade de determinação da BC da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (191, 'infnfe_det_imposto_icms_predbc', 'numeric(16,2)', 'Percentual de redução da partilha do BC', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (192, 'infnfe_det_imposto_icms_vbc', 'numeric(16,2)', 'Valor da BC da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (193, 'infnfe_det_imposto_icms_picms', 'numeric(16,2)', 'Alíquota da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (194, 'infnfe_det_imposto_icms_vicmsop', 'numeric(16,2)', 'Valor do ICMS da Operação', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (195, 'infnfe_det_imposto_icms_pdif', 'numeric(16,2)', 'Percentual do diferemento - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (196, 'infnfe_det_imposto_icms_vicmsdif', 'numeric(16,2)', 'Valor do ICMS da diferido', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (197, 'infnfe_det_imposto_icms_vicms', 'numeric(16,2)', 'Valor do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (199, 'infnfe_det_imposto_icms_pfcp', 'numeric(16,2)', 'Percentual de ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (200, 'infnfe_det_imposto_icms_vfcp', 'numeric(16,2)', 'Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (201, 'infnfe_det_imposto_icms_pfcpdif', 'numeric(16,2)', 'Percentual do diferimento - ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (202, 'infnfe_det_imposto_icms_vfcpdif', 'numeric(16,2)', 'Valor diferido do ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (203, 'infnfe_det_imposto_icms_vfcpefet', 'numeric(16,2)', 'Valor efetivo do ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (204, 'infnfe_det_imposto_icms_modbcst', 'character varying(1)', 'Modalidade de determinação da BC do ICMS ST', 'não', '0 – Preço tabelado ou máximo sugerido; 1 - Lista Negativa (valor), 2 - Lista Positiva (valor), 3 - Lista Neutra (valor), 4 - Margem Valor Agregado (%), 5 - Pauta (valor), 6 - Valor da Operação', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (205, 'infnfe_det_imposto_icms_pmvast', 'numeric(16,2)', 'Percentual da Margem de Valor Adicionado ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (206, 'infnfe_det_imposto_icms_predbcst', 'numeric(16,2)', 'Percentual de redução da BC ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (207, 'infnfe_det_imposto_icms_vbcst', 'numeric(16,2)', 'Valor da BC do ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (208, 'infnfe_det_imposto_icms_picmsst', 'numeric(16,2)', 'Alíquota do ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (209, 'infnfe_det_imposto_icms_vicmsst', 'numeric(16,2)', 'Valor do ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', 'btree');
INSERT INTO app.label VALUES (210, 'infnfe_det_imposto_icms_vbcfcpst', 'numeric(16,2)', 'Valor da Base de cálculo do FCP retido por substituição tributária - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (211, 'infnfe_det_imposto_icms_pfcpst', 'numeric(16,2)', 'Percentual de FCP retido por substituição tributária - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (212, 'infnfe_det_imposto_icms_vfcpst', 'numeric(16,2)', 'Valor do FCP retido por substituição tributária - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (213, 'infnfe_det_imposto_icms_vicmsdeson', 'numeric(16,2)', 'Valor do ICMS de desoneração', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (214, 'infnfe_det_imposto_icms_motdesicms', 'character varying(3)', 'Motivo da desoneração do ICMS', 'não', '3 - Uso na agropecuária; 9 - Outros; 12 - Fomento agropecuário', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (215, 'infnfe_det_imposto_icms_vicmsstdeson', 'numeric(16,2)', 'Valor do ICMS ST de desoneração', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (216, 'infnfe_det_imposto_icms_motdesicmsst', 'character varying(3)', 'Motivo da desoneração do ICMS ST', 'não', '3 - Uso na agropecuária; 9 - Outros; 12 - Fomento agropecuário', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (217, 'infnfe_det_imposto_icms_pbcop', 'numeric(16,2)', 'Percentual para determinação do valor  da Base de Cálculo da operação própria da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (218, 'infnfe_det_imposto_icms_ufst', 'character varying(2)', 'Sigla da UF para qual é devido a partilha do ICMS ST da operação', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (219, 'infnfe_det_imposto_icms_pcredsn', 'numeric(16,2)', 'Alíquota aplicável de cálculo do crédito (Simples Nacional) (v2.0)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (220, 'infnfe_det_imposto_ii_vbc', 'numeric(16,2)', 'Base da BC do Imposto de Importação', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (221, 'infnfe_det_imposto_ii_vdespadu', 'numeric(16,2)', 'Valor das despesas aduaneiras', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (222, 'infnfe_det_imposto_ii_vii', 'numeric(16,2)', 'Valor do Imposto de Importação', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (223, 'infnfe_det_imposto_ii_viof', 'numeric(16,2)', 'Valor do Imposto sobre Operações Financeiras', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (224, 'infnfe_det_imposto_icmsufdest_vbcufdest', 'numeric(16,2)', 'Valor da Base de Cálculo do ICMS na UF do destinatário', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (225, 'infnfe_det_imposto_icmsufdest_vbcfcpufdest', 'numeric(16,2)', 'Valor da Base de Cálculo do FCP na UF do destinatário - ICMS', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (226, 'infnfe_det_imposto_icmsufdest_pfcpufdest', 'numeric(16,2)', 'Percentual adicional inserido na alíquota interna da UF de destino - ICMS', 'não', 'Relativo ao Fundo de Combate à Pobreza (FCP) naquela UF', 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (227, 'infnfe_det_imposto_icmsufdest_picmsufdest', 'numeric(16,2)', 'Alíquota adotada nas operações internas na UF do destinatário para o produto/mercadoria - ICMS', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (228, 'infnfe_det_imposto_icmsufdest_picmsinter', 'character varying', 'Alíquota interestadual das UF envolvidas - ICMS', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (229, 'infnfe_det_imposto_icmsufdest_picmsinterpart', 'numeric(16,2)', 'Percentual de partilha para a UF do destinatário - ICMS', 'não', '- 4% alíquota interestadual para produtos importados; - 7% para os Estados de origem do Sul e Sudeste (exceto ES), destinado para os Estados do Norte e Nordeste ou ES; - 12% para os demais casos.', 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (230, 'infnfe_det_imposto_icmsufdest_vfcpufdest', 'numeric(16,2)', 'Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP) da UF de destino', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (231, 'infnfe_det_imposto_icmsufdest_vicmsufdest', 'numeric(16,2)', 'Valor do ICMS de partilha para a UF do destinatário', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (232, 'infnfe_det_imposto_icmsufdest_vicmsufremet', 'numeric(16,2)', 'Valor do ICMS de partilha para a UF do remetente', 'não', 'Nota: A partir de 2019, este valor será zero.', 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe', NULL);
INSERT INTO app.label VALUES (233, 'id_fatorefnfe', 'bigserial', 'Índice de fatoitemnfe', 'não', NULL, NULL, 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (234, 'infprot_chnfe', 'char(44)', 'Chaves de acesso da NF-e ', 'não', NULL, NULL, 'fatorefnfe', 'btree');
INSERT INTO app.label VALUES (235, 'infnfe_ide_nfref_refnfe', 'char(44)', 'Chave de acesso das NF-e referenciadas', 'não', 'Chave de acesso compostas por Código da UF (tabela do IBGE) + AAMM da emissão + CNPJ do Emitente + modelo, série e número da NF-e Referenciada + Código Numérico + DV', 'Grupo de infromações da NF referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (236, 'infnfe_ide_nfref_refcte', 'char(44)', 'Utilizar esta TAG para referenciar um CT-e emitido anteriormente, vinculada a NF-e atual', 'não', NULL, NULL, 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (237, 'infnfe_ide_nfref_refnfp_cuf', 'character varying', 'Código da UF do emitente do Documento Fiscal', 'não', 'Utilizar a Tabela do IBGE (Anexo IV - Tabela de UF, Município e País)', 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (238, 'infnfe_ide_nfref_refnfp_aamm', 'character varying', 'AAMM da emissão da NF de produtor', 'não', NULL, 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (239, 'infnfe_ide_nfref_refnfp_cnpj', 'char(14)', 'CNPJ do emitente da NF de produtor', 'não', NULL, 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (240, 'infnfe_ide_nfref_refnfp_cpf', 'char(11)', 'CPF do emitente da NF de produtor', 'não', NULL, 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (241, 'infnfe_ide_nfref_refnfp_ie', 'character varying', 'IE do emitente da NF de Produtor', 'não', NULL, 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (242, 'infnfe_ide_nfref_refnfp_mod', 'character varying', 'Código do modelo do Documento Fiscal', 'não', 'Utilizar 04 para NF de produtor ou 01 para NF Avulsa', 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (243, 'infnfe_ide_nfref_refnfp_serie', 'character varying', 'Série do Documento Fiscal, informar zero se inexistentesérie', 'não', NULL, 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);
INSERT INTO app.label VALUES (244, 'infnfe_ide_nfref_refnfp_nf', 'character varying', 'Número do Documento Fiscal - 1 – 999999999', 'não', NULL, 'Grupo com as informações NF de produtor referenciada', 'fatorefnfe', NULL);

CREATE TABLE app.fatonfe(
	id_fatonfe BIGSERIAL NOT NULL,
	infProt_chNFe char(44) PRIMARY KEY,
	infNFe_sqn bigint NOT NULL,
	informix_stnfeletronica char(1) NOT NULL DEFAULT 'A',
	informix_dhconexao varchar NULL,
	informix_nriptransmissor varchar NULL,
	informix_nrportacon int4 NULL,
 	infNFe_ide character varying,
	infNFe_ide_cUF integer,
	infNFe_ide_cNF character varying,
	infNFe_ide_natOp character varying,
	infNFe_ide_mod integer,
	infNFe_ide_serie character varying,
	infNFe_ide_nNF character varying,
	infNFe_ide_dhEmi timestamp with time zone,
	infNFe_ide_dhSaiEnt timestamp with time zone,
	infNFe_ide_tpNF integer,
	infNFe_ide_idDest integer,
	infNFe_ide_cMunFG character varying,
	infNFe_ide_tpImp integer,
	infNFe_ide_tpEmis integer,
	infNFe_ide_cDV integer,
	infNFe_ide_tpAmb integer,
	infNFe_ide_finNFe integer,
	infNFe_ide_indFinal integer,
	infNFe_ide_indPres integer,
	infNFe_ide_procEmi integer,
	infNFe_ide_verProc character varying,
	infNFe_emit_CNPJ char(14),
	infNFe_emit_CPF char(11),
	infNFe_emit_xNome character varying,
	infNFe_emit_xFant character varying,
	infNFe_emit_enderEmit_xLgr character varying,
	infNFe_emit_enderEmit_nro character varying,
	infNFe_emit_enderEmit_xCpl character varying,
	infNFe_emit_enderEmit_xBairro character varying,
	infNFe_emit_enderEmit_cMun character varying,
	infNFe_emit_enderEmit_xMun character varying,
	infNFe_emit_enderEmit_UF character varying,
	infNFe_emit_enderEmit_CEP character varying,
	infNFe_emit_enderEmit_cPais character varying,
	infNFe_emit_enderEmit_xPais character varying,
	infNFe_emit_enderEmit_fone character varying,
	infNFe_emit_IE character varying,
	infNFe_emit_IEST character varying,
	infNFe_emit_IM character varying,
	infNFe_emit_CNAE character varying,
	infNFe_emit_CRT character varying,
	infNFe_dest_CNPJ char(14),
	infNFe_dest_CPF char(11),
	infNFe_dest_idEstrangeiro character varying,
	infNFe_dest_xNome character varying,
	infNFe_dest_enderDest_xLgr character varying,
	infNFe_dest_enderDest_nro character varying,
	infNFe_dest_enderDest_xCpl character varying,
	infNFe_dest_enderDest_xBairro character varying,
	infNFe_dest_enderDest_cMun character varying,
	infNFe_dest_enderDest_xMun character varying,
	infNFe_dest_enderDest_UF character varying,
	infNFe_dest_enderDest_CEP character varying,
	infNFe_dest_enderDest_cPais character varying,
	infNFe_dest_enderDest_xPais character varying,
	infNFe_dest_enderDest_fone character varying,
	infNFe_dest_indIEDest character varying,
	infNFe_dest_IE character varying,
	infNFe_dest_ISUF character varying,
	infNFe_dest_IM character varying,
	infNFe_dest_email character varying,
	infNFe_total_ICMSTot_vBC numeric(16,2),
	infNFe_total_ICMSTot_vICMS numeric(16,2),
	infNFe_total_ICMSTot_vICMSDeson numeric(16,2),
	infNFe_total_ICMSTot_vFCPUFDest numeric(16,2),
  	infNFe_total_ICMSTot_vICMSUFDest numeric(16,2),
  	infNFe_total_ICMSTot_vICMSUFRemet numeric(16,2),
   	infNFe_total_ICMSTot_vFCP numeric(16,2),
  	infNFe_total_ICMSTot_vBCST numeric(16,2),
	infNFe_total_ICMSTot_vST numeric(16,2),
    infNFe_total_ICMSTot_vFCPST numeric(16,2),
	infNFe_total_ICMSTot_vFCPSTRet numeric(16,2),
   	infNFe_total_ICMSTot_vProd numeric(16,2),
	infNFe_total_ICMSTot_vFrete numeric(16,2),
	infNFe_total_ICMSTot_vSeg numeric(16,2),
	infNFe_total_ICMSTot_vDesc numeric(16,2),
	infNFe_total_ICMSTot_vII numeric(16,2),
	infNFe_total_ICMSTot_vIPI numeric(16,2),
	infNFe_total_ICMSTot_vPIS numeric(16,2),
	infNFe_total_ICMSTot_vCOFINS numeric(16,2),
	infNFe_total_ICMSTot_vOutro numeric(16,2),
	infNFe_total_ICMSTot_vNF numeric(16,2),
	infNFe_total_ICMSTot_vTotTrib numeric(16,2),
	infNFe_transp_modfrete character varying(1),
	infNFe_transp_vagao character varying(20),
	infNFe_transp_balsa character varying(20),
	infNFe_transp_transporta_cnpj char(14),
	infNFe_transp_transporta_cpf char(11),
	infNFe_transp_transporta_xnome character varying(100),
	infNFe_transp_transporta_ie character varying,
	infNFe_transp_transporta_xender character varying(100),
	infNFe_transp_transporta_xmun character varying(100),
	infNFe_transp_transporta_uf character varying(2),
	infNFe_transp_rettransp_vserv numeric(16,2),
	infNFe_transp_rettransp_vbcret numeric(16,2),
	infNFe_transp_rettransp_picmsret numeric(16,2),
	infNFe_transp_rettransp_vicmsret numeric(16,2),
	infNFe_transp_rettransp_cfop character varying,
	infNFe_transp_rettransp_cmunfg character varying,
	infNFe_transp_veictransp_placa character varying(8),
	infNFe_transp_veictransp_uf character varying(2),
	infNFe_transp_reboque1_placa character varying(8),
	infNFe_transp_reboque1_uf character varying(2),
	infNFe_transp_reboque2_placa character varying(8),
	infNFe_transp_reboque2_uf character varying(2),
	infNFe_transp_reboque3_placa character varying(8),
	infNFe_transp_reboque3_uf character varying(2),
	infNFe_transp_reboque4_placa character varying(8),
	infNFe_transp_reboque4_uf character varying(2),
	infNFe_transp_reboque5_placa character varying(8),
	infNFe_transp_reboque5_uf character varying(2),
	infNFe_transp_vol1_nVol character varying(60),
	infNFe_transp_vol1_qVol numeric(16,2),
	infNFe_transp_vol1_esp character varying(60),
	infNFe_transp_vol1_marca character varying(60),
	infNFe_transp_vol1_pesoL numeric(16,2),
	infNFe_transp_vol1_pesoB numeric(16,2),
	infNFe_transp_vol1_lacres_nLacre character varying(60),
   	infNFe_cobr_fat_nFat character varying(60),
   	infNFe_cobr_fat_vOrig numeric(16,2),
   	infNFe_cobr_fat_vDesc numeric(16,2),
   	infNFe_cobr_fat_vLiq numeric(16,2),
    infNFe_pag_vTroco numeric(16,2),
    infNFe_infAdic_infAdFisco character varying,
    infNFe_infAdic_infCpl character varying,
    infNFe_infAdic_obsCont_xCampo character varying,
    infNFe_infAdic_obsCont_xTexto character varying
);

CREATE INDEX fatonfe_id_idx ON app.fatonfe USING btree (id_fatonfe);
CREATE INDEX fatonfe_infnfe_sqn_idx ON app.fatonfe USING btree (infnfe_sqn); 
CREATE INDEX informix_stnfeletronica_idx ON app.fatonfe USING btree (informix_stnfeletronica);
CREATE INDEX informix_dhconexao_idx ON app.fatonfe USING btree (informix_dhconexao);
CREATE INDEX informix_nriptransmissor_idx ON app.fatonfe USING btree (informix_nriptransmissor);
CREATE INDEX fatonfe_infnfe_ide_mod_idx ON app.fatonfe USING btree (infnfe_ide_mod);
CREATE INDEX fatonfe_infnfe_ide_dhemi ON app.fatonfe USING btree (infnfe_ide_dhemi);
CREATE INDEX fatonfe_infnfe_emit_cnpj_idx ON app.fatonfe USING btree (infnfe_emit_cnpj);
CREATE INDEX fatonfe_infnfe_emit_xfant_idx ON app.fatonfe USING gin (infnfe_emit_xfant gin_trgm_ops);
CREATE INDEX fatonfe_infnfe_emit_ie_idx ON app.fatonfe USING btree (infnfe_emit_ie);
CREATE INDEX fatonfe_id_infnfe_emit_cnae ON app.fatonfe USING btree (infnfe_emit_cnae);
CREATE INDEX fatonfe_infnfe_dest_cnpj_idx ON app.fatonfe USING btree (infnfe_dest_cnpj);
CREATE INDEX fatonfe_infnfe_dest_cpf_idx ON app.fatonfe USING btree (infnfe_dest_cpf);
CREATE INDEX fatonfe_infnfe_dest_ie_idx ON app.fatonfe USING btree (infnfe_dest_ie);
CREATE INDEX infnfe_total_icmstot_vicms_idx ON app.fatonfe USING btree (infnfe_total_icmstot_vicms);
CREATE INDEX infnfe_total_icmstot_vst_idx ON app.fatonfe USING btree (infnfe_total_icmstot_vst);
CREATE INDEX infnfe_total_icmstot_vprod_idx ON app.fatonfe USING btree (infnfe_total_icmstot_vprod);
CREATE INDEX infnfe_total_icmstot_vipi_idx ON app.fatonfe USING btree (infnfe_total_icmstot_vipi);
CREATE INDEX infnfe_total_icmstot_vnf_idx ON app.fatonfe USING btree (infnfe_total_icmstot_vnf);
CREATE INDEX infnfe_transp_veictransp_placa_idx ON app.fatonfe USING btree (infnfe_transp_veictransp_placa);
CREATE INDEX infnfe_infadic_infcpl_idx ON app.fatonfe USING gin (infnfe_infadic_infcpl gin_trgm_ops);
CREATE INDEX fatonfe_emit_cnpj_dhemi_idx ON app.fatonfe USING btree (infnfe_ide_dhemi, infnfe_emit_cnpj);

CREATE TABLE app.fatoitemnfe(
	id_fatoitemnfe BIGSERIAL NOT NULL,
	infProt_chNFe char(44) NOT NULL,
	infNFe_det_nItem character varying NOT NULL,
	infNFe_det_prod_cProd character varying,
	infNFe_det_prod_cEAN character varying,
	infNFe_det_prod_xProd character varying,
	infNFe_det_prod_NCM character varying,
	infNFe_det_prod_CFOP character varying,
	infNFe_det_prod_uCom character varying,
	infNFe_det_prod_qCom numeric(16,2),
	infNFe_det_prod_vUnCom numeric(16,2),
	infNFe_det_prod_vProd numeric(16,2),
	infNFe_det_prod_cEANTrib character varying,
	infNFe_det_prod_uTrib character varying,
	infNFe_det_prod_qTrib numeric(16,2),
	infNFe_det_prod_vUnTrib numeric(16,2),
	infnfe_det_prod_vFrete numeric(16,2),
	infnfe_det_prod_vSeg numeric(16,2),
	infNFe_det_prod_vDesc numeric(16,2),
	infnfe_det_prod_vOutro numeric(16,2),
	infNFe_det_prod_indTot character varying,
	infnfe_det_prod_comb_cprodanp character varying,
	infnfe_det_prod_comb_descanp character varying,
	infnfe_det_prod_comb_pglp numeric(7,4),
	infnfe_det_prod_comb_pgnn numeric(7,4),
	infnfe_det_prod_comb_pgni numeric(7,4),
	infnfe_det_prod_comb_vpart character varying,
	infnfe_det_prod_comb_codif numeric,
	infnfe_det_prod_comb_qtemp numeric,
	infnfe_det_prod_comb_ufcons character varying(2),
	infnfe_det_prod_comb_cide_qbcprod numeric(16,2),
	infnfe_det_prod_comb_cide_valiqprod numeric(16,2),
	infnfe_det_prod_comb_cide_vcide numeric(16,2),
	infnfe_det_prod_comb_encerrante_nbico character varying,
	infnfe_det_prod_comb_encerrante_nbomba character varying,
	infnfe_det_prod_comb_encerrante_ntanque character varying,
	infnfe_det_prod_comb_encerrante_vencini numeric(16,2),
	infnfe_det_prod_comb_encerrante_vencfin numeric(16,2),
	infNFe_det_imposto_vTotTrib numeric(16,2),
	infNFe_det_imposto_ICMS_orig character varying(1),
	infNFe_det_imposto_ICMS_CST character varying(3),
	infNFe_det_imposto_ICMS_CSOSN character varying,
	infNFe_det_imposto_ICMS_vBCSTRet numeric(16,2),
	infNFe_det_imposto_ICMS_pST numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSSubstituto numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSSTRet numeric(16,2),
	infNFe_det_imposto_ICMS_vBCFCPSTRet numeric(16,2),
	infNFe_det_imposto_ICMS_pFCPSTRet numeric(16,2),
	infNFe_det_imposto_ICMS_vFCPSTRet numeric(16,2),
	infNFe_det_imposto_ICMS_vBCSTDest numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSSTDest numeric(16,2),
	infNFe_det_imposto_ICMS_pRedBCEfet numeric(16,2),
	infNFe_det_imposto_ICMS_vBCEfet numeric(16,2),
	infNFe_det_imposto_ICMS_pICMSEfet numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSEfet numeric(16,2),
	infNFe_det_imposto_ICMS_modBC character varying(1),
	infNFe_det_imposto_ICMS_pRedBC numeric(16,2),
	infNFe_det_imposto_ICMS_vBC numeric(16,2),
	infNFe_det_imposto_ICMS_pICMS numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSOp numeric(16,2),
	infNFe_det_imposto_ICMS_pDif numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSDif numeric(16,2),
	infNFe_det_imposto_ICMS_vICMS numeric(16,2),
	infNFe_det_imposto_ICMS_vBCFCP numeric(16,2),
	infNFe_det_imposto_ICMS_pFCP numeric(16,2),
	infNFe_det_imposto_ICMS_vFCP numeric(16,2),
	infNFe_det_imposto_ICMS_pFCPDif numeric(16,2),
	infNFe_det_imposto_ICMS_vFCPDif numeric(16,2),
	infNFe_det_imposto_ICMS_vFCPEfet numeric(16,2),
	infNFe_det_imposto_ICMS_modBCST character varying(1),
	infNFe_det_imposto_ICMS_pMVAST numeric(16,2),
	infNFe_det_imposto_ICMS_pRedBCST numeric(16,2),
	infNFe_det_imposto_ICMS_vBCST numeric(16,2),
	infNFe_det_imposto_ICMS_pICMSST numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSST numeric(16,2),
	infNFe_det_imposto_ICMS_vBCFCPST numeric(16,2),
	infNFe_det_imposto_ICMS_pFCPST numeric(16,2),
	infNFe_det_imposto_ICMS_vFCPST numeric(16,2),
	infNFe_det_imposto_ICMS_vICMSDeson numeric(16,2),
	infNFe_det_imposto_ICMS_motDesICMS character varying(3),
	infNFe_det_imposto_ICMS_vICMSSTDeson numeric(16,2),
	infNFe_det_imposto_ICMS_motDesICMSST character varying(3),
	infNFe_det_imposto_ICMS_pBCOp numeric(16,2),
	infNFe_det_imposto_ICMS_UFST character varying(2),
	infNFe_det_imposto_ICMS_pCredSN numeric(16,2),
	infNFe_det_imposto_II_vBC numeric(16,2),
	infNFe_det_imposto_II_vDespAdu numeric(16,2),
	infNFe_det_imposto_II_vII numeric(16,2),
	infNFe_det_imposto_II_vIOF numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_vBCUFDest numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_vBCFCPUFDest numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_pFCPUFDest numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_pICMSUFDest numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_pICMSInter character varying,
	infNFe_det_imposto_ICMSUFDest_pICMSInterPart numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_vFCPUFDest numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_vICMSUFDest numeric(16,2),
	infNFe_det_imposto_ICMSUFDest_vICMSUFRemet numeric(16,2),
	PRIMARY KEY (infProt_chNFe, infNFe_det_nItem)
);
CREATE INDEX fatoitemnfe_id_idx ON app.fatoitemnfe USING btree (id_fatoitemnfe);
CREATE INDEX fatoitemnfe_infprot_chnfe_idx ON app.fatoitemnfe USING btree (infprot_chnfe);
CREATE INDEX infnfe_det_prod_xprod_idx ON app.fatoitemnfe USING gin (infnfe_det_prod_xprod gin_trgm_ops);
CREATE INDEX infnfe_det_prod_qcom_idx ON app.fatoitemnfe USING btree (infnfe_det_prod_qcom);
CREATE INDEX infnfe_det_prod_vuncom_idx ON app.fatoitemnfe USING btree (infnfe_det_prod_vuncom);
CREATE INDEX infnfe_det_prod_vprod_idx ON app.fatoitemnfe USING btree (infnfe_det_prod_vprod);
CREATE INDEX infnfe_det_prod_qtrib_idx ON app.fatoitemnfe USING btree (infnfe_det_prod_qtrib);
CREATE INDEX infnfe_det_prod_vdesc_idx ON app.fatoitemnfe USING btree (infnfe_det_prod_vdesc);
CREATE INDEX infnfe_det_prod_comb_cprodanp_idx ON app.fatoitemnfe USING btree (infnfe_det_prod_comb_cprodanp);
CREATE INDEX infnfe_det_prod_comb_descanp_idx ON app.fatoitemnfe USING btree (infnfe_det_prod_comb_descanp);
CREATE INDEX infnfe_det_imposto_icms_vbc_idx ON app.fatoitemnfe USING btree (infnfe_det_imposto_icms_vbc);
CREATE INDEX infnfe_det_imposto_icms_vicms_idx ON app.fatoitemnfe USING btree (infnfe_det_imposto_icms_vicms);
CREATE INDEX infnfe_det_imposto_icms_vbcst_idx ON app.fatoitemnfe USING btree (infnfe_det_imposto_icms_vbcst);
CREATE INDEX infnfe_det_imposto_icms_vicmsst_idx ON app.fatoitemnfe USING btree (infnfe_det_imposto_icms_vicmsst);

CREATE TABLE app.fatonfetransito (
	id_fatonfe bigserial NOT NULL,
	infnfe_sqn int8 NOT NULL,
	infprot_chnfe bpchar(44) NOT NULL,
	infnfe_ide varchar NULL,
	infnfe_ide_mod int4 NULL,
	infnfe_ide_dhemi timestamptz NULL,
	infnfe_ide_dhsaient timestamptz NULL,
	infnfe_emit_cnpj bpchar(14) NULL,
	infnfe_emit_cpf bpchar(11) NULL,
	infnfe_dest_cnpj bpchar(14) NULL,
	infnfe_dest_cpf bpchar(14) NULL,
	infNFe_transp_veictransp_placa character varying(8),
	infNFe_transp_reboque1_placa character varying(8),
	infNFe_transp_reboque2_placa character varying(8),
	infNFe_transp_reboque3_placa character varying(8),
	infNFe_transp_reboque4_placa character varying(8),
	infNFe_transp_reboque5_placa character varying(8),
	infNFe_total_ICMSTot_vNF numeric(16,2),
	CONSTRAINT fatonfetransito_pkey PRIMARY KEY (infprot_chnfe)
);
CREATE INDEX fatonfetransito_id_idx ON app.fatonfetransito USING btree (id_fatonfe);
CREATE INDEX fatonfetransito_infnfe_dest_cnpj_idx ON app.fatonfetransito USING btree (infnfe_dest_cnpj);
CREATE INDEX fatonfetransito_infnfe_dest_cpf_idx ON app.fatonfetransito USING btree (infnfe_dest_cpf);
CREATE INDEX fatonfetransito_infnfe_emit_cnpj_idx ON app.fatonfetransito USING btree (infnfe_emit_cnpj);
CREATE INDEX fatonfetransito_infnfe_emit_cpf_idx ON app.fatonfetransito USING btree (infnfe_emit_cpf);
CREATE INDEX fatonfetransito_infnfe_ide_dhemi ON app.fatonfetransito USING btree (infnfe_ide_dhemi);
CREATE INDEX fatonfetransito_infnfe_ide_mod_idx ON app.fatonfetransito USING btree (infnfe_ide_mod);
CREATE INDEX fatonfetransito_infnfe_sqn_idx ON app.fatonfetransito USING btree (infnfe_sqn);

CREATE TABLE app.fatorefnfe(
	id_fatorefnfe bigserial NOT NULL,
	infprot_chnfe char(44) NOT NULL,
	infnfe_ide_nfref_refnfe char(44),
	infnfe_ide_nfref_refcte char(44),
	infnfe_ide_nfref_refnfp_cuf character varying,
	infnfe_ide_nfref_refnfp_aamm character varying,
	infnfe_ide_nfref_refnfp_cnpj char(14),
	infnfe_ide_nfref_refnfp_cpf char(11),
	infnfe_ide_nfref_refnfp_ie character varying,
	infnfe_ide_nfref_refnfp_mod character varying,
	infnfe_ide_nfref_refnfp_serie character varying,
	infnfe_ide_nfref_refnfp_nnf character varying,
	PRIMARY KEY (infprot_chnfe, id_fatorefnfe)
);

CREATE INDEX fatorefnfe_infprot_chnfe_idx ON app.fatorefnfe USING btree (infprot_chnfe);


-- EFD create_tables.sql - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/datalake/EFD/loader

--Create Master table
CREATE TABLE IF NOT EXISTS app.efd
(
    id serial PRIMARY KEY,
    protocolo varchar(50),
    origem char(12),
    cnpj character(14),
    insestadual character(9),
    retificacao boolean,
    periodo character(6),
    dtprotocolo timestamp,
    layout character varying(3),
    dtentrega timestamp,
    arquivo bytea,
    efd jsonb
);

--Create index
CREATE INDEX idx_EFD_cnpj ON app.efd (cnpj, periodo);
CREATE INDEX idx_EFD_insestadual ON app.efd (insestadual, periodo);




---- Tabelas de transporte
CREATE TABLE app.fatonfetransporte(

    --- Informações sobre a nota

    infProt_chNFe character varying(44) PRIMARY KEY,
    infnfe_transp_modfrete character varying(1),

    --- Dados do transportador
    infnfe_transp_transporta_cnpj character varying(14),
    infnfe_transp_transporta_cpf character varying(11),
    infnfe_transp_transporta_xnome character varying,
    infnfe_transp_transporta_ie character varying,
    infnfe_transp_transporta_xender character varying,
    infnfe_transp_transporta_xmun character varying,
    infnfe_transp_transporta_uf character varying,

    --- Dados de retenção ICMS do transporte
    infnfe_transp_rettransp_vserv numeric(16,2),
    infnfe_transp_rettransp_vbcret numeric(16,2),
    infnfe_transp_rettransp_picmsret numeric(16,2),
    infnfe_transp_rettransp_vicmsret numeric(16,2),
    infnfe_transp_rettransp_cfop character varying,
    infnfe_transp_rettransp_cmunfg character varying,

    -- Dados do veículo do transporte
    infnfe_transp_veictransp_placa character varying(7),
    infnfe_transp_veictransp_uf character varying(2),

    -- Dados do Reboque/Dolly(v2.0) do transporte
    infnfe_transp_reboque1_placa character varying(7),
    infnfe_transp_reboque1_uf character varying(2),

    infnfe_transp_reboque2_placa character varying(7),
    infnfe_transp_reboque2_uf character varying(2),

    infnfe_transp_reboque3_placa character varying(7),
    infnfe_transp_reboque3_uf character varying(2),

    infnfe_transp_reboque4_placa character varying(7),
    infnfe_transp_reboque4_uf character varying(2),

    infnfe_transp_reboque5_placa character varying(7),
    infnfe_transp_reboque5_uf character varying(2),

    -- Dados sobre vagão e balsa
    infnfe_transp_vagao character varying(20),
    infnfe_transp_balsa character varying(20)

);

CREATE TABLE app.fatonfetransportevolume(

    infProt_chNFe character varying(44) PRIMARY KEY,
    infnfe_transp_vol_nvol character varying(60),

    -- Dados dos volumes transportados
    infnfe_transp_vol_qvol numeric(16,2),
    infnfe_transp_vol_esp character varying(60),
    infnfe_transp_vol_marca character varying(60),
    infnfe_transp_vol_pesol numeric(16,2),
    infnfe_transp_vol_pesob numeric(16,2),

    -- Dados sobre lacres dos volumes
    infnfe_transp_vol_lacres_nlacre character varying(60)

);


---- Tabela FatoCTe

CREATE TABLE app.fatocte(
	protCTe_infProt_chCTe character varying(44) PRIMARY KEY,
	infCte_versao character varying(4),
	infCte_id character varying(47),
	infCte_infCTeNorm_infCarga_vCarga numeric(13,2),
	infCte_infCTeNorm_infCarga_proPred character varying,
	infCte_infCTeNorm_infCarga_xOutCat character varying(30),
	infCte_infCTeNorm_infCarga_vcargaaverb numeric(13,2),
	infCte_infCTeNorm_cobr_fat_nFat character varying,
	infCte_infCTeNorm_cobr_fat_vOrig numeric(13,2),
	infCte_infCTeNorm_cobr_fat_vDesc numeric(13,2),
	infCte_infCTeNorm_cobr_fat_vLiq numeric(13,2),
	infCte_infCTeNorm_infCtesub_chCte character varying(44),
	infCte_infCTeNorm_infCtesub_refCteAnu character varying(44),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNFe character varying(44),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_CNPJ character varying(14),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_CPF character varying(11),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_mod character varying(2),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_serie character varying(3),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_subserie character varying(3),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_nro character varying(6),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_valor numeric(13,2),
	infCte_infCTeNorm_infCtesub_tomaICMS_refNF_dEmi date,
	infCte_infCTeNorm_infCtesub_tomaICMS_refCte character varying(44),
	infCte_infCTeNorm_infCtesub_indAlteraToma char(1),
	infCte_infCTeNorm_infGlobalizado_xObs character varying(256),
	infCte_infCtecomp_chCte character varying(44),
	infCte_infCteanu_chCte character varying(44),
	infCte_infCteanu_dEmi date,
	infCte_autXML_CNPJ character varying(14),
	infCte_autXML_CPF character varying(11),
	infCte_infRespTec_CNPJ character varying(14),
	infCte_infRespTec_xContato character varying,
	infCte_infRespTec_email character varying,
	infCte_infRespTec_fone character varying(12),
	infCte_infRespTec_idCSRT character varying(3),
	infCte_infRespTec_hashCSRT character varying(28),
	infCtesupl_qrCodCTe character varying(1000),
	infCte_infCTeNorm_infModal_versaoModal character varying,
	infCte_infCTeNorm_infModal_rodo_RNTRC character varying(8),
	infCte_infCTeNorm_infModal_rodo_occ_serie character varying(3),
	infCte_infCTeNorm_infModal_rodo_occ_nOcc character varying(6),
	infCte_infCTeNorm_infModal_rodo_occ_dhEmi date,
	infCte_infCTeNorm_infModal_rodo_occ_emiOcc_CNPJ character varying(14),
	infCte_infCTeNorm_infModal_rodo_occ_emiOcc_cInt character varying(10),
	infCte_infCTeNorm_infModal_rodo_occ_emiOcc_IE character varying(14),
	infCte_infCTeNorm_infModal_rodo_occ_emiOcc_UF character varying(2),
	infCte_infCTeNorm_infModal_rodo_occ_emiOcc_fone character varying(14),
	infCte_infCTeNorm_infModal_aereo_nMinu character varying(9),
	infCte_infCTeNorm_infModal_aereo_nOca character varying(11),
	infCte_infCTeNorm_infModal_aereo_dPrevAereo date,
	infCte_infCTeNorm_infModal_aereo_natCarga_xDime character varying(14),
	infCte_infCTeNorm_infModal_aereo_natCarga_clnfManu character varying(2),
	infCte_infCTeNorm_infModal_aereo_tarifa_CL char(1),
	infCte_infCTeNorm_infModal_aereo_tarifa_cTar character varying(4),
	infCte_infCTeNorm_infModal_aereo_tarifa_vTar numeric(13,2),
	infCte_infCTeNorm_infModal_aereo_peri_nOnu character varying(4),
	infCte_infCTeNorm_infModal_aereo_peri_qTotEmb character varying(20),
	infCte_infCTeNorm_infModal_aereo_peri_infTotAp_qTotProd numeric(11,4),
	infCte_infCTeNorm_infModal_aereo_peri_infTotAp_uniAP char(1),
	infCte_infCTeNorm_infModal_ferrov_tpTraf char(1),
	infCte_infCTeNorm_infModal_ferrov_fluxo character varying(10),
	infCte_infCTeNorm_infModal_ferrov_trafMut_respFat char(1),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferrEmi char(1),
	infCte_infCTeNorm_infModal_ferrov_trafMut_vFrete numeric(13,2),
	infCte_infCTeNorm_infModal_ferrov_trafMut_chCteFerroOrigem character varying(44),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_CNPJ character varying(14),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_cInt character varying(10),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_IE character varying(14),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_xNome character varying,
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_xLgr character varying(255),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_nro character varying,
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_xCpl character varying,
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_xBairro character varying,
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_cMun character varying(7),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_xMun character varying,
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_CEP character varying(8),
	infCte_infCTeNorm_infModal_ferrov_trafMut_ferroEnv_endf_UF character varying(2),
	infCte_infCTeNorm_infModal_aquav_vPrest numeric(13,2),
	infCte_infCTeNorm_infModal_aquav_vAFRMM numeric(13,2),
	infCte_infCTeNorm_infModal_aquav_xNavio character varying,
	infCte_infCTeNorm_infModal_aquav_tpNav char(1),
	infCte_infCTeNorm_infModal_aquav_balsa_xBalsa character varying,
	infCte_infCTeNorm_infModal_aquav_balsa_nViag character varying(10),
	infCte_infCTeNorm_infModal_aquav_balsa_direc char(1),
	infCte_infCTeNorm_infModal_aquav_balsa_irin character varying(10),
	infCte_infCTeNorm_infModal_aquav_detCont_nCont character varying(20),
	infCte_infCTeNorm_infModal_aquav_detCont_lacre_nLacre character varying(20),
	infCte_infCTeNorm_infModal_aquav_detCont_infDoc_infnf_serie character varying(3),
	infCte_infCTeNorm_infModal_aquav_detCont_infDoc_infnf_nDoc character varying(20),
	infCte_infCTeNorm_infModal_aquav_detCont_infDoc_infnf_unidRat numeric(13,2),
	infCte_infCTeNorm_infModal_duto_vTar numeric(9,6),
	infCte_infCTeNorm_infModal_duto_dIni date,
	infCte_infCTeNorm_infModal_duto_dFim date,
	infCte_infCTeNorm_infModal_multimodal_COTM character varying(20),
	infCte_infCTeNorm_infModal_multimodal_indNegociavel char(1),
	infCte_infCTeNorm_infModal_multimodal_seg_infSeg_xSeg character varying(30),
	infCte_infCTeNorm_infModal_multimodal_seg_infSeg_CNPJ character varying(14),
	infCte_infCTeNorm_infModal_multimodal_seg_infSeg_nApol character varying(20),
	infCte_infCTeNorm_infModal_multimodal_seg_infSeg_nAver character varying(20),
	infCte_ide_cUF character varying(2),
	infCte_ide_cCT character varying(8),
	infCte_ide_CFOP character varying(4),
	infCte_ide_natOp character varying,
	infCte_ide_mod character varying(2),
	infCte_ide_serie character varying(3),
	infCte_ide_nCT character varying(9),
	infCte_ide_dhEmi timestamp with time zone,
	infCte_ide_tpImp char(1),
	infCte_ide_tpEmis char(1),
	infCte_ide_cDV char(1),
	infCte_ide_tpAmb char(1),
	infCte_ide_tpCTe char(1),
	infCte_ide_procEmi char(1),
	infCte_ide_verProc character varying(20),
	infCte_ide_indGlobalizado char(1),
	infCte_ide_cMunEnv character varying(7),
	infCte_ide_xMunEnv character varying,
	infCte_ide_UFEnv character varying(2),
	infCte_ide_modal character varying(2),
	infCte_ide_tpServ char(1),
	infCte_ide_cMunIni character varying(7),
	infCte_ide_xMunIni  character varying,
	infCte_ide_UFIni character varying(2),
	infCte_ide_cMunfim character varying(7),
	infCte_ide_xMunFim character varying,
	infCte_ide_UFFim character varying(2),
	infCte_ide_retira char(1),
	infCte_ide_xDetRetira character varying(160),
	infCte_ide_indIEToma char(1),
	infCte_ide_toma3_toma char(1),
	infCte_ide_toma4_toma char(1),
	infCte_ide_toma4_CNPJ character varying(14),
	infCte_ide_toma4_CPF character varying(11),
	infCte_ide_toma4_IE char(14),
	infCte_ide_toma4_xNome character varying,
	infCte_ide_toma4_xFant character varying,
	infCte_ide_toma4_fone character varying(14),
	infCte_ide_enderToma_xLgr character varying(255),
	infCte_ide_enderToma_nro character varying,
	infCte_ide_enderToma_xCpl character varying,
	infCte_ide_enderToma_xBairro character varying,
	infCte_ide_enderToma_cMun character varying(7),
	infCte_ide_enderToma_xMun character varying,
	infCte_ide_enderToma_CEP character varying(8),
	infCte_ide_enderToma_UF character varying(2),
	infCte_ide_enderToma_cPais character varying(4),
	infCte_ide_enderToma_xPais character varying,
	infCte_ide_enderToma_email character varying,
	infCte_ide_enderToma_dhCont character varying(21),
	infCte_ide_enderToma_xJust character varying(256),
	infCte_compl_xCaracAd character varying(15),
	infCte_compl_xCaracSer character varying(30),
	infCte_compl_xEmi character varying(20),
	infCte_compl_fluxo_xOrig character varying,
	infCte_compl_fluxo_xDest character varying,
	infCte_compl_fluxo_xRota character varying(10),
	infCte_compl_Entrega_semData_tpPer char(1),
	infCte_compl_Entrega_comData_tpPer char(1),
	infCte_compl_Entrega_comData_dProg date,
	infCte_compl_Entrega_noPeriodo_tpPer char(1),
	infCte_compl_Entrega_noPeriodo_dIni date,
	infCte_compl_Entrega_noPeriodo_dFim date,
	infCte_compl_Entrega_semHora_tpHor char(1),
	infCte_compl_Entrega_comHora_tpHor char(1),
	infCte_compl_Entrega_comHora_hProg time without time zone,
	infCte_compl_Entrega_noInter_tpHor char(1),
	infCte_compl_Entrega_noInter_hIni time without time zone,
	infCte_compl_Entrega_noInter_hFim time without time zone,
	infCte_compl_Entrega_noInter_origCalc character varying(40),
	infCte_compl_Entrega_noInter_destCalc character varying(40),
	infCte_compl_Entrega_noInter_xObs character varying(2000),
	infCte_compl_ObsCont_xCampo character varying(100),
	infCte_compl_ObsCont_xTexto character varying,
	infCte_compl_ObsFisco_xCampo character varying(100),
	infCte_compl_ObsFisco_xTexto char(60),
	infCte_emit_CNPJ character varying(14),
	infCte_emit_IE character varying(14),
	infCte_emit_IEST character varying(14),
	infCte_emit_xNome character varying,
	infCte_emit_xFant character varying,
	infCte_emit_enderEmit_xLgr character varying,
	infCte_emit_enderEmit_nro character varying,
	infCte_emit_enderEmit_xCpl character varying,
	infCte_emit_enderEmit_xBairro character varying,
	infCte_emit_enderEmit_cMun character varying(7),
	infCte_emit_enderEmit_xMun character varying,
	infCte_emit_enderEmit_CEP character varying(8),
	infCte_emit_enderEmit_UF character varying(2),
	infCte_emit_enderEmit_fone character varying(14),
	infCte_rem_CNPJ character varying(14),
	infCte_rem_CPF character varying(11),
	infCte_rem_IE character varying(14),
	infCte_rem_xNome character varying,
	infCte_rem_xFant character varying,
	infCte_rem_fone character varying(14),
	infCte_rem_enderReme_xLgr character varying(255),
	infCte_rem_enderReme_nro character varying,
	infCte_rem_enderReme_xCpl character varying,
	infCte_rem_enderReme_xBairro character varying,
	infCte_rem_enderReme_cMun character varying(7),
	infCte_rem_enderReme_xMun character varying,
	infCte_rem_enderReme_CEP character varying(8),
	infCte_rem_enderReme_UF character varying(2),
	infCte_rem_enderReme_cPais character varying(4),
	infCte_rem_enderReme_xPais character varying,
	infCte_rem_enderReme_email character varying,
	infCte_exped_CNPJ character varying(14),
	infCte_exped_CPF character varying(11),
	infCte_exped_IE character varying(14),
	infCte_exped_xNome character varying,
	infCte_exped_fone character varying(14),
	infCte_exped_enderExped_xLgr character varying(255),
	infCte_exped_enderExped_nro character varying,
	infCte_exped_enderExped_xCpl character varying,
	infCte_exped_enderExped_xBairro character varying,
	infCte_exped_enderExped_cMun character varying(7),
	infCte_exped_enderExped_xMun character varying,
	infCte_exped_enderExped_CEP character varying(8),
	infCte_exped_enderExped_UF character varying(2),
	infCte_exped_enderExped_cPais character varying(4),
	infCte_exped_enderExped_xPais character varying,
	infCte_exped_enderExped_email character varying,
	infCte_receb_CNPJ character varying(14),
	infCte_receb_CPF character varying(11),
	infCte_receb_IE char(14),
	infCte_receb_xNome character varying,
	infCte_receb_fone character varying(14),
	infCte_receb_enderReceb_xLgr character varying(255),
	infCte_receb_enderReceb_nro character varying,
	infCte_receb_enderReceb_xCpl character varying,
	infCte_receb_enderReceb_xBairro character varying,
	infCte_receb_enderReceb_cMun character varying(7),
	infCte_receb_enderReceb_xMun character varying,
	infCte_receb_enderReceb_CEP character varying(8),
	infCte_receb_enderReceb_UF character varying(2),
	infCte_receb_enderReceb_cPais character varying(4),
	infCte_receb_enderReceb_xPais character varying,
	infCte_receb_enderReceb_email character varying,
	infCte_dest_CNPJ character varying(14),
	infCte_dest_CPF character varying(11),
	infCte_dest_IE char(14),
	infCte_dest_xNome character varying,
	infCte_dest_fone character varying(14),
	infCte_dest_ISUF character varying(9),
	infCte_dest_enderDest_xLgr character varying(255),
	infCte_dest_enderDest_nro character varying,
	infCte_dest_enderDest_xCpl character varying,
	infCte_dest_enderDest_xBairro character varying,
	infCte_dest_enderDest_cMun character varying(7),
	infCte_dest_enderDest_xMun character varying,
	infCte_dest_enderDest_CEP character varying(8),
	infCte_dest_enderDest_UF character varying(2),
	infCte_dest_enderDest_cPais character varying(4),
	infCte_dest_enderDest_xPais character varying,
	infCte_dest_enderDest_email character varying,
	infCte_vPrest_vTPrest numeric(13,2),
	infCte_vPrest_vRec numeric(13,2),
	infCte_imp_vTotTrib numeric(13,2),
	infCte_imp_infAdFisco character varying(2000),
	infCte_imp_ICMS_ICMS00_CST character varying(2),
	infCte_imp_ICMS_ICMS00_vBC numeric(13,2),
	infCte_imp_ICMS_ICMS00_pICMS numeric(13,2),
	infCte_imp_ICMS_ICMS00_vICMS numeric(13,2),
	infCte_imp_ICMS_ICMS20_CST character varying(2),
	infCte_imp_ICMS_ICMS20_pRedBC numeric(13,2),
	infCte_imp_ICMS_ICMS20_vBC numeric(13,2),
	infCte_imp_ICMS_ICMS20_pICMS numeric(13,2),
	infCte_imp_ICMS_ICMS20_vICMS numeric(13,2),
	infCte_imp_ICMS_ICMS45_CST character varying(2),
	infCte_imp_ICMS_ICMS60_CST character varying(2),
	infCte_imp_ICMS_ICMS60_vBCSTRet numeric(13,2),
	infCte_imp_ICMS_ICMS60_vICMSSTRet numeric(13,2),
	infCte_imp_ICMS_ICMS60_pICMSSTRet numeric(13,2),
	infCte_imp_ICMS_ICMS60_vCred numeric(13,2),
	infCte_imp_ICMS_ICMS90_CST character varying(2),
	infCte_imp_ICMS_ICMS90_pRedBC numeric(13,2),
	infCte_imp_ICMS_ICMS90_vBC numeric(13,2),
	infCte_imp_ICMS_ICMS90_pICMS numeric(13,2),
	infCte_imp_ICMS_ICMS90_vICMS numeric(13,2),
	infCte_imp_ICMS_ICMS90_vCred numeric(13,2),
	infCte_imp_ICMS_ICMSOutraUF_CST character varying(2),
	infCte_imp_ICMS_ICMSOutraUF_pRedBCOutraUF numeric(13,2),
	infCte_imp_ICMS_ICMSOutraUF_vBCOutraUF numeric(13,2),
	infCte_imp_ICMS_ICMSOutraUF_pICMSOutraUF numeric(13,2),
	infCte_imp_ICMS_ICMSOutraUF_vICMSOutraUF numeric(13,2),
	infCte_imp_ICMS_ICMSSN_CST character varying(2),
	infCte_imp_ICMS_ICMSSN_indSN char(1),
	infCte_imp_ICMSUFFim_vBCUFFim numeric(13,2),
	infCte_imp_ICMSUFFim_pFCPUFFim numeric(13,2),
	infCte_imp_ICMSUFFim_pICMSUFFim numeric(13,2),
	infCte_imp_ICMSUFFim_pICMSInter numeric(13,2),
	infCte_imp_ICMSUFFim_vFCPUFFim numeric(13,2),
	infCte_imp_ICMSUFFim_vICMSUFFim numeric(13,2),
	infCte_imp_ICMSUFFim_vICMSUFIni numeric(13,2)
);



---- Tabela FatoMDFe

CREATE TABLE app.fatomdfe(
	protMDFe_infProt_chMDFe character varying(44) PRIMARY KEY,
	infMDFe_versao character varying,
	infMDFe_id character varying(48),
	infMDFe_ide_cUF character varying(2),
	infMDFe_ide_tpAmb char(1),
	infMDFe_ide_tpEmit char(1),
	infMDFe_ide_tpTransp char(1),
	infMDFe_ide_mod character varying(2),
	infMDFe_ide_serie character varying(3),
	infMDFe_ide_nMDF character varying(9),
	infMDFe_ide_cMDF character varying(8),
	infMDFe_ide_cDV char(1),
	infMDFe_ide_modal char(1),
	infMDFe_ide_dhEmi timestamp with time zone,
	infMDFe_ide_tpEmis char(1),
	infMDFe_ide_procEmi char(1),
	infMDFe_ide_verProc character varying(20),
	infMDFe_ide_UFIni character varying(2),
	infMDFe_ide_UFFim character varying(2),
	/*infMDFe_ide_infMunCarrega_cMunCarrega character varying(7),
	infMDFe_ide_infMunCarrega_xMunCarrega character varying(60),
	infMDFe_ide_infPerCurso_UFPer character varying(2),*/
	infMDFe_ide_dhIniViagem timestamp with time zone,
	infMDFe_ide_indCanalVerde char(1),
	infMDFe_ide_indCarregaPosterior char(1),
	infMDFe_emit_CNPJ character varying(14),
	infMDFe_emit_CPF character varying(11),
	infMDFe_emit_IE character varying(14),
	infMDFe_emit_xNome character varying(60),
	infMDFe_emit_xFant character varying(60),
	infMDFe_emit_enderEmit_xLgr character varying(60),
	infMDFe_emit_enderEmit_nro character varying(60),
	infMDFe_emit_enderEmit_xCpl character varying(60),
	infMDFe_emit_enderEmit_xBairro character varying(60),
	infMDFe_emit_enderEmit_cMun character varying(7),
	infMDFe_emit_enderEmit_xMun character varying(60),
	infMDFe_emit_enderEmit_CEP character varying(8),
	infMDFe_emit_enderEmit_UF character varying(2),
	infMDFe_emit_enderEmit_fone character varying(12),
	infMDFe_emit_enderEmit_email character varying(60),
	infMDFe_infModal_versaoModal character varying,
	infMDFe_infModal_rodo_infANTT_RNTRC character varying(8),
	infMDFe_infModal_rodo_veicTracao_cInt character varying(10),
	infMDFe_infModal_rodo_veicTracao_placa character varying(7),
	infMDFe_infModal_rodo_veicTracao_RENAVAM character varying(11),
	infMDFe_infModal_rodo_veicTracao_tara character varying(6),
	infMDFe_infModal_rodo_veicTracao_capKG character varying(6),
	infMDFe_infModal_rodo_veicTracao_capM3 character varying(3),
	infMDFe_infModal_rodo_veicTracao_prop_CPF character varying(11),
	infMDFe_infModal_rodo_veicTracao_prop_cnpj character varying(14),
	infMDFe_infModal_rodo_veicTracao_prop_RNTRC character varying(8),
	infMDFe_infModal_rodo_veicTracao_prop_xNome character varying(60),
	infMDFe_infModal_rodo_veicTracao_prop_IE character varying(14),
	infMDFe_infModal_rodo_veicTracao_prop_UF character varying(2),
	infMDFe_infModal_rodo_veicTracao_prop_tpProp char(1),
	infMDFe_infModal_rodo_veicTracao_condutor_xNome character varying(60),
	infMDFe_infModal_rodo_veicTracao_condutor_CPF character varying(11),
	infMDFe_infModal_rodo_veicTracao_tpRod char(2),
	infMDFe_infModal_rodo_veicTracao_tpCar char(2),
	infMDFe_infModal_rodo_veicTracao_UF char(2),
	infMDFe_infModal_rodo_veicReboque_cInt character varying(10),
	infMDFe_infModal_rodo_veicReboque_placa character varying,
	infMDFe_infModal_rodo_veicReboque_RENAVAM character varying(11),
	infMDFe_infModal_rodo_veicReboque_tara character varying(6),
	infMDFe_infModal_rodo_veicReboque_capKG character varying(6),
	infMDFe_infModal_rodo_veicReboque_capM3 character varying(3),
	infMDFe_infModal_rodo_veicReboque_prop_CPF character varying(11),
	infMDFe_infModal_rodo_veicReboque_prop_CNPJ character varying(14),
	infMDFe_infModal_rodo_veicReboque_prop_RNTRC character varying(8),
	infMDFe_infModal_rodo_veicReboque_prop_xNome character varying(60),
	infMDFe_infModal_rodo_veicReboque_prop_IE character varying(14),
	infMDFe_infModal_rodo_veicReboque_prop_UF char(2),
	infMDFe_infModal_rodo_veicReboque_prop_tpProp char(1),
	infMDFe_infModal_rodo_veicReboque_tpCar char(2),
	infMDFe_infModal_rodo_veicReboque_UF char(2),
	infMDFe_infModal_rodo_veicReboque_codAgPorto character varying(16),
	infMDFe_infModal_aereo_nac character varying,
	infMDFe_infModal_aereo_matr character varying(6),
	infMDFe_infModal_aereo_nVoo character varying(9),
	infMDFe_infModal_aereo_cAerEmb character varying,
	infMDFe_infModal_aereo_cAerDes character varying,
	infMDFe_infModal_aereo_dVoo date,
	infMDFe_infModal_ferrov_trem_xPref character varying(10),
	infMDFe_infModal_ferrov_trem_dhTrem timestamp without time zone,
	infMDFe_infModal_ferrov_trem_xOri character varying(3),
	infMDFe_infModal_ferrov_trem_xDest character varying(3),
	infMDFe_infModal_ferrov_trem_qVag character varying(3),
	infMDFe_infModal_aquav_irin character varying(10),
	infMDFe_infModal_aquav_tpEmb char(2),
	infMDFe_infModal_aquav_cEmbar character varying(10),
	infMDFe_infModal_aquav_xEmbar character varying(60),
	infMDFe_infModal_aquav_nViag character varying(10),
	infMDFe_infModal_aquav_cPrtEmb character varying(5),
	infMDFe_infModal_aquav_cPrtDest character varying(5),
	infMDFe_infModal_aquav_prtTrans character varying(60),
	infMDFe_infModal_aquav_tpNav char(1),
	infMDFe_infmodal_aquav_infTermCarreg_cTermCarreg character varying(8),
	infMDFe_infModal_aquav_infTermCarreg_xTermCarreg character varying(60),
	infMDFe_infModal_aquav_infTermDescarreg_cTermCarreg character varying(8),
	infMDFe_infModal_aquav_infTermDescarreg_xTermCarreg character varying(60),
	infMDFe_infModal_aquav_infEmbComb_cEmbComb character varying(10),
	infMDFe_infModal_aquav_infEmbComb_xBalsa character varying(60),
	infMDFe_tot_qCTe character varying(6),
	infMDFe_tot_qNFe character varying(6),
	infMDFe_tot_qMDFe character varying(6),
	infMDFe_tot_vCarga numeric(16,4),
	infMDFe_tot_cUnid character varying(2),
	infMDFe_tot_qCarga numeric(16,4),
	infMDFe_autXML_CNPJ character varying(14),
	infMDFe_autXML_CPF character varying(11),
	infMDFe_infAdic_infAdFisco character varying(2000),
	infMDFe_infAdic_infCpl character varying(5000),
	infMDFe_infRespTec_CNPJ character varying(14),
	infMDFe_infRespTec_xContato character varying(60),
	infMDFe_infRespTec_email character varying(60),
	infMDFe_infRespTec_fone character varying(12),
	infMDFe_infRespTec_idCSRT character varying(3),
	infMDFe_infRespTec_hashCSRT character varying(28),
	informix_stmdfeletronica bpchar(1) NOT NULL DEFAULT 'A'::bpchar
);
CREATE INDEX fatomdfe_informix_stmdfeletronica_idx ON app.fatomdfe USING btree (informix_stmdfeletronica);
CREATE INDEX infmdfe_infmodal_rodo_veicreboque_placa_idx ON app.fatomdfe USING btree (infmdfe_infmodal_rodo_veicreboque_placa);
CREATE INDEX infmdfe_infmodal_rodo_veictracao_placa_idx ON app.fatomdfe USING btree (infmdfe_infmodal_rodo_veictracao_placa);


-- Tabela fatoeventomdfe
CREATE TABLE app.fatoeventomdfe(
	eventoMDFe_infEvento_chMDFe character varying(44),
	eventoMDFe_versao character varying(4),
	eventoMDFe_infEvento_cOrgao character varying(3),
	eventoMDFe_infEvento_tpAmb char(1),
	eventoMDFe_infEvento_CNPJ character varying(14),
	eventoMDFe_infEvento_CPF character varying(11),
	eventoMDFe_infEvento_dhEvento timestamp with time zone,
	eventoMDFe_infEvento_tpEvento character varying(6),
	eventoMDFe_infEvento_nSeqEvento character varying(2),
	eventoMDFe_infEvento_Id character varying(54) PRIMARY KEY,
	eventoMDFe_infEvento_detEvento_Passagem_descEvento character varying(255),
	eventoMDFe_infEvento_detEvento_Passagem_cUFTransito character varying(2),
	eventoMDFe_infEvento_detEvento_Passagem_cUnidFiscal character varying(4),
	eventoMDFe_infEvento_detEvento_Passagem_xUnidFiscal character varying(60),
	eventoMDFe_infEvento_detEvento_Passagem_dhPass timestamp with time zone,
	eventoMDFe_infEvento_detEvento_Passagem_CPFFunc character varying(11),
	eventoMDFe_infEvento_detEvento_Passagem_xFunc character varying(60),
	eventoMDFe_infEvento_detEvento_Passagem_tpTransm char(1),
	eventoMDFe_infEvento_detEvento_Passagem_tpSentido char(1),
	eventoMDFe_infEvento_detEvento_Passagem_latitude float,
	eventoMDFe_infEvento_detEvento_Passagem_longitude float,
	eventoMDFe_infEvento_detEvento_Passagem_placa character varying(7),
	eventoMDFe_infEvento_detEvento_Passagem_xObs character varying(2000),
	eventoMDFe_infEvento_detEvento_PassagemAuto_descEvento character varying(255),
	eventoMDFe_infEvento_detEvento_PassagemAuto_tpTransm char(1),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_cUFTransito character varying(2),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_cIdEquip character varying(60),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_xIdEquip character varying(60),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_tpEquip char(1),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_placa character varying(7),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_tpSentido char(1),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_dhPass timestamp with time zone,
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_latitude float,
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_longitude float,
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_pesoBTotal numeric(11,4),
	eventoMDFe_infEvento_detEvento_PassagemAuto_infPass_NSU character varying(15),
	eventoMDFe_infEvento_detEvento_PassagemAuto_xObs character varying(2000),
	eventoMDFe_infEvento_detEvento_evMDFeEncFisco_descEvento character varying(255),
	eventoMDFe_infEvento_detEvento_evMDFeEncFisco_tpEnc char(1),
	eventoMDFe_infEvento_detEvento_evMDFeEncFisco_xJust character varying(2000),
	eventoMDFe_infEvento_detEvento_evMDFeLiberaPrazoCanc_descEvento character varying(255),
	eventoMDFe_infEvento_detEvento_evMDFeLiberaPrazoCanc_xObs character varying(2000),
	eventoMDFe_infEvento_detEvento_versaoEvento character varying(4),
	retEventoMDFe_versao character varying(4),
	retEventoMDFe_infEvento_tpAmb char(1),
	retEventoMDFe_infEvento_verAplic character varying(20),
	retEventoMDFe_infEvento_cOrgao character varying(2),
	retEventoMDFe_infEvento_cStat character varying(3),
	retEventoMDFe_infEvento_xMotivo character varying(255),
	retEventoMDFe_infEvento_chMDFe character varying(44),
	retEventoMDFe_infEvento_tpEvento character varying(6),
	retEventoMDFe_infEvento_xEvento character varying(60),
	retEventoMDFe_infEvento_nSeqEvento character varying(2),
	retEventoMDFe_infEvento_dhRegEvento timestamp with time zone,
	retEventoMDFe_infEvento_nProt character varying(15),
	retEventoMDFe_infEvento_id character varying(17),
	versao character varying(4),
	ipTransmissor character varying(15),
	nPortaCon character varying(5),
	dhConexao timestamp with time zone
);

-- Tabela para documentos da tag infDocMDFe
CREATE TABLE app.fatodocmdfe (
	protmdfe_infprot_chmdfe varchar(44) NOT NULL,
	infmdfe_infdoc_infmundescarga_cmundescarga varchar(7) NULL,
	infmdfe_infdoc_infmundescarga_xmundescarga varchar(60) NULL,
	infmdfe_infdoc_infmundescarga_infcte_chcte varchar(44) NULL,
	infmdfe_infdoc_infmundescarga_infcte_segcodbarra varchar(36) NULL,
	infmdfe_infdoc_infmundescarga_infcte_indreentrega bpchar(1) NULL,
	infmdfe_infdoc_infmundescarga_infcte_infentregp_qtdtotal numeric(16, 4) NULL,
	infmdfe_infdoc_infmundescarga_infcte_infentregp_qtdparcial numeric(16, 4) NULL,
	infmdfe_infdoc_infmundescarga_infnfe_chnfe varchar(44) NULL,
	infmdfe_infdoc_infmundescarga_infnfe_segcodbarra varchar(36) NULL,
	infmdfe_infdoc_infmundescarga_infnfe_indreentrega bpchar(1) NULL,
	infmdfe_infdoc_infmundescarga_infmdfetransp_chmdfe varchar(44) NULL,
	infmdfe_infdoc_infmundescarga_infmdfetransp_indreentrega bpchar(1) NULL
);

CREATE INDEX protmdfe_infprot_chmdfe_idx ON app.fatodocmdfe USING btree (protmdfe_infprot_chmdfe);
CREATE INDEX fatodocmdfe_nfe_idx ON app.fatodocmdfe USING btree (infmdfe_infdoc_infmundescarga_infnfe_chnfe);

GRANT ALL ON TABLE app.fatodocmdfe TO postgres;

-- Tabela listando municípios de carregamento de uma MDFe
CREATE TABLE app.fatomuncarregamdfe(
    id serial PRIMARY KEY,
    
    protmdfe_infprot_chmdfe character varying(44),
	    
    infmdfe_ide_infmuncarrega_cMunCarrega character varying(7),
    infmdfe_ide_infmuncarrega_xMunCarrega character varying(60)	
);

CREATE INDEX protmdfe_infprot_chmdfe_idx2 ON app.fatomuncarregamdfe USING btree (protmdfe_infprot_chmdfe);

-- Tabela descrevendo o percurso de uma mdfe (exclui partida e chegada)
CREATE TABLE app.fatopercursomdfe(
    id serial PRIMARY KEY,
    protmdfe_infprot_chmdfe character varying(44),
    infmdfe_ide_infPercurso_UFPer character(2)
);

CREATE INDEX protmdfe_infprot_chmdfe_idx3 ON app.fatopercursomdfe USING btree (protmdfe_infprot_chmdfe);

--
-- Table fatoeventocte
CREATE TABLE app.fatoeventocte(
	eventoCTe_infEvento_chCTe character varying(44),
	eventoCTe_versao character varying(4),
	eventoCTe_infEvento_cOrgao character varying(3),
	eventoCTe_infEvento_tpAmb char(1),
	eventoCTe_infEvento_CNPJ character varying(14),
	eventoCTe_infEvento_CPF character varying(11),
	eventoCTe_infEvento_dhEvento timestamp with time zone,
	eventoCTe_infEvento_tpEvento character varying(6),
	eventoCTe_infEvento_nSeqEvento character varying(2),
	eventoCTe_infEvento_Id character varying(54) PRIMARY KEY,
	eventoCTe_infEvento_detEvento_Passagem_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_Passagem_cUFTransito character varying(2),
	eventoCTe_infEvento_detEvento_Passagem_cUnidFiscal character varying(100),
	eventoCTe_infEvento_detEvento_Passagem_xUnidFiscal character varying(200),
	eventoCTe_infEvento_detEvento_Passagem_dhPass timestamp with time zone,
	eventoCTe_infEvento_detEvento_Passagem_CPFFunc character varying(11),
	eventoCTe_infEvento_detEvento_Passagem_xFunc character varying(255),
	eventoCTe_infEvento_detEvento_Passagem_tpTransm char(1),
	eventoCTe_infEvento_detEvento_Passagem_tpSentido char(1),
	eventoCTe_infEvento_detEvento_Passagem_latitude float,
	eventoCTe_infEvento_detEvento_Passagem_longitude float,
	eventoCTe_infEvento_detEvento_Passagem_placa character varying(7),
	eventoCTe_infEvento_detEvento_Passagem_SegCodBarras character varying(36),
	eventoCTe_infEvento_detEvento_Passagem_chMDFe character varying(44),
	eventoCTe_infEvento_detEvento_Passagem_xObs character varying(2000),
	eventoCTe_infEvento_detEvento_PassagemAuto_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_PassagemAuto_tpTransm char(1),
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_cUFTransito char(2),
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_cIdEquip character varying(60),
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_xIdEquip character varying(60),
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_tpEquip char(1),
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_placa character varying(7),
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_tpSentido char(1),
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_dhPass timestamp with time zone,
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_latitude float,
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_longitude float,
	eventoCTe_infEvento_detEvento_PassagemAuto_infPass_NSU character varying(15),
	eventoCTe_infEvento_detEvento_PassagemAuto_chMDFe character varying(44),
	eventoCTe_infEvento_detEvento_PassagemAuto_xObs character varying(2000),
	eventoCTe_infEvento_detEvento_evCTeAnulado_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeAnulado_chCTeAnulacao character varying(44),
	eventoCTe_infEvento_detEvento_evCTeAnulado_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeAnulado_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_MDFe_chMDFe character varying(44),
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_MDFe_modal character varying(2),
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_MDFe_dhEmi timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_MDFe_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_MDFe_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_CNPJ character varying(14),
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_IE character varying(14),
	eventoCTe_infEvento_detEvento_evCTeAutorizadoMDFe_xNome character varying(60),
	eventoCTe_infEvento_detEvento_evCTeCanceladoMDFe_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeCanceladoMDFe_MDFe_chMDFe character varying(44),
	eventoCTe_infEvento_detEvento_evCTeCanceladoMDFe_MDFe_nProtCanc character varying(20),
	eventoCTe_infEvento_detEvento_evCTeComplementar_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeComplementar_chCTeCompl character varying(44),
	eventoCTe_infEvento_detEvento_evCTeComplementar_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeComplementar_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCTeLiberaEPEC_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeLiberaEPEC_xObs character varying(2000),
	eventoCTe_infEvento_detEvento_evCTeLiberaPrazoCanc_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeLiberaPrazoCanc_xObs character varying(2000),
	eventoCTe_infEvento_detEvento_evCTeMultimodal_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeMultimodal_chCTeVinculado character varying(44),
	eventoCTe_infEvento_detEvento_evCTeMultimodal_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeMultimodal_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCTeRedespacho_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeRedespacho_chCTeRedesp character varying(44),
	eventoCTe_infEvento_detEvento_evCTeRedespacho_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeRedespacho_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCTeRedespachoInter_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeRedespachoInter_chCTe character varying(44),
	eventoCTe_infEvento_detEvento_evCTeRedespachoInter_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeRedespachoInter_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCTeSubcontratacao_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCTeSubcontratacao_chCTeSubcon character varying(44),
	eventoCTe_infEvento_detEvento_evCTeSubcontratacao_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeSubcontratacao_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCTeSubstituido_descEvento character varying(255),
	-- The next column name is being abreviated to eventoCTe_infEvento_detEvento_evCTeSubstituido_chCTeSubstituica due to the max column name size
	eventoCTe_infEvento_detEvento_evCTeSubstituido_chCTeSubstituicao character varying(44),
	eventoCTe_infEvento_detEvento_evCTeSubstituido_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCTeSubstituido_nProt character varying(20),
	eventoCTe_infEvento_detEvento_evCancCTeComplementar_descEvento character varying(255),
	eventoCTe_infEvento_detEvento_evCancCTeComplementar_chCTeCompl character varying(44),
	eventoCTe_infEvento_detEvento_evCancCTeComplementar_dhRecbto timestamp with time zone,
	eventoCTe_infEvento_detEvento_evCancCTeComplementar_nProt character varying(20),
	eventoCTe_infEvento_detEvento_versaoEvento character varying(4),
	eventoCTe_infEvento_infSolicNFF_xSolic character varying(2000),
	retEventoCTe_versao character varying(4),
	retEventoCTe_infEvento_tpAmb char(1),
	retEventoCTe_infEvento_verAplic character varying(20),
	retEventoCTe_infEvento_cOrgao character varying(2),
	retEventoCTe_infEvento_cStat character varying(3),
	retEventoCTe_infEvento_xMotivo character varying(255),
	retEventoCTe_infEvento_chCTe character varying(44),
	retEventoCTe_infEvento_tpEvento character varying(6),
	retEventoCTe_infEvento_xEvento character varying(60),
	retEventoCTe_infEvento_nSeqEvento character varying(2),
	retEventoCTe_infEvento_dhRegEvento timestamp with time zone,
	retEventoCTe_infEvento_nProt character varying(20),
	retEventoCTe_infEvento_id character varying(17),
	versao character varying(4),
	ipTransmissor character varying(15),
	nPortaCon character varying(5),
	dhConexao timestamp with time zone
);


-- Tabela fatoevento
CREATE TABLE app.fatoevento(
    id SERIAL PRIMARY KEY,
    evento_chdfe character varying(44),                                     -- Chave do DFe associado ao evento
    evento_tipo_dfe character varying(2),                                   -- Tipo do documento: MDFE ou CTE
    evento_infevento_dhregpassagem timestamp without time zone,             -- Data e hora do evento
    evento_infevento_dsreflocal character varying(256),                      -- Referência do local do evento
    evento_infevento_dstipoveiculo character varying(20),                   -- Tipo do veículo
    evento_infevento_nocor character varying(20),                           -- Cor do veículo
    evento_infevento_nomarcamodelo character varying(40),                   -- Marca e modelo do veículo
    evento_infevento_norodovia character varying(5),                        -- Rodovia em que o evento aconteceu
    evento_infevento_nrlatitude float,                                      -- Latitude onde o evento aconteceu
    evento_infevento_nrlongitude float,                                     -- Longitude de onde o evento aconteceu
    evento_infevento_nrplaca character varying(7),                          -- Placa do veículo vinculado ao evento
    evento_infevento_nrvelocidade int,                                      -- Velocidade do veículo
    evento_infevento_nrkmrodovia int,                                       -- Quilometragem da rodovia no local do evento
    evento_infevento_sguf character varying(2),                             -- UF em que o evento aconteceu
    evento_infevento_tpsentido character varying(65),                       -- Sentido da rodovia onde o evento aconteceu
    evento_infevento_tpvia char,
	evento_valor_tot_cmdfe float8											-- TODO: Identificar porpósito do campo
);

CREATE INDEX evento_infevento_dhregpassagem_idx ON app.fatoevento USING btree (evento_infevento_dhregpassagem);
CREATE INDEX evento_infevento_dhregpassagem_DESC_idx ON app.fatoevento (evento_infevento_dhregpassagem DESC NULLS LAST);

																				




-- Tabela fatocamera
CREATE TABLE app.fatocamera(
    id SERIAL PRIMARY KEY,
    category character varying(40),
    name character varying(80),
    description character varying(256),
    status boolean,
	municipio character varying(60),
    nrlatitude float,                    -- Latitude da câmera
    nrlongitude float                    -- Longitude da câmera
);

-- change database and user
\connect datalake postgres

-- privileges and permissions
ALTER SCHEMA public OWNER TO datalakeuser;


-- Anonymizer - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/anonymizer

-- change database and user
\connect datalake postgres

-- preload extension on datalake
ALTER DATABASE datalake SET session_preload_libraries = 'anon';

-- create the extension
CREATE EXTENSION anon CASCADE;

-- load extension
SELECT anon.init();

-- privileges and permissions
ALTER SCHEMA anon OWNER TO datalakeuser;
GRANT USAGE ON SCHEMA anon TO datalakeuser;
GRANT ALL ON ALL TABLES IN SCHEMA anon TO datalakeuser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA anon TO datalakeuser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA anon TO datalakeuser;

-- change database and user
\connect datalake datalakeuser

-- TODO: recreate all MATERIALIZED VIEWS according to new tables
-- creating anon mviews

CREATE MATERIALIZED VIEW appmask.fatonfe AS SELECT
    id_fatonfe,
    infNFe_ide,
    infNFe_ide_cUF,
    anon.pseudo_iban(infNFe_ide_cNF) AS infNFe_ide_cNF,
    infNFe_ide_natOp,
    infNFe_ide_mod,
    anon.pseudo_siren(infNFe_ide_serie) AS infNFe_ide_serie,
    anon.pseudo_siren(infNFe_ide_nNF) AS infNFe_ide_nNF,
    infNFe_ide_dhEmi,
    infNFe_ide_dhSaiEnt,
    infNFe_ide_tpNF,
    infNFe_ide_idDest,
    anon.pseudo_siren(infNFe_ide_cMunFG) AS infNFe_ide_cMunFG,
    infNFe_ide_tpImp,
    infNFe_ide_tpEmis,
    18*infNFe_ide_cDV AS infNFe_ide_cDV,
    infNFe_ide_tpAmb,
    infNFe_ide_finNFe,
    infNFe_ide_indFinal,
    infNFe_ide_indPres,
    infNFe_ide_procEmi,
    infNFe_ide_verProc,
    anon.pseudo_siret(infNFe_emit_CNPJ) AS infNFe_emit_CNPJ,
    anon.pseudo_siret(infNFe_emit_CPF) AS infNFe_emit_CPF,
    anon.pseudo_first_name(infNFe_emit_xNome) AS infNFe_emit_xNome,
    anon.pseudo_company(infNFe_emit_xFant) AS infNFe_emit_xFant,
    anon.pseudo_city(infNFe_emit_enderEmit_xLgr) AS infNFe_emit_enderEmit_xLgr,
    anon.pseudo_siren(infNFe_emit_enderEmit_nro) AS infNFe_emit_enderEmit_nro,
    anon.pseudo_region(infNFe_emit_enderEmit_xCpl) AS infNFe_emit_enderEmit_xCpl,
    anon.pseudo_region(infNFe_emit_enderEmit_xBairro) AS infNFe_emit_enderEmit_xBairro,
    anon.pseudo_siren(infNFe_emit_enderEmit_cMun) AS infNFe_emit_enderEmit_cMun,
    anon.pseudo_city(infNFe_emit_enderEmit_xMun) AS infNFe_emit_enderEmit_xMun,
    anon.pseudo_region(infNFe_emit_enderEmit_UF) AS infNFe_emit_enderEmit_UF,
    anon.pseudo_siren(infNFe_emit_enderEmit_CEP) AS infNFe_emit_enderEmit_CEP,
    anon.pseudo_siren(infNFe_emit_enderEmit_cPais) AS infNFe_emit_enderEmit_cPais,
    anon.pseudo_country(infNFe_emit_enderEmit_xPais) AS infNFe_emit_enderEmit_xPais,
    anon.pseudo_siren(infNFe_emit_enderEmit_fone) AS infNFe_emit_enderEmit_fone,
    anon.pseudo_siren(infNFe_emit_IE) AS infNFe_emit_IE,
    anon.pseudo_siren(infNFe_emit_IEST) AS infNFe_emit_IEST,
    anon.pseudo_siren(infNFe_emit_IM) AS infNFe_emit_IM,
    anon.pseudo_siren(infNFe_emit_CNAE) AS infNFe_emit_CNAE,
    infNFe_emit_CRT,
    anon.pseudo_siret(infNFe_dest_CNPJ) AS infNFe_dest_CNPJ,
    anon.pseudo_siret(infNFe_dest_CPF) AS infNFe_dest_CPF,
    anon.pseudo_siren(infNFe_dest_idEstrangeiro) AS infNFe_dest_idEstrangeiro,
    anon.pseudo_first_name(infNFe_dest_xNome) AS infNFe_dest_xNome,
    anon.pseudo_region(infNFe_dest_enderDest_xLgr) AS infNFe_dest_enderDest_xLgr,
    anon.pseudo_siren(infNFe_dest_enderDest_nro) AS infNFe_dest_enderDest_nro,
    anon.pseudo_region(infNFe_dest_enderDest_xCpl) AS infNFe_dest_enderDest_xCpl,
    anon.pseudo_region(infNFe_dest_enderDest_xBairro) AS infNFe_dest_enderDest_xBairro,
    anon.pseudo_siren(infNFe_dest_enderDest_cMun) AS infNFe_dest_enderDest_cMun,
    anon.pseudo_city(infNFe_dest_enderDest_xMun) AS infNFe_dest_enderDest_xMun,
    anon.pseudo_region(infNFe_dest_enderDest_UF) AS infNFe_dest_enderDest_UF,
    anon.pseudo_siren(infNFe_dest_enderDest_CEP) AS infNFe_dest_enderDest_CEP,
    anon.pseudo_siren(infNFe_dest_enderDest_cPais) AS infNFe_dest_enderDest_cPais,
    anon.pseudo_country(infNFe_dest_enderDest_xPais) AS infNFe_dest_enderDest_xPais,
    anon.pseudo_siren(infNFe_dest_enderDest_fone) AS infNFe_dest_enderDest_fone,
    anon.pseudo_siren(infNFe_dest_indIEDest) AS infNFe_dest_indIEDest,
    anon.pseudo_siren(infNFe_dest_IE) AS infNFe_dest_IE,
    anon.pseudo_siren(infNFe_dest_ISUF) AS infNFe_dest_ISUF,
    anon.pseudo_siren(infNFe_dest_IM) AS infNFe_dest_IM,
    anon.pseudo_email(infNFe_dest_email) AS infNFe_dest_email,
    infNFe_total_ICMSTot_vBC,
    infNFe_total_ICMSTot_vICMS,
    infNFe_total_ICMSTot_vICMSDeson,
    infNFe_total_ICMSTot_vST,
    infNFe_total_ICMSTot_vProd,
    infNFe_total_ICMSTot_vFrete,
    infNFe_total_ICMSTot_vSeg,
    infNFe_total_ICMSTot_vDesc,
    infNFe_total_ICMSTot_vII,
    infNFe_total_ICMSTot_vIPI,
    infNFe_total_ICMSTot_vPIS,
    infNFe_total_ICMSTot_vCOFINS,
    infNFe_total_ICMSTot_vOutro,
    infNFe_total_ICMSTot_vNF,
    infNFe_total_ICMSTot_vTotTrib ,
   	infNFe_cobr_fat_nFat,
   	infNFe_cobr_fat_vOrig,
   	infNFe_cobr_fat_vDesc,
   	infNFe_cobr_fat_vLiq,
    infNFe_pag_vTroco,
    infNFe_infAdic_infAdFisco,
    infNFe_infAdic_infCpl ,
    infNFe_infAdic_obsCont_xCampo ,
    infNFe_infAdic_obsCont_xTexto ,
    encode(digest(infProt_chNFe, 'sha256'), 'hex') AS infProt_chNFe,
    informix_stnfeletronica,
	informix_dhconexao,
	informix_nriptransmissor,
	informix_nrportacon
FROM app.fatonfe;


CREATE MATERIALIZED VIEW appmask.fatoitemnfe AS SELECT
    id_fatoitemnfe,
    encode(digest(infProt_chNFe, 'sha256'), 'hex') AS infProt_chNFe,
   	infNFe_det_nItem,
	infNFe_det_prod_cProd,
	infNFe_det_prod_cEAN,
	infNFe_det_prod_xProd,
	infNFe_det_prod_NCM,
	infNFe_det_prod_CFOP,
	infNFe_det_prod_uCom,
	infNFe_det_prod_qCom,
	infNFe_det_prod_vUnCom,
	infNFe_det_prod_vProd,
	infNFe_det_prod_cEANTrib,
	infNFe_det_prod_uTrib,
	infNFe_det_prod_qTrib,
	infNFe_det_prod_vUnTrib,
    infnfe_det_prod_vFrete 
    infnfe_det_prod_vSeg,
    infNFe_det_prod_vDesc,
    infnfe_det_prod_vOutro,
	infNFe_det_prod_indTot,
	infNFe_det_imposto_vTotTrib,
	infNFe_det_imposto_ICMS_orig,
	infNFe_det_imposto_ICMS_CST,
    infNFe_det_imposto_ICMS_CSOSN,
   	infNFe_det_imposto_ICMS_vBCSTRet,
   	infNFe_det_imposto_ICMS_pST,
   	infNFe_det_imposto_ICMS_vICMSSubstituto,
    infNFe_det_imposto_ICMS_vICMSSTRet,
    infNFe_det_imposto_ICMS_vBCFCPSTRet,
    infNFe_det_imposto_ICMS_pFCPSTRet,
    infNFe_det_imposto_ICMS_vFCPSTRet,
    infNFe_det_imposto_ICMS_vBCSTDest,
    infNFe_det_imposto_ICMS_vICMSSTDest,
    infNFe_det_imposto_ICMS_pRedBCEfet,
    infNFe_det_imposto_ICMS_vBCEfet,
    infNFe_det_imposto_ICMS_pICMSEfet,
    infNFe_det_imposto_ICMS_vICMSEfet,
	infNFe_det_imposto_ICMS_modBC,
    infNFe_det_imposto_ICMS_pRedBC,
	infNFe_det_imposto_ICMS_vBC,
	infNFe_det_imposto_ICMS_pICMS,
	infNFe_det_imposto_ICMS_vICMSOp,
	infNFe_det_imposto_ICMS_pDif,
	infNFe_det_imposto_ICMS_vICMSDif,
    infNFe_det_imposto_ICMS_vICMS,
	infNFe_det_imposto_ICMS_vBCFCP,
    infNFe_det_imposto_ICMS_pFCP,
    infNFe_det_imposto_ICMS_vFCP,
    infNFe_det_imposto_ICMS_pFCPDif,
    infNFe_det_imposto_ICMS_vFCPDif,
    infNFe_det_imposto_ICMS_vFCPEfet,
   	infNFe_det_imposto_ICMS_modBCST,
    infNFe_det_imposto_ICMS_pMVAST,
    infNFe_det_imposto_ICMS_pRedBCST,
    infNFe_det_imposto_ICMS_vBCST,
    infNFe_det_imposto_ICMS_pICMSST,
    infNFe_det_imposto_ICMS_vICMSST,
    infNFe_det_imposto_ICMS_vBCFCPST,
    infNFe_det_imposto_ICMS_pFCPST,
    infNFe_det_imposto_ICMS_vFCPST,
    infNFe_det_imposto_ICMS_vICMSDeson,
    infNFe_det_imposto_ICMS_motDesICMS,
    infNFe_det_imposto_ICMS_vICMSSTDeson,
    infNFe_det_imposto_ICMS_motDesICMSST,
    infNFe_det_imposto_ICMS_pBCOp,
    infNFe_det_imposto_ICMS_UFST,
    infNFe_det_imposto_ICMS_pCredSN,
    infNFe_det_imposto_II_vBC,
    infNFe_det_imposto_II_vDespAdu,
    infNFe_det_imposto_II_vII,
    infNFe_det_imposto_II_vIOF,
    infNFe_det_imposto_ICMSUFDest_vBCUFDest,
    infNFe_det_imposto_ICMSUFDest_vBCFCPUFDest,
    infNFe_det_imposto_ICMSUFDest_pFCPUFDest,
    infNFe_det_imposto_ICMSUFDest_pICMSUFDest,
    infNFe_det_imposto_ICMSUFDest_pICMSInter,
    infNFe_det_imposto_ICMSUFDest_pICMSInterPart,
    infNFe_det_imposto_ICMSUFDest_vFCPUFDest,
    infNFe_det_imposto_ICMSUFDest_vICMSUFDest,
    infNFe_det_imposto_ICMSUFDest_vICMSUFRemet
FROM app.fatoitemnfe;
-- Hasura - see https://github.com/arialab/sefazpb-infra/tree/master/hasura

-- change database and user
\connect datalake postgres

-- create a separate user for hasura
CREATE USER hasurauser WITH PASSWORD 'quaevu8U';

-- grant connection to 'hasurauser' on database 'datalake'
GRANT CONNECT ON DATABASE datalake TO hasurauser;

-- create pg_repack extension
CREATE EXTENSION pg_repack;

-- create pgcrypto extension, required for UUID
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- create the schemas required by the hasura system
CREATE SCHEMA IF NOT EXISTS hdb_catalog;
CREATE SCHEMA IF NOT EXISTS hdb_views;

-- make the user an owner of system schemas
ALTER SCHEMA hdb_catalog OWNER TO hasurauser;
ALTER SCHEMA hdb_views OWNER TO hasurauser;

-- grant select permissions on information_schema and pg_catalog. This is
-- required for hasura to query list of available tables
GRANT SELECT ON ALL TABLES IN SCHEMA information_schema TO hasurauser;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO hasurauser;

-- set search path to include schemas for a particular role
ALTER ROLE hasurauser SET search_path TO public,app,appmask;

-- change database and user
\connect datalake datalakeuser

-- This is dependent on what access to your tables/schemas you want give 
-- to hasura. If you want expose the public schema for GraphQL query then 
-- give permissions on public schema to the hasura user.

-- app
GRANT USAGE ON SCHEMA app TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA app TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA app TO hasurauser;

-- appmask
GRANT USAGE ON SCHEMA appmask TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA appmask TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA appmask TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA appmask TO hasurauser;


-- Hasura JWT Auth - see https://github.com/arialab/sefazpb-infra/tree/master/hasura/hasura_jwt_auth

-- change database and user
\connect datalake postgres

-- setting jwt_secret_key
ALTER DATABASE datalake SET "hasura.jwt_secret_key" TO 'IouHeDgirik0vhBkNw4iFQkUo3tzrwPYNGWHfCjDqsNujDcpV77xIeg24luLGq2F';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- change database and user
\connect datalake datalakeuser

-- creating functions
CREATE OR REPLACE FUNCTION url_encode(data bytea) RETURNS text LANGUAGE sql AS $$
    SELECT translate(encode(data, 'base64'), E'+/=\n', '-_');
$$;

CREATE OR REPLACE FUNCTION url_decode(data text) RETURNS bytea LANGUAGE sql AS $$
WITH t AS (SELECT translate(data, '-_', '+/') AS trans),
     rem AS (SELECT length(t.trans) % 4 AS remainder FROM t) -- compute padding size
    SELECT decode(
        t.trans ||
        CASE WHEN rem.remainder > 0
           THEN repeat('=', (4 - rem.remainder))
           ELSE '' END,
    'base64') FROM t, rem;
$$;

CREATE OR REPLACE FUNCTION algorithm_sign(signables text, secret text, algorithm text)
RETURNS text LANGUAGE sql AS $$
WITH
  alg AS (
    SELECT CASE
      WHEN algorithm = 'HS256' THEN 'sha256'
      WHEN algorithm = 'HS384' THEN 'sha384'
      WHEN algorithm = 'HS512' THEN 'sha512'
      ELSE '' END AS id)  -- hmac throws error
SELECT url_encode(hmac(signables, secret, alg.id)) FROM alg;
$$;

CREATE OR REPLACE FUNCTION sign(payload json, secret text, algorithm text DEFAULT 'HS256')
RETURNS text LANGUAGE sql AS $$
WITH
  header AS (
    SELECT url_encode(convert_to('{"alg":"' || algorithm || '","typ":"JWT"}', 'utf8')) AS data
    ),
  payload AS (
    SELECT url_encode(convert_to(payload::text, 'utf8')) AS data
    ),
  signables AS (
    SELECT header.data || '.' || payload.data AS data FROM header, payload
    )
SELECT
    signables.data || '.' ||
    algorithm_sign(signables.data, secret, algorithm) FROM signables;
$$;

CREATE OR REPLACE FUNCTION verify(token text, secret text, algorithm text DEFAULT 'HS256')
RETURNS table(header json, payload json, valid boolean) LANGUAGE sql AS $$
  SELECT
    convert_from(url_decode(r[1]), 'utf8')::json AS header,
    convert_from(url_decode(r[2]), 'utf8')::json AS payload,
    r[3] = algorithm_sign(r[1] || '.' || r[2], secret, algorithm) AS valid
  FROM regexp_split_to_array(token, '\.') r;
$$;

create table hasura_user(
    id serial primary key,
    email varchar unique,
    crypt_password varchar,
    cleartext_password varchar,
    default_role varchar default 'user',
    allowed_roles jsonb default '["user"]',
    enabled boolean default true,
    jwt_token text
);

create or replace function hasura_encrypt_password(cleartext_password in text, salt in text) returns varchar as $$
    select crypt(
        encode(hmac(cleartext_password, current_setting('hasura.jwt_secret_key'), 'sha256'), 'escape'),
        salt);
$$ language sql stable;

create or replace function hasura_user_encrypt_password() returns trigger as $$
begin
    if new.cleartext_password is not null and trim(new.cleartext_password) <> '' then
        new.crypt_password := (hasura_encrypt_password(new.cleartext_password, gen_salt('bf')));
    end if;
    new.cleartext_password = null;
    new.jwt_token = null;
    return new;
end;
$$ language 'plpgsql';

create trigger hasura_user_encrypt_password_trigger
before insert or update on hasura_user
for each row execute procedure hasura_user_encrypt_password();

-- https://docs.hasura.io/1.0/graphql/manual/auth/authentication/jwt.html#configuring-jwt-mode
create or replace function hasura_auth(email in varchar, cleartext_password in varchar) returns setof hasura_user as $$
    select
        id,
        email,
        crypt_password,
        cleartext_password,
        default_role,
        allowed_roles,
        enabled,
        sign(
            json_build_object(
                'sub', id::text,
                'iss', 'Hasura-JWT-Auth',
                'iat', round(extract(epoch from now())),
                'exp', round(extract(epoch from now() + interval '7 days')),
                'https://hasura.io/jwt/claims', json_build_object(
                    'x-hasura-user-id', id::text,
                    'x-hasura-default-role', default_role,
                    'x-hasura-allowed-roles', allowed_roles
                )
            ), current_setting('hasura.jwt_secret_key')) as jwt_token
    from hasura_user h
    where h.email = hasura_auth.email
    and h.enabled
    and h.crypt_password = hasura_encrypt_password(hasura_auth.cleartext_password, h.crypt_password);
$$ language 'sql' stable;

-- initial user
insert into hasura_user(email, cleartext_password, default_role, allowed_roles) values ('poc@serpb.local', '48jL1bzADd04', 'g_ufpb_datalake_gecof1', '["g_ufpb_datalake_all", "g_ufpb_datalake_admin", "g_ufpb_datalake_gecof1", "g_ufpb_datalake_anon"]');
insert into hasura_user(email, cleartext_password, default_role, allowed_roles) values ('uepb@serpb.local', 'Pz7eMzrNXjzw', 'g_uepb_datalake_app1', '["g_uepb_datalake_app1"]');
insert into hasura_user(email, cleartext_password, default_role, allowed_roles) values ('cicc@serpb.local', 'wPiBssDzhYTm', 'g_ufpb_datalake_cicc', '["g_ufpb_datalake_cicc"]');

GRANT USAGE ON SCHEMA public TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA public TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO hasurauser;
