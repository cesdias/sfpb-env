FROM cesdias/postgres-anon-tds_fdw:1.1
COPY ./sql/ambiente.sql /docker-entrypoint-initdb.d
COPY ./sql/refresh_materialized_views.sql /docker-entrypoint-initdb.d
COPY ./data/app_label-2020_07_22.sql /docker-entrypoint-initdb.d
COPY ./data/app_fatonfe-2020_07_30.sql /docker-entrypoint-initdb.d
COPY ./data/app_fatoitemnfe-2020_07_22.sql /docker-entrypoint-initdb.d
