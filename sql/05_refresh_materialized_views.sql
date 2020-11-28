-- change database and user
\connect datalake datalakeuser

REFRESH MATERIALIZED VIEW appmask.fatonfe;
REFRESH MATERIALIZED VIEW appmask.fatoitemnfe;
