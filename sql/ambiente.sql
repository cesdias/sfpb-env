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
    "id" INT,
    "nomecoluna" TEXT,
    "tipodado" TEXT,
    "descricao" TEXT,
    "anonimizacao" INT,
    "observacao" INT,
    "grupo" INT,
    "tabela" TEXT
);
INSERT INTO app.label VALUES
  (0,'infNFe_ide_cUF','char(2)','Código da UF do emitente do Documento Fiscal. Utilizar a Tabela do IBGE.',NULL,NULL,NULL,'fatonfe'),
  (1,'infNFe_ide_cNF','character varying(44)','Código numérico que compõe a Chave de Acesso. Número aleatório gerado pelo emitente para cada NF-e.',NULL,NULL,NULL,'fatonfe'),
  (2,'infNFe_ide_natOp','character varying(60)','Descrição da Natureza da Operação',NULL,NULL,NULL,'fatonfe'),
  (3,'infNFe_ide_mod','integer','Código do modelo do Documento Fiscal. 55 = NF-e 65 = NFC-e.',NULL,NULL,NULL,'fatonfe'),
  (4,'infNFe_ide_serie','character varying','Série do Documento Fiscalsérie normal 0-889Avulsa Fisco 890-899SCAN 900-999',NULL,NULL,NULL,'fatonfe'),
  (5,'infNFe_ide_nNF','character varying','Número do Documento Fiscal',NULL,NULL,NULL,'fatonfe'),
  (6,'infNFe_ide_dhEmi','timestamp without time zone','Data e Hora de emissão do Documento Fiscal (AAAA-MM-DDThh:mm:ssTZD) ex.: 2012-09-01T13:00:00-03:00',NULL,NULL,NULL,'fatonfe'),
  (7,'infNFe_ide_tpNF','char','Tipo do Documento Fiscal (0 - entrada 1 - saída)',NULL,NULL,NULL,'fatonfe'),
  (8,'infNFe_ide_idDest','char','Identificador de Local de destino da operação (1-Interna 2-Interestadual 3-Exterior)',NULL,NULL,NULL,'fatonfe'),
  (9,'infNFe_ide_cMunFG','character varying(40)','Código do Município de Ocorrência do Fato Gerador (utilizar a tabela do IBGE)',NULL,NULL,NULL,'fatonfe'),
  (10,'infNFe_ide_tpImp','char','Formato de impressão do DANFE (0-sem DANFE 1-DANFe Retrato 2-DANFe Paisagem 3-DANFe Simplificado 4-DANFe NFC-e 5-DANFe NFC-e em mensagem eletrônica)',NULL,NULL,NULL,'fatonfe'),
  (11,'infNFe_ide_tpEmis','char','Forma de emissão da NF-e 1 - Normal 2 - Contingência FS 3 - Contingência SCAN 4 - Contingência DPEC 5 - Contingência FSDA 6 - Contingência SVC - AN 7 - Contingência SVC - RS 9 - Contingência off-line NFC-e',NULL,NULL,NULL,'fatonfe'),
  (12,'infNFe_ide_cDV','integer','Digito Verificador da Chave de Acesso da NF-e',NULL,NULL,NULL,'fatonfe'),
  (13,'infNFe_ide_tpAmb','char','Identificação do Ambiente: 1 - Produção2 - Homologação',NULL,NULL,NULL,'fatonfe'),
  (14,'infNFe_ide_finNFe','char(2)','Finalidade da emissão da NF-e: 1 - NFe normal 2 - NFe complementar 3 - NFe de ajuste 4 - Devolução/Retorno',NULL,NULL,NULL,'fatonfe'),
  (15,'infNFe_ide_indFinal','char','Indica operação com consumidor final (0-Não 1-Consumidor Final)',NULL,NULL,NULL,'fatonfe'),
  (16,'infNFe_ide_indPres','char','Indicador de presença do comprador no estabelecimento comercial no momento da oepração(0-Não se aplica (ex.: Nota Fiscal complementar ou de ajuste 1-Operação presencial 2-Não presencial, internet 3-Não presencial, teleatendimento 4-NFC-e entrega em domicílio 5-Operação presencial, fora do estabelecimento 9-Não presencial, outros)',NULL,NULL,NULL,'fatonfe'),
  (17,'infNFe_ide_procEmi','char','Processo de emissão utilizado com a seguinte codificação:0 - emissão de NF-e com aplicativo do contribuinte 1 - emissão de NF-e avulsa pelo Fisco 2 - emissão de NF-e avulsa, pelo contribuinte com seu certificado digital, através do sitedo Fisco 3- emissão de NF-e pelo contribuinte com aplicativo fornecido pelo Fisco.',NULL,NULL,NULL,'fatonfe'),
  (18,'infNFe_ide_verProc','character varying(30)','versão do aplicativo utilizado no processo deemissão',NULL,NULL,NULL,'fatonfe'),
  (19,'infNFe_emit_CNPJ','char(14)','Número do CNPJ do emitente',NULL,NULL,NULL,'fatonfe'),
  (20,'infNFe_emit_CPF','char(12)','Número do CPF do emitente',NULL,NULL,NULL,'fatonfe'),
  (21,'infNFe_emit_xNome','character varying(100)','Razão Social ou Nome do emitente',NULL,NULL,NULL,'fatonfe'),
  (22,'infNFe_emit_xFant','character varying(100)','Nome fantasia',NULL,NULL,NULL,'fatonfe'),
  (23,'infNFe_emit_enderEmit_xLgr','character varying(100)','Logradouro',NULL,NULL,NULL,'fatonfe'),
  (24,'infNFe_emit_enderEmit_nro','character varying(40)','Número',NULL,NULL,NULL,'fatonfe'),
  (25,'infNFe_emit_enderEmit_xCpl','character varying(60)','Complemento',NULL,NULL,NULL,'fatonfe'),
  (26,'infNFe_emit_enderEmit_xBairro','character varying(60)','Bairro',NULL,NULL,NULL,'fatonfe'),
  (27,'infNFe_emit_enderEmit_cMun','character varying(11)','Código do município',NULL,NULL,NULL,'fatonfe'),
  (28,'infNFe_emit_enderEmit_xMun','character varying(60)','Nome do município',NULL,NULL,NULL,'fatonfe'),
  (29,'infNFe_emit_enderEmit_UF','char(2)','Sigla da UF',NULL,NULL,NULL,'fatonfe'),
  (30,'infNFe_emit_enderEmit_CEP','character varying(40)','CEP - NT 2011/004',NULL,NULL,NULL,'fatonfe'),
  (31,'infNFe_emit_enderEmit_cPais','character varying(6)','Código do país',NULL,NULL,NULL,'fatonfe'),
  (32,'infNFe_emit_enderEmit_xPais','character varying(44)','Nome do país',NULL,NULL,NULL,'fatonfe'),
  (33,'infNFe_emit_enderEmit_fone','character varying(12)','Preencher com Código DDD + número do telefone (v.2.0)',NULL,NULL,NULL,'fatonfe'),
  (34,'infNFe_emit_IE','character varying(14)','Inscrição Estadual do Emitente',NULL,NULL,NULL,'fatonfe'),
  (35,'infNFe_emit_IEST','character varying(14)','Inscricao Estadual do Substituto Tributário',NULL,NULL,NULL,'fatonfe'),
  (36,'infNFe_emit_IM','character varying(15)','Inscrição Municipal',NULL,NULL,NULL,'fatonfe'),
  (37,'infNFe_emit_CNAE','character varying(40)','CNAE Fiscal',NULL,NULL,NULL,'fatonfe'),
  (38,'infNFe_emit_CRT','character varying(2)','Código de Regime Tributário. Este campo será obrigatoriamente preenchido com: 1 – Simples Nacional 2 – Simples Nacional – excesso de sublimite de receita bruta 3 – Regime Normal.',NULL,NULL,NULL,'fatonfe'),
  (39,'infNFe_dest_CNPJ','char(14)','Número do CNPJ',NULL,NULL,NULL,'fatonfe'),
  (40,'infNFe_dest_CPF','char(12)','Número do CPF',NULL,NULL,NULL,'fatonfe'),
  (41,'infNFe_dest_idEstrangeiro','character varying(20)','Identificador do destinatário, em caso de comprador estrangeiro',NULL,NULL,NULL,'fatonfe'),
  (42,'infNFe_dest_xNome','character varying(100)','Razão Social ou nome do destinatário',NULL,NULL,NULL,'fatonfe'),
  (43,'infNFe_dest_enderDest_xLgr','character varying(100)','Logradouro',NULL,NULL,NULL,'fatonfe'),
  (44,'infNFe_dest_enderDest_nro','character varying(40)','Número',NULL,NULL,NULL,'fatonfe'),
  (45,'infNFe_dest_enderDest_xCpl','character varying(60)','Complemento',NULL,NULL,NULL,'fatonfe'),
  (46,'infNFe_dest_enderDest_xBairro','character varying(60)','Bairro',NULL,NULL,NULL,'fatonfe'),
  (47,'infNFe_dest_enderDest_cMun','character varying(11)','Código do município (utilizar a tabela do IBGE), informar 9999999 para operações com o exterior.',NULL,NULL,NULL,'fatonfe'),
  (48,'infNFe_dest_enderDest_xMun','character varying(60)','Nome do município, informar EXTERIOR para operações com o exterior.',NULL,NULL,NULL,'fatonfe'),
  (49,'infNFe_dest_enderDest_UF','char(2)','Sigla da UF, informar EX para operações com o exterior.',NULL,NULL,NULL,'fatonfe'),
  (50,'infNFe_dest_enderDest_CEP','character varying(40)','CEP',NULL,NULL,NULL,'fatonfe'),
  (51,'infNFe_dest_enderDest_cPais','character varying(6)','Código de Pais',NULL,NULL,NULL,'fatonfe'),
  (52,'infNFe_dest_enderDest_xPais','character varying(54)','Nome do país',NULL,NULL,NULL,'fatonfe'),
  (53,'infNFe_dest_enderDest_fone','character varying(12)','Preencher com Código DDD + número do telefone (v.2.0)',NULL,NULL,NULL,'fatonfe'),
  (54,'infNFe_dest_indIEDest','char','Indicador da IE do destinatário:1 – Contribuinte ICMS pagamento à vista 2 – Contribuinte isento de inscrição 9 – Não Contribuinte',NULL,NULL,NULL,'fatonfe'),
  (55,'infNFe_dest_IE','character varying(14)','Inscrição Estadual (obrigatório nas operações com contribuintes do ICMS)',NULL,NULL,NULL,'fatonfe'),
  (56,'infNFe_dest_ISUF','character varying(20)','Inscrição na SUFRAMA (Obrigatório nas operações com as áreas com benefícios de incentivos fiscais sob controle da SUFRAMA) PL_005d - 11/08/09 - alterado para aceitar 8 ou 9 dígitos',NULL,NULL,NULL,'fatonfe'),
  (57,'infNFe_dest_IM','character varying(20)','Inscrição Municipal do tomador do serviço',NULL,NULL,NULL,'fatonfe'),
  (58,'infNFe_dest_email','character varying(60)','Informar o e-mail do destinatário. O campo pode ser utilizado para informar o e-mailde recepção da NF-e indicada pelo destinatário',NULL,NULL,NULL,'fatonfe'),
  (59,'infNFe_total_ICMSTot_vBC','numeric','BC do ICMS',NULL,NULL,NULL,'fatonfe'),
  (60,'infNFe_total_ICMSTot_vICMS','numeric','Valor Total do ICMS',NULL,NULL,NULL,'fatonfe'),
  (61,'infNFe_total_ICMSTot_vICMSDeson','numeric','Valor Total do ICMS desonerado',NULL,NULL,NULL,'fatonfe'),
  (62,'infNFe_total_ICMSTot_vST','numeric','Valor Total do ICMS ST',NULL,NULL,NULL,'fatonfe'),
  (63,'infNFe_total_ICMSTot_vProd','numeric','Valor Total dos produtos e serviços',NULL,NULL,NULL,'fatonfe'),
  (64,'infNFe_total_ICMSTot_vFrete','numeric','Valor Total do Frete',NULL,NULL,NULL,'fatonfe'),
  (65,'infNFe_total_ICMSTot_vSeg','numeric','Valor Total do Seguro',NULL,NULL,NULL,'fatonfe'),
  (66,'infNFe_total_ICMSTot_vDesc','numeric','Valor Total do Desconto',NULL,NULL,NULL,'fatonfe'),
  (67,'infNFe_total_ICMSTot_vII','numeric','Valor Total do II',NULL,NULL,NULL,'fatonfe'),
  (68,'infNFe_total_ICMSTot_vIPI','numeric','Valor Total do IPI',NULL,NULL,NULL,'fatonfe'),
  (69,'infNFe_total_ICMSTot_vPIS','numeric','Valor do PIS',NULL,NULL,NULL,'fatonfe'),
  (70,'infNFe_total_ICMSTot_vCOFINS','numeric','Valor do COFINS',NULL,NULL,NULL,'fatonfe'),
  (71,'infNFe_total_ICMSTot_vOutro','numeric','Outras Despesas acessórias',NULL,NULL,NULL,'fatonfe'),
  (72,'infNFe_total_ICMSTot_vNF','numeric','Valor Total da NF-e',NULL,NULL,NULL,'fatonfe'),
  (73,'infNFe_det_nItem','int','Dados dos detalhes da NF-e',NULL,NULL,NULL,'fatoitemnfe'),
  (74,'infNFe_det_prod_cProd','character varying(30)','Código do produto ou serviço. Preencher com CFOP caso se trate de itens não relacionados com mercadorias/produto e que o contribuinte não possua codificação própriaFormato ”CFOP9999”.',NULL,NULL,NULL,'fatoitemnfe'),
  (75,'infNFe_det_prod_cEAN','character varying(100)','GTIN (Global Trade Item Number) do produto, antigo código EAN ou código de barras',NULL,NULL,NULL,'fatoitemnfe'),
  (76,'infNFe_det_prod_xProd','character varying(200)','Descrição do produto ou serviço',NULL,NULL,NULL,'fatoitemnfe'),
  (77,'infNFe_det_prod_NCM','char(8)','Código NCM (8 posições), será permitida a informação do gênero (posição do capítulo do NCM) quando a operação não for de comércio exterior (importação/exportação) ou o produto não seja tributado pelo IPI. Em caso de item de serviço ou item que não tenham produto (Ex. transferência de crédito, crédito do ativo imobilizado, etc.), informar o código 00 (zeros) (v2.0)',NULL,NULL,NULL,'fatoitemnfe'),
  (78,'infNFe_det_prod_CFOP','int','Cfop',NULL,NULL,NULL,'fatoitemnfe'),
  (79,'infNFe_det_prod_uCom','character varying(40)','Unidade comercial',NULL,NULL,NULL,'fatoitemnfe'),
  (80,'infNFe_det_prod_qCom','float','Quantidade Comercial  do produto, alterado para aceitar de 0 a 4 casas decimais e 11 inteiros.',NULL,NULL,NULL,'fatoitemnfe'),
  (81,'infNFe_det_prod_vUnCom','NUMERIC(16,2)','Valor unitário de comercialização  - alterado para aceitar 0 a 10 casas decimais e 11 inteiros',NULL,NULL,NULL,'fatoitemnfe'),
  (82,'infNFe_det_prod_vProd','NUMERIC(16,2)','Valor bruto do produto ou serviço.',NULL,NULL,NULL,'fatoitemnfe'),
  (83,'infNFe_det_prod_cEANTrib','character varying(100)','GTIN (Global Trade Item Number) da unidade tributável, antigo código EAN ou código de barras',NULL,NULL,NULL,'fatoitemnfe'),
  (84,'infNFe_det_prod_uTrib','character varying(20)','Unidade Tributável',NULL,NULL,NULL,'fatoitemnfe'),
  (85,'infNFe_det_prod_qTrib','float','Quantidade Tributável - alterado para aceitar de 0 a 4 casas decimais e 11 inteiros',NULL,NULL,NULL,'fatoitemnfe'),
  (86,'infNFe_det_prod_vUnTrib','NUMERIC(16,2)','Valor unitário de tributação - - alterado para aceitar 0 a 10 casas decimais e 11 inteiros',NULL,NULL,NULL,'fatoitemnfe'),
  (87,'infNFe_det_prod_vDesc','NUMERIC(16,2)','Valor do Desconto',NULL,NULL,NULL,'fatoitemnfe'),
  (88,'infNFe_det_prod_indTot','int','Este campo deverá ser preenchido com: 0 – o valor do item (vProd) não compõe o valor total da NF-e (vProd) 1  – o valor do item (vProd) compõe o valor total da NF-e (vProd)',NULL,NULL,NULL,'fatoitemnfe'),
  (89,'infNFe_det_imposto_vTotTrib','numeric(16,2)','Valor estimado total de impostos federais, estaduais e municipais',NULL,NULL,NULL,'fatoitemnfe'),
  (90,'infNFe_det_imposto_ICMS_ICMS00_orig','int','origem da mercadoria: 0 - Nacional 1 - Estrangeira - Importação direta 2 - Estrangeira - Adquirida no mercado interno',NULL,NULL,NULL,'fatoitemnfe'),
  (91,'infNFe_det_imposto_ICMS_ICMS00_CST','char(2)','Tributção pelo ICMS00 - Tributada integralmente',NULL,NULL,NULL,'fatoitemnfe'),
  (92,'infNFe_det_imposto_ICMS_ICMS00_modBC','int','Modalidade de determinação da BC do ICMS: 0 - Margem Valor Agregado (%) 1 - Pauta (valor)        2 - Preço Tabelado Máximo (valor)        3 - Valor da Operação.        ',NULL,NULL,NULL,'fatoitemnfe'),
  (93,'infNFe_det_imposto_ICMS_ICMS00_vBC','numeric(16,2)','Valor da BC do ICMS',NULL,NULL,NULL,'fatoitemnfe'),
  (94,'infNFe_det_imposto_ICMS_ICMS00_pICMS','numeric(16,2)','Alíquota do ICMS',NULL,NULL,NULL,'fatoitemnfe'),
  (95,'infNFe_det_imposto_ICMS_ICMS00_vICMS','numeric(16,2)','Valor do ICMS',NULL,NULL,NULL,'fatoitemnfe'),
  (96,'infProt_chNFe','character varying(44)','Chaves de acesso da NF-e, compostas por: UF do emitente, AAMM da emissão da NFe, CNPJ do emitente, modelo, série e número da NF-e e código numérico+DV',NULL,NULL,NULL,'fatonfe')
  ;

CREATE UNLOGGED TABLE app.fatonfe(
  infProt_chNFe character varying(44) PRIMARY KEY,
	infNFe_ide character varying(100),
	infNFe_ide_cUF char(2),
	infNFe_ide_cNF character varying(54),
	infNFe_ide_natOp character varying(60),
	infNFe_ide_mod integer,
	infNFe_ide_serie character varying,
	infNFe_ide_nNF character varying,
	infNFe_ide_dhEmi timestamp with time zone,
  infNFe_ide_dhSaiEnt timestamp with time zone,
	infNFe_ide_tpNF char,
	infNFe_ide_idDest char,
	infNFe_ide_cMunFG character varying(40),
	infNFe_ide_tpImp char,
	infNFe_ide_tpEmis char,
	infNFe_ide_cDV integer,
	infNFe_ide_tpAmb char,
	infNFe_ide_finNFe char(2),
	infNFe_ide_indFinal char,
	infNFe_ide_indPres char,
	infNFe_ide_procEmi char,
	infNFe_ide_verProc character varying(30),
	infNFe_emit_CNPJ char(14),
	infNFe_emit_CPF char(12),
	infNFe_emit_xNome character varying(100),
	infNFe_emit_xFant character varying(100),
	infNFe_emit_enderEmit_xLgr character varying(100),
	infNFe_emit_enderEmit_nro character varying(40),
	infNFe_emit_enderEmit_xCpl character varying(60),
	infNFe_emit_enderEmit_xBairro character varying(60),
	infNFe_emit_enderEmit_cMun character varying(11),
	infNFe_emit_enderEmit_xMun character varying(60),
	infNFe_emit_enderEmit_UF char(2),
	infNFe_emit_enderEmit_CEP character varying(40),
	infNFe_emit_enderEmit_cPais character varying(6),
	infNFe_emit_enderEmit_xPais character varying(54),
	infNFe_emit_enderEmit_fone character varying(12),
	infNFe_emit_IE character varying(14),
	infNFe_emit_IEST character varying(14),
	infNFe_emit_IM character varying(15),
	infNFe_emit_CNAE character varying(40),
	infNFe_emit_CRT character varying(2),
	infNFe_dest_CNPJ char(14),
	infNFe_dest_CPF char(12),
	infNFe_dest_idEstrangeiro character varying(20),
	infNFe_dest_xNome character varying(100),
	infNFe_dest_enderDest_xLgr character varying(100),
	infNFe_dest_enderDest_nro character varying(40),
	infNFe_dest_enderDest_xCpl character varying(60),
	infNFe_dest_enderDest_xBairro character varying(60),
	infNFe_dest_enderDest_cMun character varying(11),
	infNFe_dest_enderDest_xMun character varying(60),
	infNFe_dest_enderDest_UF char(2),
	infNFe_dest_enderDest_CEP character varying(40),
	infNFe_dest_enderDest_cPais character varying(6),
	infNFe_dest_enderDest_xPais character varying(54),
	infNFe_dest_enderDest_fone character varying(12),
	infNFe_dest_indIEDest char,
	infNFe_dest_IE character varying(14),
	infNFe_dest_ISUF character varying(20),
	infNFe_dest_IM character varying(20),
	infNFe_dest_email character varying(60),
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

CREATE UNLOGGED TABLE app.fatoitemnfe(
	id BIGSERIAL PRIMARY KEY,
	infProt_chNFe character varying(44),
	infNFe_det_nItem int,
	infNFe_det_prod_cProd character varying(30),
	infNFe_det_prod_cEAN character varying(100),
	infNFe_det_prod_xProd character varying(200),
	infNFe_det_prod_NCM char(8),
	infNFe_det_prod_CFOP int,
	infNFe_det_prod_uCom character varying(10),
	infNFe_det_prod_qCom float,
	infNFe_det_prod_vUnCom NUMERIC(16,2),
	infNFe_det_prod_vProd NUMERIC(16,2),
	infNFe_det_prod_cEANTrib character varying(100),
	infNFe_det_prod_uTrib character varying(20),
	infNFe_det_prod_qTrib float,
	infNFe_det_prod_vUnTrib NUMERIC(16,2),
	infNFe_det_prod_vDesc NUMERIC(16,2),
	infNFe_det_prod_indTot int,
	infNFe_det_imposto_vTotTrib numeric(16,2),
	infNFe_det_imposto_ICMS_ICMS00_orig int,
	infNFe_det_imposto_ICMS_ICMS00_CST char(2),
	infNFe_det_imposto_ICMS_ICMS00_modBC int,
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
