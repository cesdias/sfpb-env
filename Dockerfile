FROM cesdias/postgres13-anon:1.0
COPY ./sql/01_ambiente.sql /docker-entrypoint-initdb.d
COPY ./sql/02_custom_queries_table.sql /docker-entrypoint-initdb.d
COPY ./sql/03_query_search_function.sql /docker-entrypoint-initdb.d
COPY ./sql/04_suggestion_table.sql /docker-entrypoint-initdb.d
COPY ./sql/05_refresh_materialized_views.sql /docker-entrypoint-initdb.d
COPY ./data/app_efd-2020_09_17.sql /docker-entrypoint-initdb.d
COPY ./data/app_fatonfe-2020_09_17.sql /docker-entrypoint-initdb.d
COPY ./data/app_fatoitemnfe-2020_09_17.sql /docker-entrypoint-initdb.d
