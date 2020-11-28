-- Cria tabela de sugestão
CREATE TABLE app.suggestion AS SELECT DISTINCT infnfe_det_prod_xprod, infnfe_det_prod_cean
FROM app.fatoitemnfe
GROUP BY infnfe_det_prod_xprod, infnfe_det_prod_cean
HAVING COUNT(*) >= 50;

-- Cria dicionário para tabela de sugestão
CREATE TABLE app.suggestion_words AS SELECT word FROM
   ts_stat('SELECT to_tsvector(''simple'', infnfe_det_prod_xprod) FROM app.suggestion');


-- Cria índice para dicionário de sugestão
CREATE INDEX words_idx_suggestion ON app.suggestion_words USING GIN (word gin_trgm_ops);


-- Cria índice para tabela de sugestão
CREATE INDEX idx_suggestion ON app.suggestion USING GIN (to_tsvector('portuguese', infnfe_det_prod_xprod));

-- Cria tabela para formar busca no hasura
CREATE TABLE app.search_suggestion (
    infnfe_det_prod_xprod VARCHAR,
    infnfe_det_prod_cean VARCHAR
);

-- Cria Função para fts na tabela de sugestão
CREATE FUNCTION  app.query_suggestion_fts(word_search varchar) RETURNS SETOF app.search_suggestion AS $$
    SELECT app.suggestion.infnfe_det_prod_xprod, app.suggestion.infnfe_det_prod_cean
    FROM app.suggestion, app.suggestion_words
    WHERE word ILIKE  '%' || word_search || '%' and to_tsvector('portuguese', app.suggestion.infnfe_det_prod_xprod) @@ to_tsquery('portuguese', word)
    GROUP BY app.suggestion.infnfe_det_prod_xprod, app.suggestion.infnfe_det_prod_cean
$$  LANGUAGE sql STABLE;
