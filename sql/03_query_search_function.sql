--Create FTS search

-- change database and user
\connect datalake postgres

--Chama pacote para o índice do dicionário
CREATE EXTENSION pg_trgm;

-- change database and user
\connect datalake datalakeuser


--Cria índice na tabela fatoitemnfe
CREATE INDEX fatoitemnfe_infnfe_det_prod_xprod_fts_idx ON app.fatoitemnfe USING GIN (to_tsvector('portuguese', infnfe_det_prod_xprod));

--CRIA TABELA PARA BUSCA
CREATE TABLE app.search (
    infnfe_det_prod_xprod VARCHAR,
    frequency int
);

--Cria função para busca fts
CREATE OR REPLACE FUNCTION app.query_fts(search text)
 RETURNS SETOF app.fatoitemnfe
 LANGUAGE sql
 STABLE
AS $function$
    SELECT *
    FROM app.fatoitemnfe
    WHERE
      to_tsvector('portuguese'::regconfig, infnfe_det_prod_xprod) @@ to_tsquery('portuguese'::regconfig, search)
$function$
;


CREATE VIEW app.capa_item_view AS
SELECT *
FROM app.fatoitemnfe as a INNER JOIN app.fatonfe as b using(infprot_chnfe);

--Cria função para busca fts (campos do item e capa da nota)
CREATE OR REPLACE FUNCTION app.query_fts_capa(search text)
 RETURNS SETOF app.capa_item_view
 LANGUAGE sql
 STABLE
AS $function$
    SELECT *
    FROM app.fatoitemnfe INNER JOIN app.fatonfe using(infprot_chnfe)
    WHERE
      to_tsvector('portuguese'::regconfig, infnfe_det_prod_xprod) @@ to_tsquery('portuguese'::regconfig, search);

$function$
;

--Concede permissões de acesso
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
