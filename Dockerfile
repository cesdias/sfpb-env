FROM cesdias/postgres-anon:1.2
COPY ./sql/ambiente.sql /docker-entrypoint-initdb.d
COPY ./sql/refresh_materialized_views.sql /docker-entrypoint-initdb.d
COPY ./data/app_efd-2020_09_17.sql /docker-entrypoint-initdb.d
COPY ./data/app_fatonfe-2020_09_17.sql /docker-entrypoint-initdb.d
COPY ./data/app_fatoitemnfe-2020_09_17.sql /docker-entrypoint-initdb.d

