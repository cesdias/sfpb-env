-- change database and user
\connect datalake datalakeuser

-- update permissions
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
