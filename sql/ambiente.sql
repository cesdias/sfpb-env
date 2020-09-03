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

-- schemas
CREATE SCHEMA app;
CREATE SCHEMA appmask;

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
  (0, 'infNFe_ide_cUF', 'integer', 'Código da UF do emitente do Documento Fiscal', 'não', 'Utilizar a Tabela do IBGE', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (1, 'infNFe_ide_cNF', 'character varying', 'Código numérico que compõe a Chave de Acesso', 'sim', 'Número aleatório gerado pelo emitente para cada NF-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (2, 'infNFe_ide_natOp', 'character varying', 'Descrição da Natureza da Operação', 'não', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (3, 'infNFe_ide_mod', 'integer', 'Código do modelo do Documento Fiscal', 'não', '55 - NF-e, 65 - NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (4, 'infNFe_ide_serie', 'character varying', 'Série do Documento Fiscal', 'sim', 'Série normal - 0-889, Avulsa Fisco - 890-899, SCAN - 900-999', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (5, 'infNFe_ide_nNF', 'character varying', 'Número do Documento Fiscal', 'sim', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (6, 'infNFe_ide_dhEmi', 'timestamp wit time zone', 'Data e Hora de emissão do Documento Fiscal (AAAA-MM-DDThh:mm:ss TZD)', 'não', 'Ex.: 2012-09-01T13:00:00-03:00', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (7, 'infNFe_ide_dhSaiEnt', 'timestamp with time zone', 'Data e Hora da saída ou de entrada da mercadoria / produto (AAAA-MM-DDTHH:mm:ssTZD)', 'não', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (8, 'infNFe_ide_tpNF', 'integer', 'Tipo do Documento Fiscal', 'não', '0 - Entrada, 1 - Saída', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (9, 'infNFe_ide_idDest', 'integer', 'Identificador de Local de destino da operação', 'não', '1 - Interna, 2 -Interestadual, 3 - Exterior', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (10, 'infNFe_ide_cMunFG', 'character varying', 'Código do Município de Ocorrência do Fato Gerador', 'sim', 'Utilizar a Tabela do IBGE.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (11, 'infNFe_ide_tpImp', 'integer', 'Formato de impressão do DANFE', 'não', '0 - sem DANFE,  1 - DANFe Retrato, 2 - DANFe Paisagem, 3 - DANFe Simplificado, 4 - DANFe NFC-e, 5 - DANFe NFC-e em mensagem eletrônica', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (12, 'infNFe_ide_tpEmis', 'integer', 'Forma de emissão da NF-e', 'não', '1 - Normal 2 - Contingência FS 3 - Contingência SCAN 4 - Contingência DPEC 5 - Contingência FSDA 6 - Contingência SVC - AN 7 - Contingência SVC - RS 9 - Contingência off-line NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (13, 'infNFe_ide_cDV', 'integer', 'Dígito Verificador da Chave de Acesso da NF-e', 'sim', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (14, 'infNFe_ide_tpAmb', 'integer', 'Identificação do Ambiente', 'não', '1 - Produção 2 - Homologação', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (15, 'infNFe_ide_finNFe', 'integer', 'Finalidade da emissão da NF-e', 'não', '1 - NFe normal 2 - NFe complementar 3 - NFe de ajuste 4 - Devolução/Retorno', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (16, 'infNFe_ide_indFinal', 'integer', 'Indica operação com consumidor final', 'não', '0 - Não, 1 - Consumidor Final', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (17, 'infNFe_ide_indPres', 'integer', 'Indicador de presença do comprador no estabelecimento comercial no momento da operação', 'não', '0 - Não se aplica (ex.: Nota Fiscal complementar ou de ajuste), 1 - Operação presencial, 2 - Não presencial, internet, 3 - Não presencial, teleatendimento, 4 - NFC-e entrega em domicílio, 5 - Operação presencial, fora do estabelecimento, 9 - Não presencial, outros', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (18, 'infNFe_ide_procEmi', 'integer', 'Processo de emissão utilizado com a seguinte codificação', 'não', '0 - Emissão de NF-e com aplicativo do contribuinte, 1 - Emissão de NF-e avulsa pelo Fisco, 2 - Emissão de NF-e avulsa, pelo contribuinte com seu certificado digital, através do sitedo Fisco, 3 - Emissão de NF-e pelo contribuinte com aplicativo fornecido pelo Fisco.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (19, 'infNFe_ide_verProc', 'character varying', 'Versão do aplicativo utilizado no processo de emissão', 'não', NULL, 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (20, 'infNFe_emit_CNPJ', 'character varying', 'Número do CNPJ do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (21, 'infNFe_emit_CPF', 'character varying', 'Número do CPF do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (22, 'infNFe_emit_xNome', 'character varying', 'Razão Social ou Nome do emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (23, 'infNFe_emit_xFant', 'character varying', 'Nome fantasia', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (24, 'infNFe_emit_enderEmit_xLgr', 'character varying', 'Logradouro', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (25, 'infNFe_emit_enderEmit_nro', 'character varying', 'Número', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (26, 'infNFe_emit_enderEmit_xCpl', 'character varying', 'Complemento', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (27, 'infNFe_emit_enderEmit_xBairro', 'character varying', 'Bairro', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (28, 'infNFe_emit_enderEmit_cMun', 'character varying', 'Código do município', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (29, 'infNFe_emit_enderEmit_xMun', 'character varying', 'Nome do município', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (30, 'infNFe_emit_enderEmit_UF', 'character varying', 'Sigla da UF', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (31, 'infNFe_emit_enderEmit_CEP', 'character varying', 'CEP - NT 2011/004', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (32, 'infNFe_emit_enderEmit_cPais', 'character varying', 'Código do país', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (33, 'infNFe_emit_enderEmit_xPais', 'character varying', 'Nome do país', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (34, 'infNFe_emit_enderEmit_fone', 'character varying', 'Preencher com Código DDD + número do telefone (v.2.0)', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (35, 'infNFe_emit_IE', 'character varying', 'Inscrição Estadual do Emitente', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (36, 'infNFe_emit_IEST', 'character varying', 'Inscricao Estadual do Substituto Tributário', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (37, 'infNFe_emit_IM', 'character varying', 'Inscrição Municipal', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (38, 'infNFe_emit_CNAE', 'character varying', 'CNAE Fiscal', 'sim', NULL, 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (39, 'infNFe_emit_CRT', 'character varying', 'Código de Regime Tributário', 'não', 'Este campo será obrigatoriamente preenchido com: 1 – Simples Nacional, 2 – Simples Nacional – excesso de sublimite de receita bruta, 3 – Regime Normal.', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (40, 'infNFe_dest_CNPJ', 'character varying', 'Número do CNPJ', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (41, 'infNFe_dest_CPF', 'character varying', 'Número do CPF', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (42, 'infNFe_dest_idEstrangeiro', 'character varying', 'Identificador do destinatário, em caso de comprador estrangeiro', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (43, 'infNFe_dest_xNome', 'character varying', 'Razão Social ou nome do destinatário', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (44, 'infNFe_dest_enderDest_xLgr', 'character varying', 'Logradouro', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (45, 'infNFe_dest_enderDest_nro', 'character varying', 'Número', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (46, 'infNFe_dest_enderDest_xCpl', 'character varying', 'Complemento', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (47, 'infNFe_dest_enderDest_xBairro', 'character varying', 'Bairro', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (48, 'infNFe_dest_enderDest_cMun', 'character varying', 'Código do município, informar 9999999 para operações com o exterior', 'sim', 'Utilizar a tabela do IBGE', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (49, 'infNFe_dest_enderDest_xMun', 'character varying', 'Nome do município, informar EXTERIOR para operações com o exterior', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (50, 'infNFe_dest_enderDest_UF', 'character varying', 'Sigla da UF, informar EX para operações com o exterior', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (51, 'infNFe_dest_enderDest_CEP', 'character varying', 'CEP', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (52, 'infNFe_dest_enderDest_cPais', 'character varying', 'Código de país', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (53, 'infNFe_dest_enderDest_xPais', 'character varying', 'Nome do país', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (54, 'infNFe_dest_enderDest_fone', 'character varying', 'Preencher com Código DDD + número do telefone (v.2.0)', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (55, 'infNFe_dest_indIEDest', 'character varying', 'Indicador da IE do destinatário', 'sim', '1 – Contribuinte ICMS pagamento à vista, 2 – Contribuinte isento de inscrição, 9 – Não Contribuinte', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (56, 'infNFe_dest_IE', 'character varying', 'Inscrição Estadual (obrigatório nas operações com contribuintes do ICMS)', 'sim', 'Obrigatório nas operações com contribuintes do ICMS', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (57, 'infNFe_dest_ISUF', 'character varying', 'Inscrição na SUFRAMA', 'sim', 'Obrigatório nas operações com as áreas com benefícios de incentivos fiscais sob controle da SUFRAMA - PL_005d - 11/08/09 - alterado para aceitar 8 ou 9 dígitos', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (58, 'infNFe_dest_IM', 'character varying', 'Inscrição Municipal do tomador do serviço', 'sim', NULL, 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (59, 'infNFe_dest_email', 'character varying', 'Informar o e-mail do destinatário', 'sim', 'O campo pode ser utilizado para informar o e-mailde recepção da NF-e indicada pelo destinatário', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (60, 'infNFe_det_nItem', 'character varying', 'Dados dos detalhes da NF-e', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (61, 'infNFe_det_prod_cProd', 'character varying', 'Código do produto ou serviço', 'não', 'Preencher com CFOP caso se trate de itens não relacionados com mercadorias/produto e que o contribuinte não possua codificação própriaFormato ”CFOP9999”', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (62, 'infNFe_det_prod_cEAN', 'character varying', 'GTIN (Global Trade Item Number) do produto', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (63, 'infNFe_det_prod_xProd', 'character varying', 'Descrição do produto ou serviço', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (64, 'infNFe_det_prod_NCM', 'character varying', 'Código NCM (8 posições)', 'não', 'Será permitida a informação do gênero (posição do capítulo do NCM) quando a operação não for de comércio exterior (importação/exportação) ou o produto não seja tributado pelo IPI. Em caso de item de serviço ou item que não tenham produto (Ex. transferência de crédito, crédito do ativo imobilizado, etc.), informar o código 00 (zeros) (v2.0)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (65, 'infNFe_det_prod_CFOP', 'character varying', 'Cfop', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (66, 'infNFe_det_prod_uCom', 'character varying', 'Unidade comercial', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (67, 'infNFe_det_prod_qCom', 'numeric(16,2)', 'Quantidade Comercial  do produto', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (68, 'infNFe_det_prod_vUnCom', 'numeric(16,2)', 'Valor unitário de comercialização', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (69, 'infNFe_det_prod_vProd', 'numeric(16,2)', 'Valor bruto do produto ou serviço', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (70, 'infNFe_det_prod_cEANTrib', 'character varying', 'GTIN (Global Trade Item Number) da unidade tributável', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (71, 'infNFe_det_prod_uTrib', 'character varying', 'Unidade Tributável', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (72, 'infNFe_det_prod_qTrib', 'numeric(16,2)', 'Quantidade Tributável', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (73, 'infNFe_det_prod_vUnTrib', 'numeric(16,2)', 'Valor unitário de tributação', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (74, 'infNFe_det_prod_vDesc', 'numeric(16,2)', 'Valor do Desconto', 'não', NULL, 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (75, 'infNFe_det_prod_indTot', 'character varying', 'Indica se o valor da item (vProd) entra no valor total da NFe (vProd)', 'não', '0 – o valor do item (vProd) não compõe o valor total da NF-e (vProd), 1 – o valor do item (vProd) compõe o valor total da NF-e (vProd)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (76, 'infNFe_det_imposto_vTotTrib', 'numeric(16,2)', 'Valor estimado total de impostos federais, estaduais e municipais', 'não', NULL, 'Grupo M. Tributos incidentes no Produto ou Serviço', 'fatoitemnfe'),
  (77, 'infNFe_det_imposto_ICMS_ICMS00_orig', 'integer', 'Origem da mercadoria', 'não', '0 - Nacional, 1 - Estrangeira - Importação direta, 2 - Estrangeira - Adquirida no mercado interno', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (78, 'infNFe_det_imposto_ICMS_ICMS00_CST', 'integer', 'Tributção pelo ICMS00 - Tributada integralmente', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (79, 'infNFe_det_imposto_ICMS_ICMS00_modBC', 'integer', 'Modalidade de determinação da BC do ICMS', 'não', '0 - Margem Valor Agregado (%), 1 - Pauta (valor), 2 - Preço Tabelado Máximo (valor), 3 - Valor da Operação', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (80, 'infNFe_det_imposto_ICMS_ICMS00_vBC', 'numeric(16,2)', 'Valor da BC do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (81, 'infNFe_det_imposto_ICMS_ICMS00_pICMS', 'numeric(16,2)', 'Alíquota do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (82, 'infNFe_det_imposto_ICMS_ICMS00_vICMS', 'numeric(16,2)', 'Valor do ICMS', 'não', NULL, 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (83, 'infNFe_total_ICMSTot_vBC', 'numeric(16,2)', 'BC do ICMS', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (84, 'infNFe_total_ICMSTot_vICMS', 'numeric(16,2)', 'Valor Total do ICMS', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (85, 'infNFe_total_ICMSTot_vICMSDeson', 'numeric(16,2)', 'Valor Total do ICMS desonerado', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (86, 'infNFe_total_ICMSTot_vST', 'numeric(16,2)', 'Valor Total do ICMS ST', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (87, 'infNFe_total_ICMSTot_vProd', 'numeric(16,2)', 'Valor Total dos produtos e serviços', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (88, 'infNFe_total_ICMSTot_vFrete', 'numeric(16,2)', 'Valor Total do Frete', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (89, 'infNFe_total_ICMSTot_vSeg', 'numeric(16,2)', 'Valor Total do Seguro', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (90, 'infNFe_total_ICMSTot_vDesc', 'numeric(16,2)', 'Valor Total do Desconto', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (91, 'infNFe_total_ICMSTot_vII', 'numeric(16,2)', 'Valor Total do II', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (92, 'infNFe_total_ICMSTot_vIPI', 'numeric(16,2)', 'Valor Total do IPI', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (93, 'infNFe_total_ICMSTot_vPIS', 'numeric(16,2)', 'Valor do PIS', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (94, 'infNFe_total_ICMSTot_vCOFINS', 'numeric(16,2)', 'Valor do COFINS', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (95, 'infNFe_total_ICMSTot_vOutro', 'numeric(16,2)', 'Outras Despesas acessórias', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (96, 'infNFe_total_ICMSTot_vNF', 'numeric(16,2)', 'Valor Total da NF-e', 'não', NULL, 'Grupo W. Total da NF-e', 'fatonfe'),
  (97, 'infProt_chNFe', 'character varying', 'Chaves de acesso da NF-e', NULL, 'compostas por: UF do emitente, AAMM da emissão da NFe, CNPJ do emitente, modelo, série e número da NF-e e código numérico+DV', NULL, 'fatonfe')  
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
	infNFe_total_ICMSTot_vST numeric(16,2),
	infNFe_total_ICMSTot_vProd numeric(16,2),
	infNFe_total_ICMSTot_vFrete numeric(16,2),
	infNFe_total_ICMSTot_vSeg numeric(16,2),
	infNFe_total_ICMSTot_vDesc numeric(16,2),
	infNFe_total_ICMSTot_vII numeric(16,2),
	infNFe_total_ICMSTot_vIPI numeric(16,2),
	infNFe_total_ICMSTot_vPIS numeric(16,2),
	infNFe_total_ICMSTot_vCOFINS numeric(16,2),
	infNFe_total_ICMSTot_vOutro numeric(16,2),
	infNFe_total_ICMSTot_vNF numeric(16,2)
);

CREATE TABLE app.fatoitemnfe(
	id BIGSERIAL PRIMARY KEY,
  infProt_chNFe character varying(44),
	infNFe_det_nItem character varying,
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
	infNFe_det_prod_vDesc numeric(16,2),
	infNFe_det_prod_indTot character varying,
	infNFe_det_imposto_vTotTrib numeric(16,2),
	infNFe_det_imposto_ICMS_ICMS00_orig integer,
	infNFe_det_imposto_ICMS_ICMS00_CST integer,
	infNFe_det_imposto_ICMS_ICMS00_modBC integer,
	infNFe_det_imposto_ICMS_ICMS00_vBC numeric(16,2),
	infNFe_det_imposto_ICMS_ICMS00_pICMS numeric(16,2),
	infNFe_det_imposto_ICMS_ICMS00_vICMS numeric(16,2)
);
CREATE UNIQUE INDEX fatoitemnfe_unique_index ON app.fatoitemnfe(infProt_chNFe, infNFe_det_nItem);

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
/* CREATE MATERIALIZED VIEW appmask.fatonfe AS SELECT
    id,
    15*sqnfe AS sqnfe,
    13*tpnfe AS tpnfe,
    14*idemitentecadastro AS idemitentecadastro,
    17*iddestinatariocadastro AS iddestinatariocadastro,
    19*idtransportadorcadastro AS idtransportadorcadastro,
    14*idcnaeemitente AS idcnaeemitente,
    11*idcnaedestinatario AS idcnaedestinatario,
    10*idemitentenfe AS idemitentenfe,
    18*iddestinatarionfe AS iddestinatarionfe,
    11*idtransportadornfe AS idtransportadornfe,
    anon.partial(idstnfe,2,$$*****$$,2) AS idstnfe,
    idtpnf,
    12*idcrtemit AS idcrtemit,
    12*iddest AS iddest,
    idmod,
    idtpimp,
    idtpemis,
    idfinnfe,
    idindfinal,
    idindpres,
    idprocemi,
    dtinclusao,
    dtemissao,
    dhrecebimento,
    encode(digest(chnfe, 'sha256'), 'hex') AS chnfe,
    versao,
    cuf,
    natop,
    3*serie AS serie,
    nnf,
    dhemi,
    dhsaient,
    19*cmunfg AS cmunfg,
    anon.partial(cnpjentrega,2,$$*****$$,2) AS cnpjentrega,
    anon.partial(ufentrega,2,$$*****$$,2) AS ufentrega,
    vbc,
    vicms,
    vicmsdeson,
    vfcpufdest,
    vicmsufdest,
    vicmsufremet,
    vfcp,
    vbcst,
    vst,
    vfcpst,
    vfcpstret,
    vprod,
    vfrete,
    vseg,
    vdesc,
    vii,
    vipi,
    vipidevol,
    vpis,
    vcofins,
    voutro,
    vnf,
    vtottrib,
    modfrete,
    vservtransp,
    vbcrettransp,
    picmsrettransp,
    vicmsrettransp,
    cfoptransp,
    cmunfgtransp,
    placaveic,
    ufveic,
    rntcveic,
    nfat,
    vorigfat,
    vdescfat,
    vliqfat,
    infadfisco,
    infcpl,
    ufsaidapais,
    xlocexporta,
    xlocdespacho,
    xnempcompras,
    xpedcompras,
    xcontcompras,
    safra,
    refcana,
    3*Cast("CNPJEmit" as bigint) AS "CNPJEmit",
    anon.partial("CPFEmit",2,$$*****$$,2) AS "CPFEmit",
    anon.fake_first_name() AS "xNomeEmit",
    anon.fake_company() AS "xFantEmit",
    anon.fake_region() AS "xLgrEmit",
    anon.random_zip() AS "nroEmit",
    anon.random_string(8) AS "xCplEmit",
    anon.fake_region() AS "xBairroEmit",
    anon.fake_region() AS "cMunEmit",
    anon.random_zip() AS "xMunEmit",
    anon.random_string(3) AS "UFEmit",
    anon.random_zip() AS "CEPEmit",
    anon.random_string(4) AS "cPaisEmit",
    anon.fake_country() AS "xPaisEmit",
    3*Cast("foneEmit" as bigint) AS "foneEmit",
    anon.random_string(4) AS "IEEmit",
    anon.random_string(4) AS "IESTEmit",
    anon.random_string(8) AS "IMEmit",
    anon.partial("CNAEEmit",2,$$*****$$,2) AS "CNAEEmit",
    anon.partial("CRTEmit",2,$$*****$$,2) AS "CRTEmit"
FROM app.fatonfe;

CREATE MATERIALIZED VIEW appmask.fatoitemnfe AS SELECT
    id,
    20*sqnfe AS sqnfe,
    15*nritemnfe AS nritemnfe,
    anon.partial(idstnfe,2,$$*****$$,2) AS idstnfe,
    16*idtpnfe AS idtpnfe,
    13*idufemit AS idufemit,
    14*idcrtemit AS idcrtemit,
    encode(digest(chnfe, 'sha256'), 'hex') AS chnfe,
    natop,
    16*idmod AS idmod,
    10*serie AS serie,
    19*nnf AS nnf,
    dhemi,
    dhsaient,
    idtpoperacao,
    14*iddest AS iddest,
    16*idmunfg AS idmunfg,
    10*idfinnfe AS idfinnfe,
    idindfinal,
    idindpres,
    dtinclusao,
    dtemissao,
    13*idmodfrete AS idmodfrete,
    17*idemitentecadastro AS idemitentecadastro,
    17*iddestinatariocadastro AS iddestinatariocadastro,
    14*idtransportadorcadastro AS idtransportadorcadastro,
    20*idemitentenfe AS idemitentenfe,
    11*iddestinatarionfe AS iddestinatarionfe,
    idtransportadornfe,
    20*idcnaeemitente AS idcnaeemitente,
    13*idcnaedestinatario AS idcnaedestinatario,
    20*idveiculo AS idveiculo,
    17*idcombustivel AS idcombustivel,
    versao,
    cprod,
    idcean,
    xprod,
    ncm,
    cest,
    indescala,
    anon.partial(cnpjfab,2,$$*****$$,2) AS cnpjfab,
    cbenef,
    extipi,
    cfop,
    ucom,
    qcom,
    vuncom,
    vprod,
    idceantrib,
    utrib,
    qtrib,
    vuntrib,
    vfrete,
    vseg,
    vdesc,
    voutro,
    idindtot,
    cprodanvisa,
    xmotivoisencao,
    vpmc,
    idorig,
    idcst,
    idmodbc,
    vbc,
    picms,
    vicms,
    pfcp,
    vfcp,
    vbcfcp,
    idmodbcst,
    pmvast,
    predbcst,
    vbcst,
    picmsst,
    vicmsst,
    vbcfcpst,
    pfcpst,
    vfcpst,
    predbc,
    vicmsdeson,
    idmotdesicms,
    vicmsop,
    pdif,
    vicmsdif,
    vbcstret,
    pst,
    vicmssubstituto,
    vicmsstret,
    vbcfcpstret,
    pfcpstret,
    vfcpstret,
    predbcefet,
    vbcefet,
    picmsefet,
    vicmsefet,
    idorigicmspart,
    idcsticmspart,
    idmodbcicmspart,
    vbcicmspart,
    predbcicmspart,
    picmsicmspart,
    vicmsicmspart,
    idmodbcsticmspart,
    pmvasticmspart,
    predbcsticmspart,
    vbcsticmspart,
    picmssticmspart,
    vicmssticmspart,
    pbcopicmspart,
    ufsticmspart,
    idorigrepassest,
    idcstrepassest,
    vbcstretrepassest,
    pstrepassest,
    vicmssubstitutorepassest,
    vicmsstretrepassest,
    vbcfcpstretrepassest,
    pfcpstretrepassest,
    vfcpstretrepassest,
    vbcstdestrepassest,
    vicmsstdestrepassest,
    predbcefetrepassest,
    vbcefetrepassest,
    picmsefetrepassest,
    vicmsefetrepassest,
    idorigcrt,
    csosn,
    pcredsncrt,
    vcredicmssncrt,
    idmodbcstcrt,
    pmvasticmscrt,
    predbcstcrt,
    picmsstcrt,
    vicmsstcrt,
    vbcfcpstcrt,
    pfcpstcrt,
    vfcpstcrt,
    vbcstretcrt,
    vicmsstretcrt,
    vbcstcrt,
    vtottribgm,
    vbcufdest,
    vbcfcpufdest,
    pfcpufdest,
    picmsufdest,
    picmsinter,
    picmsinterpart,
    vfcpufdestgna,
    vicmsufdestgna,
    vicmsufremetgna,
    xped,
    nitemped,
    nrfci,
    vbcimportacao,
    vdespaduimportacao,
    viiimportacao,
    viofimportacao,
    idcstpisaliq,
    vbcpisaliq,
    ppispisaliq,
    vpispisaliq,
    idcstpisqtde,
    qbcprodpisqtde,
    valiqprodpisqtde,
    vpispisqtde,
    idcstpisnt,
    idcstpisoutr,
    vbcpisoutr,
    ppisoutr,
    qbcprodpisoutr,
    valiqprodpisoutr,
    vpisoutr,
    vbcpisst,
    ppisst,
    qbcprodpisst,
    valiqprodpisst,
    vpisst,
    idcstcofinsaliq,
    vbccofinsaliq,
    pcofinsaliq,
    vcofinsaliq,
    idcstcofinsqtde,
    qbcprodcofinsqtde,
    valiqprodcofinsqtde,
    vcofinsqtde,
    idcstcofinsnt,
    idcstcofinsoutr,
    vbccofinsoutr,
    pcofinsoutr,
    qbcprodoutr,
    valiqprodoutr,
    vcofinsoutr,
    vbccofinsst,
    pcofinsst,
    qbcprodcofinsst,
    valiqprodcofinsst,
    vcofinsst,
    vbcissqn,
    valiqissqn,
    vissqn,
    cmunfgissqn,
    clistservissqn,
    vdeducaoissqn,
    voutroissqn,
    vdescincondissqn,
    vdesccondissqn,
    vissretissqn,
    idindississqn,
    cservicoissqn,
    cmunissqn,
    cpaisissqn,
    nprocessoissqn,
    idindincentivoissqn,
    pdevol,
    vipidevol,
    nfadprod
FROM app.fatoitemnfe; */


-- Hasura - see https://github.com/arialab/sefazpb-infra/tree/master/hasura

-- change database and user
\connect datalake postgres

-- create a separate user for hasura
CREATE USER hasurauser WITH PASSWORD 'quaevu8U';

-- grant connection to 'hasurauser' on database 'datalake'
GRANT CONNECT ON DATABASE datalake TO hasurauser;

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

GRANT USAGE ON SCHEMA public TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA public TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO hasurauser;


-- EFD create_tables.sql - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/datalake/EFD/loader
\connect datalake datalakeuser

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
    descricao bytea
);

--Create patitons table
CREATE TABLE app.efd_2013_11(PRIMARY KEY (id), CHECK (periodo = '201311')) INHERITS (app.efd);
CREATE TABLE app.efd_2013_12(PRIMARY KEY (id), CHECK (periodo = '201312')) INHERITS (app.efd);

CREATE TABLE app.efd_2014_01(PRIMARY KEY (id), CHECK (periodo = '201401')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_02(PRIMARY KEY (id), CHECK (periodo = '201402')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_03(PRIMARY KEY (id), CHECK (periodo = '201403')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_04(PRIMARY KEY (id), CHECK (periodo = '201404')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_05(PRIMARY KEY (id), CHECK (periodo = '201405')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_06(PRIMARY KEY (id), CHECK (periodo = '201406')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_07(PRIMARY KEY (id), CHECK (periodo = '201407')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_08(PRIMARY KEY (id), CHECK (periodo = '201408')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_09(PRIMARY KEY (id), CHECK (periodo = '201409')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_10(PRIMARY KEY (id), CHECK (periodo = '201410')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_11(PRIMARY KEY (id), CHECK (periodo = '201411')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_12(PRIMARY KEY (id), CHECK (periodo = '201412')) INHERITS (app.efd);

CREATE TABLE app.efd_2016_08(PRIMARY KEY (id), CHECK (periodo = '201608')) INHERITS (app.efd);
CREATE TABLE app.efd_2016_10(PRIMARY KEY (id), CHECK (periodo = '201610')) INHERITS (app.efd);

CREATE TABLE app.efd_2018_01(PRIMARY KEY (id), CHECK (periodo = '201801')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_02(PRIMARY KEY (id), CHECK (periodo = '201802')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_03(PRIMARY KEY (id), CHECK (periodo = '201803')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_04(PRIMARY KEY (id), CHECK (periodo = '201804')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_05(PRIMARY KEY (id), CHECK (periodo = '201805')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_06(PRIMARY KEY (id), CHECK (periodo = '201806')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_07(PRIMARY KEY (id), CHECK (periodo = '201807')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_08(PRIMARY KEY (id), CHECK (periodo = '201808')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_09(PRIMARY KEY (id), CHECK (periodo = '201809')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_10(PRIMARY KEY (id), CHECK (periodo = '201810')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_11(PRIMARY KEY (id), CHECK (periodo = '201811')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_12(PRIMARY KEY (id), CHECK (periodo = '201812')) INHERITS (app.efd);

CREATE TABLE app.efd_2019_01(PRIMARY KEY (id), CHECK (periodo = '201901')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_02(PRIMARY KEY (id), CHECK (periodo = '201902')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_03(PRIMARY KEY (id), CHECK (periodo = '201903')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_04(PRIMARY KEY (id), CHECK (periodo = '201904')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_05(PRIMARY KEY (id), CHECK (periodo = '201905')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_06(PRIMARY KEY (id), CHECK (periodo = '201906')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_07(PRIMARY KEY (id), CHECK (periodo = '201907')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_08(PRIMARY KEY (id), CHECK (periodo = '201908')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_09(PRIMARY KEY (id), CHECK (periodo = '201909')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_10(PRIMARY KEY (id), CHECK (periodo = '201910')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_11(PRIMARY KEY (id), CHECK (periodo = '201911')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_12(PRIMARY KEY (id), CHECK (periodo = '201912')) INHERITS (app.efd);

CREATE TABLE app.efd_2020_01(PRIMARY KEY (id), CHECK (periodo = '202001')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_02(PRIMARY KEY (id), CHECK (periodo = '202002')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_03(PRIMARY KEY (id), CHECK (periodo = '202003')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_05(PRIMARY KEY (id), CHECK (periodo = '202005')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_06(PRIMARY KEY (id), CHECK (periodo = '202006')) INHERITS (app.efd);


--Creating index to partitioned tables
CREATE INDEX idx_efd_2013_11 ON app.efd_2013_11 (periodo);
CREATE INDEX idx_efd_2013_12 ON app.efd_2013_12 (periodo);

CREATE INDEX idx_efd_2014_01 ON app.efd_2014_01 (periodo);
CREATE INDEX idx_efd_2014_02 ON app.efd_2014_02 (periodo);
CREATE INDEX idx_efd_2014_03 ON app.efd_2014_03 (periodo);
CREATE INDEX idx_efd_2014_04 ON app.efd_2014_04 (periodo);
CREATE INDEX idx_efd_2014_05 ON app.efd_2014_05 (periodo);
CREATE INDEX idx_efd_2014_06 ON app.efd_2014_06 (periodo);
CREATE INDEX idx_efd_2014_07 ON app.efd_2014_07 (periodo);
CREATE INDEX idx_efd_2014_08 ON app.efd_2014_08 (periodo);
CREATE INDEX idx_efd_2014_09 ON app.efd_2014_09 (periodo);
CREATE INDEX idx_efd_2014_10 ON app.efd_2014_10 (periodo);
CREATE INDEX idx_efd_2014_11 ON app.efd_2014_11 (periodo);
CREATE INDEX idx_efd_2014_12 ON app.efd_2014_12 (periodo);

CREATE INDEX idx_efd_2016_08 ON app.efd_2016_08 (periodo);
CREATE INDEX idx_efd_2016_10 ON app.efd_2016_10 (periodo);

CREATE INDEX idx_efd_2018_01 ON app.efd_2018_01 (periodo);
CREATE INDEX idx_efd_2018_02 ON app.efd_2018_02 (periodo);
CREATE INDEX idx_efd_2018_03 ON app.efd_2018_03 (periodo);
CREATE INDEX idx_efd_2018_04 ON app.efd_2018_04 (periodo);
CREATE INDEX idx_efd_2018_05 ON app.efd_2018_05 (periodo);
CREATE INDEX idx_efd_2018_06 ON app.efd_2018_06 (periodo);
CREATE INDEX idx_efd_2018_07 ON app.efd_2018_07 (periodo);
CREATE INDEX idx_efd_2018_08 ON app.efd_2018_08 (periodo);
CREATE INDEX idx_efd_2018_09 ON app.efd_2018_09 (periodo);
CREATE INDEX idx_efd_2018_10 ON app.efd_2018_10 (periodo);
CREATE INDEX idx_efd_2018_11 ON app.efd_2018_11 (periodo);
CREATE INDEX idx_efd_2018_12 ON app.efd_2018_12 (periodo);

CREATE INDEX idx_efd_2019_01 ON app.efd_2019_01 (periodo);
CREATE INDEX idx_efd_2019_02 ON app.efd_2019_02 (periodo);
CREATE INDEX idx_efd_2019_03 ON app.efd_2019_03 (periodo);
CREATE INDEX idx_efd_2019_04 ON app.efd_2019_04 (periodo);
CREATE INDEX idx_efd_2019_05 ON app.efd_2019_05 (periodo);
CREATE INDEX idx_efd_2019_06 ON app.efd_2019_06 (periodo);
CREATE INDEX idx_efd_2019_07 ON app.efd_2019_07 (periodo);
CREATE INDEX idx_efd_2019_08 ON app.efd_2019_08 (periodo);
CREATE INDEX idx_efd_2019_09 ON app.efd_2019_09 (periodo);
CREATE INDEX idx_efd_2019_10 ON app.efd_2019_10 (periodo);
CREATE INDEX idx_efd_2019_11 ON app.efd_2019_11 (periodo);
CREATE INDEX idx_efd_2019_12 ON app.efd_2019_12 (periodo);

CREATE INDEX idx_efd_2020_01 ON app.efd_2020_01 (periodo);
CREATE INDEX idx_efd_2020_02 ON app.efd_2020_02 (periodo);
CREATE INDEX idx_efd_2020_03 ON app.efd_2020_03 (periodo);
CREATE INDEX idx_efd_2020_05 ON app.efd_2020_05 (periodo);
CREATE INDEX idx_efd_2020_06 ON app.efd_2020_06 (periodo);

--Procedure to insert data into matching partitioned tables
CREATE OR REPLACE FUNCTION efd_insert()
	RETURNS TRIGGER AS $$
	BEGIN
  IF (NEW.periodo = '201311') THEN
	INSERT INTO app.efd_2013_11 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201312') THEN
	INSERT INTO app.efd_2013_12 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '201401') THEN
	INSERT INTO app.efd_2014_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201402') THEN
	INSERT INTO app.efd_2014_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201403') THEN
	INSERT INTO app.efd_2014_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201404') THEN
	INSERT INTO app.efd_2014_04 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201405') THEN
	INSERT INTO app.efd_2014_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201406') THEN
	INSERT INTO app.efd_2014_06 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201407') THEN
	INSERT INTO app.efd_2014_07 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201408') THEN
	INSERT INTO app.efd_2014_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201409') THEN
	INSERT INTO app.efd_2014_09 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201410') THEN
	INSERT INTO app.efd_2014_10 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201411') THEN
	INSERT INTO app.efd_2014_11 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201412') THEN
	INSERT INTO app.efd_2014_12 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '201608') THEN
	INSERT INTO app.efd_2016_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201610') THEN
	INSERT INTO app.efd_2016_10 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '201801') THEN
	INSERT INTO app.efd_2018_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201802') THEN
	INSERT INTO app.efd_2018_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201803') THEN
	INSERT INTO app.efd_2018_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201804') THEN
	INSERT INTO app.efd_2018_04 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201805') THEN
	INSERT INTO app.efd_2018_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201806') THEN
	INSERT INTO app.efd_2018_06 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201807') THEN
	INSERT INTO app.efd_2018_07 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201808') THEN
	INSERT INTO app.efd_2018_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201809') THEN
	INSERT INTO app.efd_2018_09 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201810') THEN
	INSERT INTO app.efd_2018_10 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201811') THEN
	INSERT INTO app.efd_2018_11 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201812') THEN
	INSERT INTO app.efd_2018_12 VALUES (NEW.*);

	ELSEIF (NEW.periodo = '201901') THEN
	INSERT INTO app.efd_2019_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201902') THEN
	INSERT INTO app.efd_2019_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201903') THEN
	INSERT INTO app.efd_2019_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201904') THEN
	INSERT INTO app.efd_2019_04 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201905') THEN
	INSERT INTO app.efd_2019_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201906') THEN
	INSERT INTO app.efd_2019_06 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201907') THEN
	INSERT INTO app.efd_2019_07 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201908') THEN
	INSERT INTO app.efd_2019_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201909') THEN
	INSERT INTO app.efd_2019_09 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201910') THEN
	INSERT INTO app.efd_2019_10 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201911') THEN
	INSERT INTO app.efd_2019_11 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201912') THEN
	INSERT INTO app.efd_2019_12 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '202001') THEN
	INSERT INTO app.efd_2020_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202002') THEN
	INSERT INTO app.efd_2020_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202003') THEN
	INSERT INTO app.efd_2020_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202005') THEN
	INSERT INTO app.efd_2020_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202006') THEN
	INSERT INTO app.efd_2020_06 VALUES (NEW.*);
	ELSE
	RAISE EXCEPTION 'Periodo não possui tabela definida';
	END IF;
	RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;

--Create a trigger to manage the insert process
DROP TRIGGER IF EXISTS efd_insert_trigger on app.efd;
CREATE TRIGGER efd_insert_trigger
  BEFORE INSERT ON app.efd
  FOR EACH ROW
  EXECUTE PROCEDURE efd_insert();

--Constraint exclusion to optimze performance for partitioned tables
SET constraint_exclusion = on;
SELECT count(*) FROM app.efd WHERE periodo >= '201311';
