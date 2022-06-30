-- change database and user
\connect datalake datalakeuser

-- TODO: documentar razão da tabela
CREATE TABLE app.eventos_mdfe (
	id_evento bigserial NOT NULL,
	chave_mdfe varchar(44) NULL
);
CREATE INDEX eventos_mdfe_chave_mdfe_idx ON app.eventos_mdfe USING btree (chave_mdfe);
CREATE INDEX eventos_mdfe_id_evento_idx ON app.eventos_mdfe USING btree (id_evento);