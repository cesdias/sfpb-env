-- Datalake - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/datalake

-- user
CREATE USER datalakeuser WITH PASSWORD 'EQuohG2i';

-- database
CREATE DATABASE datalake;

-- privileges and permissions
REVOKE ALL ON DATABASE datalake FROM public;
ALTER DATABASE datalake OWNER TO datalakeuser;
GRANT CONNECT ON DATABASE datalake to datalakeuser;
ALTER ROLE datalakeuser SET search_path TO public,app,appmask,cicc;

-- change database and user
\connect datalake datalakeuser

-- schemas
CREATE SCHEMA app;
CREATE SCHEMA appmask;
CREATE SCHEMA cicc;

-- tables
CREATE TABLE app.label (
    id integer,
    nomecoluna text,
    tipodado text,
    descricao text,
    anonimizacao text,
    observacao text,
    grupo text,
    tabela text
);

INSERT INTO app.label VALUES
    (0, 'infprot_chnfe', 'character varying', 'Chaves de acesso da NF-e', 'sim', 'compostas por: UF do emitente, AAMM da emissão da NFe, CNPJ do emitente, modelo, série e número da NF-e e código numérico+DV', NULL, 'fatonfe'),
    (1, 'infnfe_ide', 'character varying', 'Identificação da NF-e', 'não', NULL, 'Grupo A. Dados da Nota Fiscal eletrônica', 'fatonfe'),
    (2, 'infnfe_ide_cuf', 'integer', 'Código da UF do emitente do Documento Fiscal', 'não', 'Número aleatório que compõe o código numérico gerado pelo emitente para cada NF-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (3, 'infnfe_ide_cnf', 'character varying', 'Código numérico para evitar acesso indevido ', 'sim', 'Número aleatório que compõe o código numérico gerado pelo emitente para cada NF-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (4, 'infnfe_ide_natop', 'character varying', 'Descrição da Natureza da Operação', 'não', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (5, 'infnfe_ide_mod', 'integer', 'Código do modelo do Documento Fiscal', 'não', '55 - NF-e; 65 - NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (6, 'infnfe_ide_serie', 'character varying', 'Série do Documento Fiscal ', 'sim', 'Série normal - 0-889; Avulsa Fisco - 890-899; SCAN - 900-999', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (7, 'infnfe_ide_nnf', 'character varying', 'Número do Documento Fiscal', 'sim', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (8, 'infnfe_ide_dhemi', 'timestamp with time zone', 'Data e Hora de emissão do Documento Fiscal ', 'não', '(AAAA-MM-DDTHH:mm:ssTZD) Ex.: 2012-09-01T13:00:00-03:00', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (9, 'infnfe_ide_dhsaient', 'timestamp with time zone', 'Data e Hora da saída ou de entrada da mercadoria/produto ', 'não', '(AAAA-MM-DDTHH:mm:ssTZD) Ex.: 2012-09-01T13:00:00-03:00', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (10, 'infnfe_ide_tpnf', 'integer', 'Tipo do Documento Fiscal', 'não', '0 - Entrada; 1 - Saída', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (11, 'infnfe_ide_iddest', 'integer', 'Identificador de Local de destino da operação ', 'não', '1 - Interna; 2 -Interestadual; 3 - Exterior', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (12, 'infnfe_ide_cmunfg', 'character varying', 'Código do Município de Ocorrência do Fato Gerador', 'sim', 'Utilizar a Tabela do IBGE.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (13, 'infnfe_ide_tpimp', 'integer', 'Formato de impressão do DANFE', 'não', '0 - sem DANFE;  1 - DANFe Retrato; 2 - DANFe Paisagem; 3 - DANFe Simplificado; 4 - DANFe NFC-e; 5 - DANFe NFC-e em mensagem eletrônica', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (14, 'infnfe_ide_tpemis', 'integer', 'Forma de emissão da NF-e ', 'não', '1 - Normal 2 - Contingência FS 3 - Contingência SCAN 4 - Contingência DPEC 5 - Contingência FSDA 6 - Contingência SVC - AN 7 - Contingência SVC - RS 9 - Contingência off-line NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (15, 'infnfe_ide_cdv', 'integer', 'Dígito Verificador da Chave de Acesso da NF-e', 'sim', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (16, 'infnfe_ide_tpamb', 'integer', 'Identificação do Ambiente', 'não', '1 - Produção 2 - Homologação', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (17, 'infnfe_ide_finnfe', 'integer', 'Finalidade da emissão da NF-e', 'não', '1 - NFe normal 2 - NFe complementar 3 - NFe de ajuste 4 - Devolução/Retorno', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (18, 'infnfe_ide_indfinal', 'integer', 'Indica operação com consumidor final', 'não', '0 - Não; 1 - Consumidor Final', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (19, 'infnfe_ide_indpres', 'integer', 'Indicador de presença do comprador no estabelecimento comercial no momento da operação', 'não', '0 - Não se aplica (ex.: Nota Fiscal complementar ou de ajuste), 1 - Operação presencial; 2 - Não presencial, internet; 3 - Não presencial, teleatendimento; 4 - NFC-e entrega em domicílio; 5 - Operação presencial, fora do estabelecimento; 9 - Não presencial, outros', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (20, 'infnfe_ide_procemi', 'integer', 'Processo de emissão utilizado com a seguinte codificação', 'não', '0 - Emissão de NF-e com aplicativo do contribuinte; 1 - Emissão de NF-e avulsa pelo Fisco; 2 - Emissão de NF-e avulsa, pelo contribuinte com seu certificado digital, através do sitedo Fisco; 3 - 
    Emissão de NF-e pelo contribuinte com aplicativo fornecido pelo Fisco.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (21, 'infnfe_ide_verproc', 'character varying', 'Versão do aplicativo utilizado no processo de emissão', 'não', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
    (22, 'infnfe_emit_cnpj', 'character varying', 'Número do CNPJ do emitente', 'sim', 'Tipo de dado no BD é diferente (varchar), o tipo consta na label como char(14) para evitar que a busca use nesse campo ilike', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (23, 'infnfe_emit_cpf', 'character varying', 'Número do CPF do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (24, 'infnfe_emit_xnome', 'character varying', 'Razão Social ou Nome do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (25, 'infnfe_emit_xfant', 'character varying', 'Nome fantasia do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (26, 'infnfe_emit_enderemit_xlgr', 'character varying', 'Logradouro do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (27, 'infnfe_emit_enderemit_nro', 'character varying', 'Número do endereço do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (28, 'infnfe_emit_enderemit_xcpl', 'character varying', 'Complemento do endereço do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (29, 'infnfe_emit_enderemit_xbairro', 'character varying', 'Bairro do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (30, 'infnfe_emit_enderemit_cmun', 'character varying', 'Código do município do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (31, 'infnfe_emit_enderemit_xmun', 'character varying', 'Nome do município do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (32, 'infnfe_emit_enderemit_uf', 'character varying', 'Sigla da UF do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (33, 'infnfe_emit_enderemit_cep', 'character varying', 'CEP - NT 2011/004 do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (34, 'infnfe_emit_enderemit_cpais', 'character varying', 'Código do país do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (35, 'infnfe_emit_enderemit_xpais', 'character varying', 'Nome do país do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (36, 'infnfe_emit_enderemit_fone', 'character varying', 'Código DDD + número do telefone (v.2.0) do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (37, 'infnfe_emit_ie', 'character varying', 'Inscrição Estadual do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (38, 'infnfe_emit_iest', 'character varying', 'Inscricao Estadual do Substituto Tributário do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (39, 'infnfe_emit_im', 'character varying', 'Inscrição Municipal do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (40, 'infnfe_emit_cnae', 'character varying', 'CNAE Fiscal do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (41, 'infnfe_emit_crt', 'character varying', 'Código de Regime Tributário do emitente', 'não', 'Este campo será obrigatoriamente preenchido com: 1 – Simples Nacional; 2 – Simples Nacional – excesso de sublimite de receita bruta; 3 – Regime Normal.', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
    (42, 'infnfe_dest_cnpj', 'char(14)', 'Número do CNPJ do destinatário', 'sim', 'Tipo de dado no BD é diferente (varchar), o tipo consta na label como char(14) para evitar que a busca use nesse campo ilike', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (43, 'infnfe_dest_cpf', 'character varying', 'Número do CPF do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (44, 'infnfe_dest_idestrangeiro', 'character varying', 'Identificador do destinatário, em caso de comprador estrangeiro', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (45, 'infnfe_dest_xnome', 'character varying', 'Razão Social ou nome do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (46, 'infnfe_dest_enderdest_xlgr', 'character varying', 'Logradouro do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (47, 'infnfe_dest_enderdest_nro', 'character varying', 'Número do endereço do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (48, 'infnfe_dest_enderdest_xcpl', 'character varying', 'Complemento do endereço do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (49, 'infnfe_dest_enderdest_xbairro', 'character varying', 'Bairro do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (50, 'infnfe_dest_enderdest_cmun', 'character varying', 'Código do município do destinatário', 'sim', 'Utilizar a tabela do IBGE, informar 9999999 para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (51, 'infnfe_dest_enderdest_xmun', 'character varying', 'Nome do município do destinatário', 'sim', 'Informar EXTERIOR para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (52, 'infnfe_dest_enderdest_uf', 'character varying', 'Sigla da UF, informar EX para operações com o exterior do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (53, 'infnfe_dest_enderdest_cep', 'character varying', 'CEP do destinatário', 'sim', 'Informar EX para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (54, 'infnfe_dest_enderdest_cpais', 'character varying', 'Código de país do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (55, 'infnfe_dest_enderdest_xpais', 'character varying', 'Nome do país do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (56, 'infnfe_dest_enderdest_fone', 'character varying', 'Código DDD + número do telefone (v.2.0) do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (57, 'infnfe_dest_indiedest', 'character varying', 'Indicador da IE do destinatário', 'sim', '1 – Contribuinte ICMS pagamento à vista; 2 – Contribuinte isento de inscrição; 9 – Não Contribuinte', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (58, 'infnfe_dest_ie', 'character varying', 'Inscrição Estadual do destinatário', 'sim', 'Obrigatório nas operações com contribuintes do ICMS', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (59, 'infnfe_dest_isuf', 'character varying', 'Inscrição na SUFRAMA do destinatário', 'sim', 'Obrigatório nas operações com as áreas com benefícios de incentivos fiscais sob controle da SUFRAMA - PL_005d - 11/08/09 - alterado para aceitar 8 ou 9 dígitos', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (60, 'infnfe_dest_im', 'character varying', 'Inscrição Municipal do tomador do serviço', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (61, 'infnfe_dest_email', 'character varying', 'Informar o e-mail do destinatário', 'sim', 'O campo pode ser utilizado para informar o e-mailde recepção da NF-e indicada pelo destinatário', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
    (62, 'infnfe_total_icmstot_vbc', 'numeric', 'BC do ICMS total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (63, 'infnfe_total_icmstot_vicms', 'numeric', 'Valor Total do ICMS ', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (64, 'infnfe_total_icmstot_vicmsdeson', 'numeric', 'Valor Total do ICMS desonerado', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (65, 'infnfe_total_icmstot_vfcpufdest', 'numeric', 'Valor Total do ICMS relativo ao Fundo de Combate à Pobreza (FCP) para a UF de destino', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (66, 'infnfe_total_icmstot_vicmsufdest', 'numeric', 'Valor Total do ICMS de partilha para a UF do destinatário', 'não', 'Deve ser informado quando preenchido o Grupo Tributos Devolvidos na emissão de nota finNFe = 4 (devolução) nas operações com não contribuintes do IPI. Corresponde ao total da soma dos campos id: UA04.', 'Grupo W. Total da NF-e', 'fatonfe'),
    (67, 'infnfe_total_icmstot_vicmsufremet', 'numeric', 'Valor Total do ICMS de partilha para a UF do remetente', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (68, 'infnfe_total_icmstot_vfcp', 'numeric', 'Valor Total do FCP (Fundo de Combate à Pobreza)', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (69, 'infnfe_total_icmstot_vbcst', 'numeric', 'BC do ICMS total ST', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (70, 'infnfe_total_icmstot_vst', 'numeric', 'Valor Total do ICMS ST', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (71, 'infnfe_total_icmstot_vfcpst', 'numeric', 'Valor Total do FCP (Fundo de Combate à Pobreza) retido por substituição tributária', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (72, 'infnfe_total_icmstot_vfcpstret', 'numeric', 'Valor Total do FCP (Fundo de Combate à Pobreza) retido anteriormente por substituição tributária', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (73, 'infnfe_total_icmstot_vprod', 'numeric', 'Valor Total dos produtos e serviços - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (74, 'infnfe_total_icmstot_vfrete', 'numeric', 'Valor Total do Frete - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (75, 'infnfe_total_icmstot_vseg', 'numeric', 'Valor Total do Seguro - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (76, 'infnfe_total_icmstot_vdesc', 'numeric', 'Valor Total do Desconto - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (77, 'infnfe_total_icmstot_vii', 'numeric', 'Valor Total do II - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (78, 'infnfe_total_icmstot_vipi', 'numeric', 'Valor Total do IPI - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (79, 'infnfe_total_icmstot_vpis', 'numeric', 'Valor do PIS - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (80, 'infnfe_total_icmstot_vcofins', 'numeric', 'Valor do COFINS - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (81, 'infnfe_total_icmstot_voutro', 'numeric', 'Outras Despesas acessórias - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (82, 'infnfe_total_icmstot_vnf', 'numeric', 'Valor Total da NF-e - ICMS Total', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (83, 'infnfe_total_icmstot_vtottrib', 'numeric', 'Valor estimado total de impostos federais, estaduais e municipais', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
    (84, 'infnfe_cobr_fat_nfat', 'character varying', 'Número da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe'),
    (85, 'infnfe_cobr_fat_vorig', 'numeric', 'Valor original da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe'),
    (86, 'infnfe_cobr_fat_vdesc', 'numeric', 'Valor do desconto da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe'),
    (87, 'infnfe_cobr_fat_vliq', 'numeric', 'Valor líquido da fatura', 'não', NULL, 'Grupo Y. Dados da Cobrança', 'fatonfe'),
    (88, 'infnfe_pag_vtroco', 'numeric', 'Valor do Troco', 'não', NULL, 'Grupo YA. Formas de Pagamento', 'fatonfe'),
    (89, 'infnfe_infadic_infadfisco', 'character varying', 'Informações adicionais de interesse do Fisco (v2.0)', 'não', 'Observação UFPB: pega apenas 1.a ocorrencia', 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe'),
    (90, 'infnfe_infadic_infcpl', 'character varying', 'Informações complementares de interesse do Contribuinte', 'não', NULL, 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe'),
    (91, 'infnfe_infadic_obscont_xcampo', 'character varying', 'Grupo campo de uso livre do contribuinte', 'não', 'Informar o nome do campo no atributo xCampo e o conteúdo do campo no xTexto', 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe'),
    (92, 'infnfe_infadic_obscont_xtexto', 'character varying', 'Conteúdo do campo - Informações adicionais da NF-e', 'não', NULL, 'Grupo Z. Informações Adicionais da NF-e', 'fatonfe'),
    (93, 'informix_stnfeletronica', 'character', 'Situação da Nota Fiscal Eletrônica', 'não', 'A - Autorizada dentro do prazo; C - Cancelada; D - Denegada por irregularidade do Emitente; O - Autorizada fora do prazo; I - Denegada por irregularidade do Destinatário; U- Denegação por Destinatário não habilitado a operar na UF', 'Informações do Informix', 'fatonfe'),
    (94, 'informix_dhconexao', 'character varying', 'Data e hora da conexão de envio da Nota Fiscal Eletrônica', 'não', NULL, 'Informações do Informix', 'fatonfe'),
    (95, 'informix_nriptransmissor', 'character varying', 'IP da conexão de envio da Nota Fiscal Eletrônica', 'sim', NULL, 'Informações do Informix', 'fatonfe'),
    (96, 'informix_nrportacon', 'integer', 'Porta da conexão de envio da Nota Fiscal Eletrônica', 'não', NULL, 'Informações do Informix', 'fatonfe'),
    (97, 'id', 'bigint', 'Índice de fatoitemnfe', 'não', NULL, NULL, 'fatoitemnfe'),
    (98, 'infprot_chnfe', 'character varying', 'Chaves de acesso da NF-e', 'sim', 'compostas por: UF do emitente, AAMM da emissão da NFe, CNPJ do emitente, modelo, série e número da NF-e e código numérico+DV', NULL, 'fatoitemnfe'),
    (99, 'infnfe_det_nitem', 'character varying', 'Dados dos detalhes da NF-e', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (100, 'infnfe_det_prod_cprod', 'character varying', 'Código do produto ou serviço', 'não', 'Preencher com CFOP caso se trate de itens não relacionados com mercadorias/produto e que o contribuinte não possua codificação própriaFormato ”CFOP9999”', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (101, 'infnfe_det_prod_cean', 'character varying', 'GTIN (Global Trade Item Number) do produto', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (102, 'infnfe_det_prod_xprod', 'character varying', 'Descrição do produto ou serviço', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (103, 'infnfe_det_prod_ncm', 'character varying', 'Código NCM (8 posições)', 'não', 'Será permitida a informação do gênero (posição do capítulo do NCM) quando a operação não for de comércio exterior (importação/exportação) ou o produto não seja tributado pelo IPI. Em caso de item de serviço ou item que não tenham produto (Ex. transferência de crédito, crédito do ativo imobilizado, etc.), informar o código 00 (zeros) (v2.0)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (104, 'infnfe_det_prod_cfop', 'character varying', 'Cfop', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (105, 'infnfe_det_prod_ucom', 'character varying', 'Unidade comercial', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (106, 'infnfe_det_prod_qcom', 'numeric', 'Quantidade Comercial  do produto', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (107, 'infnfe_det_imposto_icms_picmsst', 'numeric', 'Alíquota do ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (108, 'infnfe_det_prod_vuncom', 'numeric', 'Valor unitário de comercialização  ', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (109, 'infnfe_det_prod_vprod', 'numeric', 'Valor bruto do produto ou serviço', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (110, 'infnfe_det_prod_ceantrib', 'character varying', 'GTIN (Global Trade Item Number) da unidade tributável', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (111, 'infnfe_det_prod_utrib', 'character varying', 'Unidade Tributável', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (112, 'infnfe_det_prod_qtrib', 'numeric', 'Quantidade Tributável ', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (113, 'infnfe_det_prod_vuntrib', 'numeric', 'Valor unitário de tributação ', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (114, 'infnfe_det_prod_vfrete', 'numeric', 'Valor Total do Frete', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (115, 'infnfe_det_prod_vseg', 'numeric', 'Valor Total do Seguro', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (116, 'infnfe_det_prod_vdesc', 'numeric', 'Valor do Desconto', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (117, 'infnfe_det_prod_voutro', 'numeric', 'Outras despesas acessórias', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (118, 'infnfe_det_prod_indtot', 'character varying', 'Indica se o valor da item (vProd) entra no valor total da NFe (vProd)', 'não', '0 – o valor do item (vProd) não compõe o valor total da NF-e (vProd), 1 – o valor do item (vProd) compõe o valor total da NF-e (vProd)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
    (119, 'infnfe_det_imposto_vtottrib', 'numeric', 'Valor estimado total de impostos federais, estaduais e municipais', 'não', NULL, 'Grupo M. Tributos incidentes no Produto ou Serviço', 'fatoitemnfe'),
    (120, 'infnfe_det_imposto_icms_orig', 'character varying', 'Origem da mercadoria - ICMS', 'não', '0 - Nacional; 1 - Estrangeira - Importação direta; 2 - Estrangeira - Adquirida no mercado interno', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (121, 'infnfe_det_imposto_icms_cst', 'character varying', 'Tributação pelo ICMS ', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (122, 'infnfe_det_imposto_icms_csosn', 'character varying', 'Código de situação da operação do simples nacional', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (123, 'infnfe_det_imposto_icms_vbcstret', 'numeric', 'Valor da BC do ICMS retido anteriormente (v2.0) ', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (124, 'infnfe_det_imposto_icms_pst', 'numeric', 'Aliquota suportada pelo consumidor final ', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (125, 'infnfe_det_imposto_icms_vicmssubstituto', 'numeric', 'Valor do ICMS próprio do substituto', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (126, 'infnfe_det_imposto_icms_vicmsstret', 'numeric', 'Valor do ICMS  retido anteriormente (v2.0)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (127, 'infnfe_det_imposto_icms_vbcfcpstret', 'numeric', 'Valor da Base de cálculo do FCP retido anteriormente', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (128, 'infnfe_det_imposto_icms_pfcpstret', 'numeric', 'Percentual de FCP retido anteriormente por substituição tributária', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (129, 'infnfe_det_imposto_icms_vfcpstret', 'numeric', 'Valor do FCP retido por substituição tributária', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (130, 'infnfe_det_imposto_icms_vbcstdest', 'numeric', 'Informar o valor da BC do ICMS da UF destino', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (131, 'infnfe_det_imposto_icms_vicmsstdest', 'numeric', 'Informar o valor da BC do ICMS da UF destino (v2.0)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (132, 'infnfe_det_imposto_icms_predbcefet', 'numeric', 'Percentual de redução da base de cálculo efetiva - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (133, 'infnfe_det_imposto_icms_vbcefet', 'numeric', 'Valor da base de cálculo efetiva - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (134, 'infnfe_det_imposto_icms_picmsefet', 'numeric', 'Alíquota do ICMS efetivo', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (135, 'infnfe_det_imposto_icms_vicmsefet', 'numeric', 'Valor do ICMS efetivo', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (136, 'infnfe_det_imposto_icms_modbc', 'character varying', 'Modalidade de determinação da BC da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (137, 'infnfe_det_imposto_icms_predbc', 'numeric', 'Percentual de redução da partilha do BC', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (138, 'infnfe_det_imposto_icms_vbc', 'numeric', 'Valor da BC da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (139, 'infnfe_det_imposto_icms_picms', 'numeric', 'Alíquota da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (140, 'infnfe_det_imposto_icms_vicmsop', 'numeric', 'Valor do ICMS da Operação', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (141, 'infnfe_det_imposto_icms_pdif', 'numeric', 'Percentual do diferemento - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (142, 'infnfe_det_imposto_icms_vicmsdif', 'numeric', 'Valor do ICMS da diferido', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (143, 'infnfe_det_imposto_icms_vicms', 'numeric', 'Valor do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (144, 'infnfe_det_imposto_icms_vbcfcp', 'numeric', 'Valor da Base de cálculo do FCP - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (145, 'infnfe_det_imposto_icms_pfcp', 'numeric', 'Percentual de ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (146, 'infnfe_det_imposto_icms_vfcp', 'numeric', 'Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (147, 'infnfe_det_imposto_icms_pfcpdif', 'numeric', 'Percentual do diferimento - ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (148, 'infnfe_det_imposto_icms_vfcpdif', 'numeric', 'Valor diferido do ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (149, 'infnfe_det_imposto_icms_vfcpefet', 'numeric', 'Valor efetivo do ICMS relativo ao Fundo de Combate à Pobreza (FCP)', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (150, 'infnfe_det_imposto_icms_modbcst', 'character varying', 'Modalidade de determinação da BC do ICMS ST', 'não', '0 – Preço tabelado ou máximo sugerido; 1 - Lista Negativa (valor), 2 - Lista Positiva (valor), 3 - Lista Neutra (valor), 4 - Margem Valor Agregado (%), 5 - Pauta (valor), 6 - Valor da Operação', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (151, 'infnfe_det_imposto_icms_pmvast', 'numeric', 'Percentual da Margem de Valor Adicionado ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (152, 'infnfe_det_imposto_icms_predbcst', 'numeric', 'Percentual de redução da BC ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (153, 'infnfe_det_imposto_icms_vbcst', 'numeric', 'Valor da BC do ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (154, 'infnfe_det_imposto_icms_vicmsst', 'numeric', 'Valor do ICMS ST', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (155, 'infnfe_det_imposto_icms_vbcfcpst', 'numeric', 'Valor da Base de cálculo do FCP retido por substituição tributária - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (156, 'infnfe_det_imposto_icms_pfcpst', 'numeric', 'Percentual de FCP retido por substituição tributária - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (157, 'infnfe_det_imposto_icms_vfcpst', 'numeric', 'Valor do FCP retido por substituição tributária - ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (158, 'infnfe_det_imposto_icms_vicmsdeson', 'numeric', 'Valor do ICMS de desoneração', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (159, 'infnfe_det_imposto_icms_motdesicms', 'character varying', 'Motivo da desoneração do ICMS', 'não', '3 - Uso na agropecuária; 9 - Outros; 12 - Fomento agropecuário', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (160, 'infnfe_det_imposto_icms_vicmsstdeson', 'numeric', 'Valor do ICMS ST de desoneração', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (161, 'infnfe_det_imposto_icms_motdesicmsst', 'character varying', 'Motivo da desoneração do ICMS ST', 'não', '3 - Uso na agropecuária; 9 - Outros; 12 - Fomento agropecuário', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (162, 'infnfe_det_imposto_icms_pbcop', 'numeric', 'Percentual para determinação do valor  da Base de Cálculo da operação própria da partilha do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (163, 'infnfe_det_imposto_icms_ufst', 'character varying', 'Sigla da UF para qual é devido a partilha do ICMS ST da operação', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
    (164, 'infnfe_det_imposto_icms_pcredsn', 'numeric', 'Alíquota aplicável de cálculo do crédito (Simples Nacional) (v2.0) ', 'não', NULL, NULL, 'fatoitemnfe'),
    (165, 'infnfe_det_imposto_ii_vbc', 'numeric', 'Base da BC do Imposto de Importação', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe'),
    (166, 'infnfe_det_imposto_ii_vdespadu', 'numeric', 'Valor das despesas aduaneiras', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe'),
    (167, 'infnfe_det_imposto_ii_vii', 'numeric', 'Valor do Imposto de Importação', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe'),
    (168, 'infnfe_det_imposto_ii_viof', 'numeric', 'Valor do Imposto sobre Operações Financeiras', 'não', NULL, 'Grupo P. Imposto de Importação', 'fatoitemnfe'),
    (169, 'infnfe_det_imposto_icmsufdest_vbcufdest', 'numeric', 'Valor da Base de Cálculo do ICMS na UF do destinatário', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (170, 'infnfe_det_imposto_icmsufdest_vbcfcpufdest', 'numeric', 'Valor da Base de Cálculo do FCP na UF do destinatário - ICMS', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (171, 'infnfe_det_imposto_icmsufdest_pfcpufdest', 'numeric', 'Percentual adicional inserido na alíquota interna da UF de destino - ICMS', 'não', 'Relativo ao Fundo de Combate à Pobreza (FCP) naquela UF', 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (172, 'infnfe_det_imposto_icmsufdest_picmsufdest', 'numeric', 'Alíquota adotada nas operações internas na UF do destinatário para o produto/mercadoria - ICMS', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (173, 'infnfe_det_imposto_icmsufdest_picmsinter', 'character varying', 'Alíquota interestadual das UF envolvidas - ICMS', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (174, 'infnfe_det_imposto_icmsufdest_picmsinterpart', 'numeric', 'Percentual de partilha para a UF do destinatário - ICMS', 'não', '- 4% alíquota interestadual para produtos importados; - 7% para os Estados de origem do Sul e Sudeste (exceto ES), destinado para os Estados do Norte e Nordeste ou ES; - 12% para os demais casos.', 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (175, 'infnfe_det_imposto_icmsufdest_vfcpufdest', 'numeric', 'Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP) da UF de destino', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (176, 'infnfe_det_imposto_icmsufdest_vicmsufdest', 'numeric', 'Valor do ICMS de partilha para a UF do destinatário', 'não', NULL, 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe'),
    (177, 'infnfe_det_imposto_icmsufdest_vicmsufremet', 'numeric', 'Valor do ICMS de partilha para a UF do remetente', 'não', 'Nota: A partir de 2019, este valor será zero.', 'Grupo NA. ICMS para a UF de destino', 'fatoitemnfe')
;


CREATE TABLE app.fatonfe(
	infProt_chNFe character varying(44) PRIMARY KEY,
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
	infNFe_emit_CNPJ character varying,
	infNFe_emit_CPF character varying,
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
	infNFe_dest_CNPJ character varying,
	infNFe_dest_CPF character varying,
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
   	infNFe_cobr_fat_nFat character varying(60),
   	infNFe_cobr_fat_vOrig numeric(16,2),
   	infNFe_cobr_fat_vDesc numeric(16,2),
   	infNFe_cobr_fat_vLiq numeric(16,2),
    infNFe_pag_vTroco numeric(16,2),
    infNFe_infAdic_infAdFisco character varying,
    infNFe_infAdic_infCpl character varying,
    infNFe_infAdic_obsCont_xCampo character varying,
    infNFe_infAdic_obsCont_xTexto character varying,
	informix_stnfeletronica char(1) NOT NULL DEFAULT 'A',
	informix_dhconexao varchar NULL,
	informix_nriptransmissor varchar NULL,
	informix_nrportacon int4 NULL
);

CREATE INDEX fatonfe_infprot_chnfe_idx ON app.fatonfe USING btree (infprot_chnfe);
CREATE INDEX idx_infnfe_ide_dhemi ON app.fatonfe USING btree (infnfe_ide_dhemi);
CREATE INDEX fatonfe_infnfe_ide_mod_idx ON app.fatonfe USING btree (infnfe_ide_mod);
CREATE INDEX fatonfe_infnfe_emit_cnpj_idx ON app.fatonfe USING btree (infnfe_emit_cnpj);
CREATE INDEX fatonfe_infnfe_emit_ie_idx ON app.fatonfe USING btree (infnfe_emit_ie);
CREATE INDEX idx_infnfe_dest_cnpj ON app.fatonfe USING btree (infnfe_dest_cnpj);

CREATE TABLE app.fatoitemnfe(
	id BIGSERIAL NOT NULL,
	infProt_chNFe character varying(44) NOT NULL,
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
CREATE INDEX fatoitemnfe_infprot_chnfe_idx ON app.fatoitemnfe USING btree (infprot_chnfe);



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

    infProt_chNFe character varying(44),
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
	infcte_versao character varying(4),
	infcte_id character varying(47),
	infcte_infctenorm_infcarga_vcarga numeric(13,2),
	infcte_infctenorm_infcarga_propred character varying(60),
	infcte_infctenorm_infcarga_xoutcat character varying(30),
	infcte_infctenorm_infcarga_vcargaaverb numeric(13,2),
	infcte_infctenorm_cobr_fat_nfat character varying(60),
	infcte_infctenorm_cobr_fat_vorig numeric(13,2),
	infcte_infctenorm_cobr_fat_vdesc numeric(13,2),
	infcte_infctenorm_cobr_fat_vliq numeric(13,2),
	infcte_infctenorm_infctesub_chcte character varying(44),
	infcte_infctenorm_infctesub_refcteanu character varying(44),
	infcte_infctenorm_infctesub_tomaicms_refnfe character varying(44),
	infcte_infctenorm_infctesub_tomaicms_refnf_cnpj character varying(14),
	infcte_infctenorm_infctesub_tomaicms_refnf_cpf character varying(11),
	infcte_infctenorm_infctesub_tomaicms_refnf_mod character varying(2),
	infcte_infctenorm_infctesub_tomaicms_refnf_serie character varying(3),
	infcte_infctenorm_infctesub_tomaicms_refnf_subserie character varying(3),
	infcte_infctenorm_infctesub_tomaicms_refnf_nro character varying(6),
	infcte_infctenorm_infctesub_tomaicms_refnf_valor numeric(13,2),
	infcte_infctenorm_infctesub_tomaicms_refnf_demi date,
	infcte_infctenorm_infctesub_tomaicms_refcte character varying(44),
	infcte_infctenorm_infctesub_indalteratoma char(1),
	infcte_infctenorm_infglobalizado_xobs character varying(256),
	infcte_infctecomp_chcte character varying(44),
	infcte_infcteanu_chcte character varying(44),
	infcte_infcteanu_demi date,
	infcte_autxml_cnpj character varying(14),
	infcte_autxml_cpf character varying(11),
	infcte_infresptec_cnpj character varying(14),
	infcte_infresptec_xcontato character varying(60),
	infcte_infresptec_email character varying(60),
	infcte_infresptec_fone character varying(12),
	infcte_infresptec_idcsrt character varying(3),
	infcte_infresptec_hashcsrt character varying(28),
	infctesupl_qrcodcte character varying(1000),
	infcte_infctenorm_infModal_versaomodal character varying,
	infcte_infctenorm_infModal_rodo_rntrc character varying(8),
	infcte_infctenorm_infModal_rodo_occ_serie character varying(3),
	infcte_infctenorm_infModal_rodo_occ_nocc character varying(6),
	infcte_infctenorm_infModal_rodo_occ_dhemi date,
	infcte_infctenorm_infModal_rodo_occ_emiocc_cnpj character varying(14),
	infcte_infctenorm_infModal_rodo_occ_emiocc_cint character varying(10),
	infcte_infctenorm_infModal_rodo_occ_emiocc_ie character varying(14),
	infcte_infctenorm_infModal_rodo_occ_emiocc_uf character varying(2),
	infcte_infctenorm_infModal_rodo_occ_emiocc_fone character varying(14),
	infcte_infctenorm_infModal_aereo_nminu character varying(9),
	infcte_infctenorm_infModal_aereo_noca character varying(11),
	infcte_infctenorm_infModal_aereo_dprevaereo date,
	infcte_infctenorm_infModal_aereo_natcarga_xdime character varying(14),
	infcte_infctenorm_infModal_aereo_natcarga_clnfmanu character varying(2),
	infcte_infctenorm_infModal_aereo_tarifa_cl char(1),
	infcte_infctenorm_infModal_aereo_tarifa_ctar character varying(4),
	infcte_infctenorm_infModal_aereo_tarifa_vtar numeric(13,2),
	infcte_infctenorm_infModal_aereo_peri_nonu character varying(4),
	infcte_infctenorm_infModal_aereo_peri_qtotemb character varying(20),
	infcte_infctenorm_infModal_aereo_peri_inftotap_qtotprod numeric(11,4),
	infcte_infctenorm_infModal_aereo_peri_inftotap_uniap char(1),
	infcte_infctenorm_infModal_ferrov_tptraf char(1),
	infcte_infctenorm_infModal_ferrov_fluxo character varying(10),
	infcte_infctenorm_infModal_ferrov_trafmut_respfat char(1),
	infcte_infctenorm_infModal_ferrov_trafmut_ferremi char(1),
	infcte_infctenorm_infModal_ferrov_trafmut_vfrete numeric(13,2),
	infcte_infctenorm_infModal_ferrov_trafmut_chcteferroorigem character varying(44),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_cnpj character varying(14),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_cint character varying(10),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_ie character varying(14),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_xnome character varying(60),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_xlgr character varying(255),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_nro character varying(60),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_xcpl character varying(60),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_xbairro character varying(60),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_cmun character varying(7),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_xmun character varying(60),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_cep character varying(8),
	infcte_infctenorm_infModal_ferrov_trafmut_ferroenv_enderferro_uf character varying(2),
	infcte_infctenorm_infModal_aquav_vprest numeric(13,2),
	infcte_infctenorm_infModal_aquav_vafrmm numeric(13,2),
	infcte_infctenorm_infModal_aquav_xnavio character varying(60),
	infcte_infctenorm_infModal_aquav_tpnav char(1),
	infcte_infctenorm_infModal_aquav_balsa_xbalsa character varying(60),
	infcte_infctenorm_infModal_aquav_balsa_nviag character varying(10),
	infcte_infctenorm_infModal_aquav_balsa_direc char(1),
	infcte_infctenorm_infModal_aquav_balsa_irin character varying(10),
	infcte_infctenorm_infModal_aquav_detcont_ncont character varying(20),
	infcte_infctenorm_infModal_aquav_detcont_lacre_nlacre character varying(20),
	infcte_infctenorm_infModal_aquav_detcont_infdoc_infnf_serie character varying(3),
	infcte_infctenorm_infModal_aquav_detcont_infdoc_infnf_ndoc character varying(20),
	infcte_infctenorm_infModal_aquav_detcont_infdoc_infnf_unidrat numeric(3,2),
	infcte_infctenorm_infModal_duto_vtar numeric(9,6),
	infcte_infctenorm_infModal_duto_dini date,
	infcte_infctenorm_infModal_duto_fim date,
	infcte_infctenorm_infModal_multimodal_cotm character varying(20),
	infcte_infctenorm_infModal_multimodal_indnegociavel char(1),
	infcte_infctenorm_infModal_multimodal_seg_infseg_xseg character varying(30),
	infcte_infctenorm_infModal_multimodal_seg_infseg_cnpj character varying(14),
	infcte_infctenorm_infModal_multimodal_seg_infseg_napol character varying(20),
	infcte_infctenorm_infModal_multimodal_seg_infseg_naver character varying(20),
	infcte_ide_cuf character varying(2),
	infcte_ide_cct character varying(8),
	infcte_ide_cfop character varying(4),
	infcte_ide_natop character varying(60),
	infcte_ide_mod character varying(2),
	infcte_ide_serie character varying(3),
	infcte_ide_nct character varying(9),
	infcte_ide_dhemi timestamp with time zone,
	infcte_ide_tpimp char(1),
	infcte_ide_tpemis char(1),
	infcte_ide_tpemis char(1),
	infcte_ide_tpemis char(1),
	infcte_ide_tpcte char(1),
	infcte_ide_procemi char(1),
	infcte_ide_verproc character varying(20),
	infcte_ide_indglobalizado char(1),
	infcte_ide_cmunenv character varying(7),
	infcte_ide_xmunenv  character varying(60),
	infcte_ide_ufenv character varying(2),
	infcte_ide_modal character varying(2),
	infcte_ide_tpserv char(1),
	infcte_ide_cmunini character varying(7),
	infcte_ide_xmunini  character varying(60),
	infcte_ide_ufini character varying(2),
	infcte_ide_cmunfim character varying(7),
	infcte_ide_xmunfim character varying(60),
	infcte_ide_uffim character varying(2),
	infcte_ide_retira char(1),
	infcte_ide_xdetretira character varying(160),
	infcte_ide_indietoma char(1),
	infcte_ide_toma3_toma char(1),
	infcte_ide_toma4_toma char(1),
	infcte_ide_toma4_cnpj character varying(14),
	infcte_ide_toma4_cpf character varying(11),
	infcte_ide_toma4_ie char(14),
	infcte_ide_toma4_xnome character varying(60),
	infcte_ide_toma4_xfant character varying(60),
	infcte_ide_toma4_fone character varying(14),
	infcte_ide_enderToma_xlgr character varying(255),
	infcte_ide_enderToma_nro character varying(60),
	infcte_ide_enderToma_cplr character varying(60),
	infcte_ide_enderToma_xbairro character varying(60),
	infcte_ide_enderToma_cmun character varying(7),
	infcte_ide_enderToma_xmun character varying(60),
	infcte_ide_enderToma_cep character varying(8),
	infcte_ide_enderToma_uf character varying(2),
	infcte_ide_enderToma_cpais character varying(4),
	infcte_ide_enderToma_xpais character varying(60),
	infcte_ide_enderToma_email character varying(60),
	infcte_ide_enderToma_dhcont character varying(21),
	infcte_ide_enderToma_xjust character varying(256),
	infcte_compl_xcaracad character varying(15),
	infcte_compl_xcaracser character varying(30),
	infcte_compl_xemi character varying(20),
	infcte_compl_fluxo_xorig character varying(60),
	infcte_compl_fluxo_xdest character varying(60),
	infcte_compl_fluxo_xrota character varying(10),
	infcte_compl_entrega_semdata_tpper char(1),
	infcte_compl_entrega_comdata_tpper char(1),
	infcte_compl_entrega_comdata_dprog date,
	infcte_compl_entrega_noperiodo_tpper char(1),
	infcte_compl_entrega_noperiodo_dini date,
	infcte_compl_entrega_noperiodo_dfim date,
	infcte_compl_entrega_semhora_tphor char(1),
	infcte_compl_entrega_comhora_tphor char(1),
	infcte_compl_entrega_comhora_hprog time without timezone,
	infcte_compl_entrega_nointer_tphor char(1),
	infcte_compl_entrega_nointer_hini time without timezone,
	infcte_compl_entrega_nointer_hfim time without timezone,
	infcte_compl_entrega_nointer_origcalc character varying(40),
	infcte_compl_entrega_nointer_destcalc character varying(40),
	infcte_compl_entrega_nointer_xobs character varying(2000),
	infcte_compl_obscont_xcampo character varying(20),
	infcte_compl_obscont_xtexto char(160),
	infcte_compl_obsfisco_xcampo character varying(20),
	infcte_compl_obsfisco_xtexto char(60),
	infcte_emit_cnpj character varying(14),
	infcte_emit_ie character varying(14),
	infcte_emit_iest character varying(14),
	infcte_emit_xnome character varying(60),
	infcte_emit_xfant character varying(60),
	infcte_emit_enderemit_xlgr character varying(60),
	infcte_emit_enderemit_nro character varying(60),
	infcte_emit_enderemit_xcpl character varying(60),
	infcte_emit_enderemit_xbairro character varying(60),
	infcte_emit_enderemit_cmun character varying(7),
	infcte_emit_enderemit_xmun character varying(60),
	infcte_emit_enderemit_cep character varying(8),
	infcte_emit_enderemit_uf character varying(2),
	infcte_emit_enderemit_fone character varying(14),
	infcte_rem_cnpj character varying(14),
	infcte_rem_cpf character varying(11),
	infcte_rem_ie character varying(14),
	infcte_rem_xnome character varying(60),
	infcte_rem_xfant character varying(60),
	infcte_rem_fone character varying(14),
	infcte_rem_enderreme_xlgr character varying(255),
	infcte_rem_enderreme_nro character varying(60),
	infcte_rem_enderreme_xcpl character varying(60),
	infcte_rem_enderreme_xbairro character varying(60),
	infcte_rem_enderreme_cmun character varying(7),
	infcte_rem_enderreme_xmun character varying(60),
	infcte_rem_enderreme_cep character varying(8),
	infcte_rem_enderreme_uf character varying(2),
	infcte_rem_enderreme_cpais character varying(4),
	infcte_rem_enderreme_xpais character varying(60),
	infcte_rem_enderreme_email character varying(60),
	infcte_exped_cnpj character varying(14),
	infcte_exped_cpf character varying(11),
	infcte_exped_ie character varying(14),
	infcte_exped_xnome character varying(60),
	infcte_exped_fone character varying(14),
	infcte_exped_enderexped_xlgr character varying(255),
	infcte_exped_enderexped_nro character varying(60),
	infcte_exped_enderexped_cplr character varying(60),
	infcte_exped_enderexped_xbairro character varying(60),
	infcte_exped_enderexped_cmun character varying(7),
	infcte_exped_enderexped_xmun character varying(60),
	infcte_exped_enderexped_cep character varying(8),
	infcte_exped_enderexped_uf character varying(2),
	infcte_exped_enderexped_cpais character varying(4),
	infcte_exped_enderexped_xpais character varying(60),
	infcte_exped_enderexped_email character varying(60),
	infcte_receb_cnpj character varying(14),
	infcte_receb_cpf character varying(11),
	infcte_receb_ie char(14),
	infcte_receb_xnome character varying(60),
	infcte_receb_fone character varying(14),
	infcte_receb_enderreceb_xlgr character varying(255),
	infcte_receb_enderreceb_nro character varying(60),
	infcte_receb_enderreceb_xcpl character varying(60),
	infcte_receb_enderreceb_xbairro character varying(60),
	infcte_receb_enderreceb_cmun character varying(7),
	infcte_receb_enderreceb_xmun character varying(60),
	infcte_receb_enderreceb_cep character varying(8),
	infcte_receb_enderreceb_uf character varying(2),
	infcte_receb_enderreceb_cpais character varying(4),
	infcte_receb_enderreceb_xpais character varying(60),
	infcte_receb_enderreceb_email character varying(60),
	infcte_dest_cnpj character varying(14),
	infcte_dest_cpf character varying(11),
	infcte_dest_ie char(14),
	infcte_dest_xnome character varying(60),
	infcte_dest_fone character varying(14),
	infcte_dest_isuf character varying(9),
	infcte_dest_enderdest_xlgr character varying(255),
	infcte_dest_enderdest_nro character varying(60),
	infcte_dest_enderdest_xcpl character varying(60),
	infcte_dest_enderdest_xbairro character varying(60),
	infcte_dest_enderdest_cmun character varying(7),
	infcte_dest_enderdest_xmun character varying(60),
	infcte_dest_enderdest_cep character varying(8),
	infcte_dest_enderdest_uf character varying(2),
	infcte_dest_enderdest_cpais character varying(4),
	infcte_dest_enderdest_xpais character varying(60),
	infcte_dest_enderdest_email character varying(60),
	infcte_vprest_vtprest numeric(13,2),
	infcte_vprest_vrec numeric(13,2),
	infcte_imp_vtottrib numeric(13,2),
	infcte_imp_infadfisco character varying(2000),
	infcte_imp_icms_icms00_cst character varying(2),
	infcte_imp_icms_icms00_vbc numeric(13,2),
	infcte_imp_icms_icms00_picms numeric(3,2),
	infcte_imp_icms_icms00_vicms numeric(13,2),
	infcte_imp_icms_icms20_cst character varying(2),
	infcte_imp_icms_icms20_predbc numeric(3,2),
	infcte_imp_icms_icms20_vbc numeric(13,2),
	infcte_imp_icms_icms20_picms numeric(3,2),
	infcte_imp_icms_icms20_vicms numeric(13,2),
	infcte_imp_icms_icms45_cst character varying(2),
	infcte_imp_icms_icms60_cst character varying(2),
	infcte_imp_icms_icms60_vbcstret numeric(13,2),
	infcte_imp_icms_icms60_vicmsstret numeric(13,2),
	infcte_imp_icms_icms60_picmsstret numeric(3,2),
	infcte_imp_icms_icms60_vcred numeric(13,2),
	infcte_imp_icms_icms90_cst character varying(2),
	infcte_imp_icms_icms90_predbc numeric(3,2),
	infcte_imp_icms_icms90_vbc numeric(13,2),
	infcte_imp_icms_icms90_picms numeric(3,2),
	infcte_imp_icms_icms90_vicms numeric(13,2),
	infcte_imp_icms_icms90_vcred numeric(13,2),
	infcte_imp_icms_icmsoutrauf_cst character varying(2),
	infcte_imp_icms_icmsoutrauf_predbcoutrauf numeric(3,2),
	infcte_imp_icms_icmsoutrauf_vbcoutrauf numeric(13,2),
	infcte_imp_icms_icmsoutrauf_picmsoutrauf numeric(3,2),
	infcte_imp_icms_icmsoutrauf_vicmsoutrauf numeric(13,2),
	infcte_imp_icms_icmssn_cst character varying(2),
	infcte_imp_icms_icmssn_indsn char(1),
	infcte_imp_imcsuffim_vbcuffim numeric(13,2),
	infcte_imp_imcsuffim_pfcpuffim numeric(3,2),
	infcte_imp_imcsuffim_pICMSUFFim numeric(3,2),
	infcte_imp_imcsuffim_picmsinter numeric(3,2),
	infcte_imp_imcsuffim_vfcpuffim numeric(13,2),
	infcte_imp_imcsuffim_vicmsuffim numeric(13,2),
	infcte_imp_imcsuffim_vicmsufini numeric(13,2),
	protcte_infprot_chcte character varying(44) PRIMARY KEY
);


---- Tabela FatoMDFe

CREATE TABLE app.fatomdfe(
	infmdfe_versao character varying,
	infmdfe_id character varying(48),
	infmdfe_ide_cuf character varying(2),
	infmdfe_ide_tpamb char(1),
	infmdfe_ide_tpemit char(1),
	infmdfe_ide_tptransp char(1),
	infmdfe_ide_mod character varying(2),
	infmdfe_ide_serie character varying(3),
	infmdfe_ide_nmdf character varying(9),
	infmdfe_ide_cmdf character varying(8),
	infmdfe_ide_cdv char(1),
	infmdfe_ide_modal char(1),
	infmdfe_ide_dhemi timestamp with time zone,
	infmdfe_ide_tpemis char(1),
	infmdfe_ide_procemi char(1),
	infmdfe_ide_verproc character varying(20),
	infmdfe_ide_ufini character varying(2),
	infmdfe_ide_uffim character varying(2),
	infmdfe_ide_infmuncarrega_cmuncarrega character varying(7),
	infmdfe_ide_infmuncarrega_xmuncarrega character varying(60),
	infmdfe_ide_infpercurso_ufper character varying(2),
	infmdfe_ide_dhiniviagem timestamp with time zone,
	infmdfe_ide_indcanalverde char(1),
	infmdfe_ide_indcarregaposterior char(1),
	infmdfe_emit_cnpj character varying(14),
	infmdfe_emit_cpf character varying(11),
	infmdfe_emit_ie character varying(14),
	infmdfe_emit_xnome character varying(60),
	infmdfe_emit_xfant character varying(60),
	infmdfe_emit_enderemit_xlgr character varying(60),
	infmdfe_emit_enderemit_nro character varying(60),
	infmdfe_emit_enderemit_xcpl character varying(60),
	infmdfe_emit_enderemit_xbairro character varying(60),
	infmdfe_emit_enderemit_cmun character varying(7),
	infmdfe_emit_enderemit_xmun character varying(60),
	infmdfe_emit_enderemit_cep character varying(8),
	infmdfe_emit_enderemit_uf character varying(2),
	infmdfe_emit_enderemit_fone character varying(12),
	infmdfe_emit_enderemit_email character varying(60),
	infmdfe_infmodal_versaomodal character varying(4),
	infmdfe_infmodal_infantt_rntrc character varying(8),
	infmdfe_infmodal_veictracao_cint character varying(10),
	infmdfe_infmodal_veictracao_placa character varying(7),
	infmdfe_infmodal_veictracao_renavam character varying(11),
	infmdfe_infmodal_veictracao_tara character varying(6),
	infmdfe_infmodal_veictracao_capkg character varying(6),
	infmdfe_infmodal_veictracao_capm3 character varying(3),
	infmdfe_infmodal_veictracao_prop_cpf character varying(11),
	infmdfe_infmodal_veictracao_prop_cnpj character varying(14),
	infmdfe_infmodal_veictracao_prop_rntrc character varying(8),
	infmdfe_infmodal_veictracao_prop_xnome character varying(60),
	infmdfe_infmodal_veictracao_prop_ie character varying(14),
	infmdfe_infmodal_veictracao_prop_uf character varying(2),
	infmdfe_infmodal_veictracao_prop_tpprop char(1),
	infmdfe_infmodal_veictracao_condutor_xnome character varying(60),
	infmdfe_infmodal_veictracao_condutor_cpf character varying(11),
	infmdfe_infmodal_veictracao_tprod char(2),
	infmdfe_infmodal_veictracao_tpcar char(2),
	infmdfe_infmodal_veictracao_uf char(2),
	infmdfe_infmodal_veicreboque_cint character varying(10),
	infmdfe_infmodal_veicreboque_placa character varying(4),
	infmdfe_infmodal_veicreboque_renavam character varying(11),
	infmdfe_infmodal_veicreboque_tara character varying(6),
	infmdfe_infmodal_veicreboque_capkg character varying(6),
	infmdfe_infmodal_veicreboque_capm3 character varying(3),
	infmdfe_infmodal_veicreboque_prop_cpf character varying(11),
	infmdfe_infmodal_veicreboque_prop_cnpj character varying(14),
	infmdfe_infmodal_veicreboque_prop_rntrc character varying(8),
	infmdfe_infmodal_veicreboque_prop_xnome character varying(60),
	infmdfe_infmodal_veicreboque_prop_ie character varying(14),
	infmdfe_infmodal_veicreboque_prop_uf char(2),
	infmdfe_infmodal_veicreboque_prop_tpprop char(1),
	infmdfe_infmodal_veicreboque_tpcar char(2),
	infmdfe_infmodal_veicreboque_uf char(2),
	infmdfe_infmodal_veicreboque_codAgPorto character varying(16),
	infmdfe_infmodal_aereo_nac character varying(4),
	infmdfe_infmodal_aereo_matr character varying(6),
	infmdfe_infmodal_aereo_nvoo character varying(9),
	infmdfe_infmodal_aereo_caeremb character varying(4),
	infmdfe_infmodal_aereo_caerdes character varying(4),
	infmdfe_infmodal_aereo_dvoo date,
	infmdfe_infmodal_ferrov_trem_xpref character varying(10),
	infmdfe_infmodal_ferrov_trem_dhtrem timestamp without time zone,
	infmdfe_infmodal_ferrov_trem_xori character varying(3),
	infmdfe_infmodal_ferrov_trem_xdest character varying(3),
	infmdfe_infmodal_ferrov_trem_qvag character varying(3),
	infmdfe_infmodal_aquav_irin character varying(10),
	infmdfe_infmodal_aquav_tpemb char(2),
	infmdfe_infmodal_aquav_cembar character varying(10),
	infmdfe_infmodal_aquav_xembar character varying(60),
	infmdfe_infmodal_aquav_nviag character varying(10),
	infmdfe_infmodal_aquav_cprtemb character varying(5),
	infmdfe_infmodal_aquav_cprtdest character varying(5),
	infmdfe_infmodal_aquav_prttrans character varying(60),
	infmdfe_infmodal_aquav_tpnav char(1),
	infmdfe_infmodal_aquav_inftermcarreg_ctermcarreg character varying(8),
	infmdfe_infmodal_aquav_inftermcarreg_xtermcarreg character varying(60),
	infmdfe_infmodal_aquav_inftermdescarreg_ctermcarreg character varying(8),
	infmdfe_infmodal_aquav_inftermdescarreg_xtermcarreg character varying(60),
	infmdfe_infmodal_aquav_infembcomb_cembcomb character varying(10),
	infmdfe_infmodal_aquav_infembcomb_xbalsa character varying(60),
	infmdfe_infdoc_infmundescarga_cmundescarga character varying(7),
	infmdfe_infdoc_infmundescarga_xmundescarga character varying(60),
	infmdfe_infdoc_infmundescarga_infcte_chcte character varying(44),
	infmdfe_infdoc_infmundescarga_infcte_segcodbarra character varying(36),
	infmdfe_infdoc_infmundescarga_infcte_indreentrega char(1),
	infmdfe_infdoc_infmundescarga_infcte_infentregaparcial_qtdtotal numeric(11,4),
	infmdfe_infdoc_infmundescarga_infcte_infentregaparcial_qtdparcial numeric(11,4),
	infmdfe_infdoc_infmundescarga_infnfe_chnfe character varying(44),
	infmdfe_infdoc_infmundescarga_infnfe_segcodbarra character varying(36),
	infmdfe_infdoc_infmundescarga_infnfe_indreentrega char(1),
	infmdfe_infdoc_infmundescarga_infmdfetransp_chmdfe character varying(44),
	infmdfe_infdoc_infmundescarga_infmdfetransp_indreentrega char(1),
	infmdfe_tot_qcte character varying(6),
	infmdfe_tot_qnfe character varying(6),
	infmdfe_tot_qmdfe character varying(6),
	infmdfe_tot_vcarga numeric(13,2),
	infmdfe_tot_cunid character varying(2),
	infmdfe_tot_qcarga numeric(11,4),
	infmdfe_autxml_cnpj character varying(14),
	infmdfe_autxml_cpf character varying(11),
	infmdfe_infadic_infadfisco character varying(2000),
	infmdfe_infadic_infcpl character varying(5000),
	infmdfe_infresptec_cnpj character varying(14),
	infmdfe_infresptec_xcontato character varying(60),
	infmdfe_infresptec_email character varying(60),
	infmdfe_infresptec_fone character varying(12),
	infmdfe_infresptec_idcsrt character varying(3),
	infmdfe_infresptec_hashcsrt character varying(28),
	protmdfe_infprot_chmdfe character varying(44) PRIMARY KEY
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
    id,
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
ALTER ROLE hasurauser SET search_path TO public,app,appmask,cicc;

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

-- cicc
GRANT USAGE ON SCHEMA cicc TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA cicc TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA cicc TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA cicc TO hasurauser;


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
                'exp', round(extract(epoch from now() + interval '24 hour')),
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
