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
  (0, 'infnfe_ide_cuf', 'integer', 'Código da UF do emitente do Documento Fiscal', 'não', 'Utilizar a Tabela do IBGE ', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (1, 'infnfe_ide_cnf', 'character varying', 'Código numérico para evitar acesso indevido ', 'sim', 'Número aleatório que compõe o código numérico gerado pelo emitente para cada NF-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (2, 'infnfe_ide_natop', 'character varying', 'Descrição da Natureza da Operação', 'não', 'nan', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (3, 'infnfe_ide_mod', 'integer', 'Código do modelo do Documento Fiscal', 'não', '55 - NF-e; 65 - NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (4, 'infnfe_ide_serie', 'character varying', 'Série do Documento Fiscal ', 'sim', 'Série normal - 0-889; Avulsa Fisco - 890-899; SCAN - 900-999', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (5, 'infnfe_ide_nnf', 'character varying', 'Número do Documento Fiscal', 'sim', 'nan', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (6, 'infnfe_ide_dhemi', 'timestamp with time zone', 'Data e Hora de emissão do Documento Fiscal ', 'não', '(AAAA-MM-DDTHH:mm:ssTZD) Ex.: 2012-09-01T13:00:00-03:00', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (7, 'infnfe_ide_dhsaient', 'timestamp with time zone', 'Data e Hora da saída ou de entrada da mercadoria/produto ', 'não', '(AAAA-MM-DDTHH:mm:ssTZD) Ex.: 2012-09-01T13:00:00-03:00', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (8, 'infnfe_ide_tpnf', 'integer', 'Tipo do Documento Fiscal', 'não', '0 - Entrada; 1 - Saída', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (9, 'infnfe_ide_iddest', 'integer', 'Identificador de Local de destino da operação ', 'não', '1 - Interna; 2 -Interestadual; 3 - Exterior', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (10, 'infnfe_ide_cmunfg', 'character varying', 'Código do Município de Ocorrência do Fato Gerador', 'sim', 'Utilizar a Tabela do IBGE.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (11, 'infnfe_ide_tpimp', 'integer', 'Formato de impressão do DANFE', 'não', '0 - sem DANFE;  1 - DANFe Retrato; 2 - DANFe Paisagem; 3 - DANFe Simplificado; 4 - DANFe NFC-e; 5 - DANFe NFC-e em mensagem eletrônica', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (12, 'infnfe_ide_tpemis', 'integer', 'Forma de emissão da NF-e ', 'não', '1 - Normal 2 - Contingência FS 3 - Contingência SCAN 4 - Contingência DPEC 5 - Contingência FSDA 6 - Contingência SVC - AN 7 - Contingência SVC - RS 9 - Contingência off-line NFC-e', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (13, 'infnfe_ide_cdv', 'integer', 'Dígito Verificador da Chave de Acesso da NF-e', 'sim', 'nan', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (14, 'infnfe_ide_tpamb', 'integer', 'Identificação do Ambiente', 'não', '1 - Produção 2 - Homologação', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (15, 'infnfe_ide_finnfe', 'integer', 'Finalidade da emissão da NF-e', 'não', '1 - NFe normal 2 - NFe complementar 3 - NFe de ajuste 4 - Devolução/Retorno', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (16, 'infnfe_ide_indfinal', 'integer', 'Indica operação com consumidor final', 'não', '0 - Não; 1 - Consumidor Final', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (17, 'infnfe_ide_indpres', 'integer', 'Indicador de presença do comprador no estabelecimento comercial no momento da operação', 'não', '0 - Não se aplica (ex.: Nota Fiscal complementar ou de ajuste); 1 - Operação presencial; 2 - Não presencial, internet; 3 - Não presencial, teleatendimento; 4 - NFC-e entrega em domicílio; 5 - Operação presencial, fora do estabelecimento; 9 - Não presencial, outros', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (18, 'infnfe_ide_procemi', 'integer', 'Processo de emissão utilizado com a seguinte codificação', 'não', '0 - Emissão de NF-e com aplicativo do contribuinte; 1 - Emissão de NF-e avulsa pelo Fisco; 2 - Emissão de NF-e avulsa, pelo contribuinte com seu certificado digital, através do sitedo Fisco; 3 - 
 Emissão de NF-e pelo contribuinte com aplicativo fornecido pelo Fisco.', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (19, 'infnfe_ide_verproc', 'character varying', 'Versão do aplicativo utilizado no processo de emissão', 'não', 'nan', 'Grupo B. Identificação da Nota Fiscal eletrônica', 'fatonfe'),
  (20, 'infnfe_emit_cnpj', 'char(14)', 'Número do CNPJ do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (21, 'infnfe_emit_cpf', 'character varying', 'Número do CPF do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (22, 'infnfe_emit_xnome', 'character varying', 'Razão Social ou Nome do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (23, 'infnfe_emit_xfant', 'character varying', 'Nome fantasia do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (24, 'infnfe_emit_enderemit_xlgr', 'character varying', 'Logradouro do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (25, 'infnfe_emit_enderemit_nro', 'character varying', 'Número do endereço do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (26, 'infnfe_emit_enderemit_xcpl', 'character varying', 'Complemento do endereço do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (27, 'infnfe_emit_enderemi_xbairro', 'character varying', 'Bairro do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (28, 'infnfe_emit_enderemit_cmun', 'character varying', 'Código do município do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (29, 'infnfe_emit_enderemit_xmun', 'character varying', 'Nome do município do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (30, 'infnfe_emit_enderemit_uf', 'character varying', 'Sigla da UF do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (31, 'infnfe_emit_enderemit_cep', 'character varying', 'CEP - NT 2011/004 do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (32, 'infnfe_emit_enderemit_cpais', 'character varying', 'Código do país do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (33, 'infnfe_emit_enderemit_xpais', 'character varying', 'Nome do país do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (34, 'infnfe_emit_enderemit_fone', 'character varying', 'Código DDD + número do telefone (v.2.0) do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (35, 'infnfe_emit_ie', 'character varying', 'Inscrição Estadual do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (36, 'infnfe_emit_iest', 'character varying', 'Inscricao Estadual do Substituto Tributário do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (37, 'infnfe_emit_im', 'character varying', 'Inscrição Municipal do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (38, 'infnfe_emit_cnae', 'character varying', 'CNAE Fiscal do emitente', 'sim', 'nan', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (39, 'infnfe_emit_crt', 'character varying', 'Código de Regime Tributário do emitente', 'não', 'Este campo será obrigatoriamente preenchido com: 1 – Simples Nacional; 2 – Simples Nacional – excesso de sublimite de receita bruta; 3 – Regime Normal.', 'Grupo C. Identificação do Emitente da Nota Fiscal eletrônica', 'fatonfe'),
  (40, 'infnfe_dest_cnpj', 'char(14)', 'Número do CNPJ do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (41, 'infnfe_dest_cpf', 'character varying', 'Número do CPF do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (42, 'infnfe_dest_idestrangeiro', 'character varying', 'Identificador do destinatário, em caso de comprador estrangeiro', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (43, 'infnfe_dest_xnome', 'character varying', 'Razão Social ou nome do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (44, 'infnfe_dest_enderdest_xlgr', 'character varying', 'Logradouro do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (45, 'infnfe_dest_enderdest_nro', 'character varying', 'Número do endereço do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (46, 'infnfe_dest_enderdest_xcpl', 'character varying', 'Complemento do endereço do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (47, 'infnfe_dest_enderdest_xbairro', 'character varying', 'Bairro do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (48, 'infnfe_dest_enderdest_cmun', 'character varying', 'Código do município do destinatário', 'sim', 'Utilizar a tabela do IBGE, informar 9999999 para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (49, 'infnfe_dest_enderdest_xmun', 'character varying', 'Nome do município do destinatário', 'sim', 'Informar EXTERIOR para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (50, 'infnfe_dest_enderdest_uf', 'character varying', 'Sigla da UF, informar EX para operações com o exterior do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (51, 'infnfe_dest_enderdest_cep', 'character varying', 'CEP do destinatário', 'sim', 'Informar EX para operações com o exterior', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (52, 'infnfe_dest_enderdest_cpais', 'character varying', 'Código de país do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (53, 'infnfe_dest_enderdest_xpais', 'character varying', 'Nome do país do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (54, 'infnfe_dest_enderdest_fone', 'character varying', 'Código DDD + número do telefone (v.2.0) do destinatário', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (55, 'infnfe_dest_indiedest', 'character varying', 'Indicador da IE do destinatário', 'sim', '1 – Contribuinte ICMS pagamento à vista; 2 – Contribuinte isento de inscrição; 9 – Não Contribuinte', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (56, 'infnfe_dest_ie', 'character varying', 'Inscrição Estadual do destinatário', 'sim', 'Obrigatório nas operações com contribuintes do ICMS', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (57, 'infnfe_dest_isuf', 'character varying', 'Inscrição na SUFRAMA do destinatário', 'sim', 'Obrigatório nas operações com as áreas com benefícios de incentivos fiscais sob controle da SUFRAMA - PL_005d - 11/08/09 - alterado para aceitar 8 ou 9 dígitos', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (58, 'infnfe_dest_im', 'character varying', 'Inscrição Municipal do tomador do serviço', 'sim', 'nan', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (59, 'infnfe_dest_email', 'character varying', 'Informar o e-mail do destinatário', 'sim', 'O campo pode ser utilizado para informar o e-mailde recepção da NF-e indicada pelo destinatário', 'Grupo E. Identificação do Destinatário da Nota Fiscal eletrônica', 'fatonfe'),
  (60, 'infnfe_det_nitem', 'character varying', 'Dados dos detalhes da NF-e', 'não', 'nan', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (61, 'infnfe_det_prod_cprod', 'character varying', 'Código do produto ou serviço', 'não', 'Preencher com CFOP caso se trate de itens não relacionados com mercadorias/produto e que o contribuinte não possua codificação própriaFormato ”CFOP9999”', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (62, 'infnfe_det_prod_cean', 'character varying', 'GTIN (Global Trade Item Number) do produto', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (63, 'infnfe_det_prod_xprod', 'character varying', 'Descrição do produto ou serviço', 'não', 'nan', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (64, 'infnfe_det_prod_ncm', 'character varying', 'Código NCM (8 posições)', 'não', 'Será permitida a informação do gênero (posição do capítulo do NCM) quando a operação não for de comércio exterior (importação/exportação) ou o produto não seja tributado pelo IPI. Em caso de item de serviço ou item que não tenham produto (Ex. transferência de crédito, crédito do ativo imobilizado, etc.), informar o código 00 (zeros) (v2.0)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (65, 'infnfe_det_prod_cfop', 'character varying', 'Cfop', 'não', 'nan', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (66, 'infnfe_det_prod_ucom', 'character varying', 'Unidade comercial', 'não', 'nan', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (67, 'infnfe_det_prod_qcom', 'numeric(16,2)', 'Quantidade Comercial  do produto', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (68, 'infnfe_det_prod_vuncom', 'numeric(16,2)', 'Valor unitário de comercialização  ', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (69, 'infnfe_det_prod_vprod', 'numeric(16,2)', 'Valor bruto do produto ou serviço', 'não', 'nan', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (70, 'infnfe_det_prod_ceantrib', 'character varying', 'GTIN (Global Trade Item Number) da unidade tributável', 'não', 'Antigo código EAN ou código de barras', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (71, 'infnfe_det_prod_utrib', 'character varying', 'Unidade Tributável', 'não', 'nan', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (72, 'infnfe_det_prod_qtrib', 'numeric(16,2)', 'Quantidade Tributável ', 'não', 'Alterado para aceitar de 0 a 4 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (73, 'infnfe_det_prod_vuntrib', 'numeric(16,2)', 'Valor unitário de tributação ', 'não', 'Alterado para aceitar 0 a 10 casas decimais e 11 inteiros', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (74, 'infnfe_det_prod_vdesc', 'numeric(16,2)', 'Valor do Desconto', 'não', 'nan', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (75, 'infnfe_det_prod_indtot', 'character varying', 'Indica se o valor da item (vProd) entra no valor total da NFe (vProd)', 'não', '0 – o valor do item (vProd) não compõe o valor total da NF-e (vProd); 1 – o valor do item (vProd) compõe o valor total da NF-e (vProd)', 'Grupo I. Produtos e Serviços da NF-e', 'fatoitemnfe'),
  (76, 'infnfe_det_imposto_vtottrib', 'numeric(16,2)', 'Valor estimado total de impostos federais, estaduais e municipais', 'não', 'nan', 'Grupo M. Tributos incidentes no Produto ou Serviço', 'fatoitemnfe'),
  (77, 'infnfe_det_imposto_icms_icms00_orig', 'integer', 'Origem da mercadoria - ICMS00', 'não', '0 - Nacional; 1 - Estrangeira - Importação direta; 2 - Estrangeira - Adquirida no mercado interno', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (78, 'infnfe_det_imposto_icms_icms00_cst', 'integer', 'Tributação pelo ICMS00 - Tributada integralmente', 'não', 'nan', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (79, 'infnfe_det_imposto_icms_icms00_modbc', 'integer', 'Modalidade de determinação da BC do ICMS00    ', 'não', '0 - Margem Valor Agregado (%); 1 - Pauta (valor); 2 - Preço Tabelado Máximo (valor); 3 - Valor da Operação', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (80, 'infnfe_det_imposto_icms_icms00_vbc', 'numeric(16,2)', 'Valor da BC do ICMS00', 'não', 'nan', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (81, 'infnfe_det_imposto_icms_icms00_picms', 'numeric(16,2)', 'Alíquota do ICMS00', 'não', 'nan', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (82, 'infnfe_det_imposto_icms_icms00_vicms', 'numeric(16,2)', 'Valor do ICMS00', 'não', 'nan', 'Grupo N. ICMS Normal e ST', 'fatoitemnfe'),
  (83, 'infnfe_total_icmstot_vbc', 'numeric(16,2)', 'BC do ICMS total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (84, 'infnfe_total_icmstot_vicms', 'numeric(16,2)', 'Valor Total do ICMS ', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (85, 'infnfe_total_icmstot_vicmsdeson', 'numeric(16,2)', 'Valor Total do ICMS desonerado', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (86, 'infnfe_total_icmstot_vst', 'numeric(16,2)', 'Valor Total do ICMS ST', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (87, 'infnfe_total_icmstot_vprod', 'numeric(16,2)', 'Valor Total dos produtos e serviços - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (88, 'infnfe_total_icmstot_vfrete', 'numeric(16,2)', 'Valor Total do Frete - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (89, 'infnfe_total_icmstot_vseg', 'numeric(16,2)', 'Valor Total do Seguro - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (90, 'infnfe_total_icmstot_vdesc', 'numeric(16,2)', 'Valor Total do Desconto - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (91, 'infnfe_total_icmstot_vii', 'numeric(16,2)', 'Valor Total do II - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (92, 'infnfe_total_icmstot_vipi', 'numeric(16,2)', 'Valor Total do IPI - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (93, 'infnfe_total_icmstot_vpis', 'numeric(16,2)', 'Valor do PIS - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (94, 'infnfe_total_icmstot_vcofins', 'numeric(16,2)', 'Valor do COFINS - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (95, 'infnfe_total_icmstot_voutro', 'numeric(16,2)', 'Outras Despesas acessórias - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (96, 'infnfe_total_icmstot_vnf', 'numeric(16,2)', 'Valor Total da NF-e - ICMS Total', 'não', 'nan', 'Grupo W. Total da NF-e', 'fatonfe'),
  (97, 'infprot_chnfe', 'character varying', 'Chaves de acesso da NF-e', 'nan', 'compostas por: UF do emitente, AAMM da emissão da NFe, CNPJ do emitente, modelo, série e número da NF-e e código numérico+DV', 'nan', 'fatonfe'),
  (98, 'informix_stnfeletronica', 'character varying', 'Situação da Nota Fiscal Eletrônica', 'não', 'A - Autorizada dentro do prazo; C - Cancelada; D - Denegada por irregularidade do Emitente; O - Autorizada fora do prazo; I - Denegada por irregularidade do Destinatário; U- Denegação por Destinatário não habilitado a operar na UF', 'Informações do Informix', 'fatonfe'),
  (99, 'informix_dhconexao', 'character varying', 'Data e hora da conexão de envio da Nota Fiscal Eletrônica', 'não', 'nan', 'Informações do Informix', 'fatonfe'),
  (100, 'informix_nriptransmissor ', 'character varying', 'IP da conexão de envio da Nota Fiscal Eletrônica', 'sim', 'nan', 'Informações do Informix', 'fatonfe'),
  (101, 'informix_nrportacon', 'integer', 'Porta da conexão de envio da Nota Fiscal Eletrônica', 'não', 'nan', 'Informações do Informix', 'fatonfe')
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
    infNFe_pag_detpag_indPag character varying(1),
    infNFe_pag_detpag_tPag character varying(2),
    infNFe_pag_detpag_vPag numeric(16,2),
    infNFe_pag_detpag_card_tpIntegra character varying(1),
    infNFe_pag_detpag_card_CNPJ character varying,
    infNFe_pag_detpag_card_tBand character varying(2),
    infNFe_pag_detpag_card_cAut character varying(20),
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

CREATE INDEX idx_infnfe_ide_dhemi ON app.fatonfe USING btree (infnfe_ide_dhemi);
CREATE INDEX fatonfe_infnfe_ide_mod_idx ON app.fatonfe USING btree (infnfe_ide_mod);
CREATE INDEX fatonfe_infnfe_emit_cnpj_idx ON app.fatonfe USING btree (infnfe_emit_cnpj);
CREATE INDEX fatonfe_infnfe_emit_ie_idx ON app.fatonfe USING btree (infnfe_emit_ie);
CREATE INDEX idx_infnfe_dest_cnpj ON app.fatonfe USING btree (infnfe_dest_cnpj);

CREATE TABLE app.fatoitemnfe(
	id BIGSERIAL,
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
    infNFe_det_imposto_ICMSUFDest_vICMSUFRemet numeric(16,2)
);
CREATE UNIQUE INDEX fatoitemnfe_unique_index ON app.fatoitemnfe(infProt_chNFe, infNFe_det_nItem);
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
   	infNFe_cobr_fat_nFat ,
   	infNFe_cobr_fat_vOrig ,
   	infNFe_cobr_fat_vDesc ,
   	infNFe_cobr_fat_vLiq ,
    infNFe_pag_detpag_indPag ,
    infNFe_pag_detpag_tPag,
    infNFe_pag_detpag_vPag ,
    infNFe_pag_detpag_card_tpIntegra,
    infNFe_pag_detpag_card_CNPJ,
    infNFe_pag_detpag_card_tBand,
    infNFe_pag_detpag_card_cAut,
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
