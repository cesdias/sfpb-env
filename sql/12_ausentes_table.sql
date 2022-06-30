-- change database and user
\connect datalake datalakeuser

-- TODO: documentar razão da tabela
CREATE TABLE app.ausentes (
	chave_de_acesso varchar(256) NULL,
	data_de_emissao varchar(256) NULL,
	valor_total_da_nota varchar(256) NULL,
	tipodocumentofiscal varchar(256) NULL
);