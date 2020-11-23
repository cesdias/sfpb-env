--Create FTS search
--Chama pacote para o índice do dicionário
CREATE EXTENSION pg_trgm;

--Cria tabela dicionário
CREATE TABLE app.words AS SELECT word FROM
   ts_stat('SELECT to_tsvector(''simple'', infnfe_det_prod_xprod) FROM appmask.fatoitemnfe');

--Cria índice no dicionário
CREATE INDEX words_idx ON app.words USING GIN (word gin_trgm_ops);

--Cria índice na tabela fatoitemnfe
CREATE INDEX idx_exemplo ON appmask.fatoitemnfe USING GIN (to_tsvector('portuguese', infnfe_det_prod_xprod));

--CRIA TABELA PARA BUSCA
CREATE TABLE app.search (
    infnfe_det_prod_xprod VARCHAR,
    frequency text
);

--Cria função para busca (Talvez precise mudar o RETURN TABLE AS para RETURN SETOF <tipo_de_Tabela> AS)
CREATE FUNCTION  app.query_fts(word_search varchar) RETURNS SETOF app.search AS $$
    SELECT appmask.fatoitemnfe.infnfe_det_prod_xprod, COUNT(*)
    FROM appmask.fatoitemnfe, app.words
    WHERE word ILIKE  '%' || word_Search || '%' and to_tsvector('portuguese', appmask.fatoitemnfe.infnfe_det_prod_xprod) @@ to_tsquery('portuguese', word)
    GROUP BY appmask.fatoitemnfe.infnfe_det_prod_xprod
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