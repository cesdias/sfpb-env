--Create FTS search

-- change database and user
\connect datalake postgres

--Chama pacote para o índice do dicionário
CREATE EXTENSION pg_trgm;

-- change database and user
\connect datalake datalakeuser


--Cria índice na tabela fatoitemnfe
CREATE INDEX idx_exemplo ON app.fatoitemnfe USING GIN (to_tsvector('portuguese', infnfe_det_prod_xprod));

--CRIA TABELA PARA BUSCA
CREATE TABLE app.search (
    infnfe_det_prod_xprod VARCHAR,
    frequency int
);

--Cria função para busca fts
CREATE FUNCTION app.query_fts(search text)
RETURNS SETOF app.fatoitemnfe AS $$
    SELECT *
    FROM app.fatoitemnfe
    WHERE
      infnfe_det_prod_xprod @@ to_tsquery(search)
$$ LANGUAGE sql STABLE;

-- Busca de Trigrama na tabela de sugestão
CREATE INDEX xprod_idx ON app.fatoitemnfe USING GIN (infnfe_det_prod_xprod gin_trgm_ops);

CREATE FUNCTION  app.query_trgm(word_search varchar) RETURNS SETOF app.search AS $$
	SELECT infnfe_det_prod_xprod, COUNT(*)
	FROM app.fatoitemnfe
	WHERE word_search <% infnfe_det_prod_xprod
	GROUP BY infnfe_det_prod_xprod
	ORDER BY count desc;
$$  LANGUAGE sql STABLE;

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