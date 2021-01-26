/*-- change database and user
\connect datalake datalakeuser

-- Cria tabela de sugestão
CREATE TABLE app.suggestion AS SELECT DISTINCT infnfe_det_prod_xprod
FROM app.fatoitemnfe
GROUP BY infnfe_det_prod_xprod
HAVING COUNT(*) >= 50;

-- Cria índice para tabela de sugestão
CREATE INDEX xprod_suggest_idx ON app.suggestion USING GIN (infnfe_det_prod_xprod gin_trgm_ops);

CREATE FUNCTION  app.query_suggestion_trgm(word_search varchar) RETURNS SETOF app.search AS $$
	SELECT infnfe_det_prod_xprod
	FROM app.suggestion
	WHERE word_search <% infnfe_det_prod_xprod
	GROUP BY infnfe_det_prod_xprod
	ORDER BY count desc;
$$  LANGUAGE sql STABLE;*/
