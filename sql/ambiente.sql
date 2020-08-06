-- Datalake - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/datalake

-- user
CREATE USER datalakeuser WITH PASSWORD 'EQuohG2i';

-- database
CREATE DATABASE datalake;

-- privileges and permissions
REVOKE ALL ON DATABASE datalake FROM public;
ALTER DATABASE datalake OWNER TO datalakeuser;
GRANT CONNECT ON DATABASE datalake to datalakeuser;
ALTER ROLE datalakeuser SET search_path TO public,app,appmask;

-- change database and user
\connect datalake datalakeuser

-- schemas
CREATE SCHEMA app;
CREATE SCHEMA appmask;

-- tables
CREATE TABLE app.label (
    id bigint NOT NULL,
    nomecoluna character varying,
    tipodado character varying,
    descricao character varying,
    anonimizacao character varying,
    observacao character varying,
    grupo character varying,
    tabela character varying
);

CREATE TABLE app.fatonfe (
    id bigint NOT NULL,
    sqnfe bigint NOT NULL,
    tpnfe integer,
    idemitentecadastro integer,
    iddestinatariocadastro integer,
    idtransportadorcadastro integer,
    idcnaeemitente integer,
    idcnaedestinatario integer,
    idemitentenfe integer,
    iddestinatarionfe integer,
    idtransportadornfe integer,
    idstnfe character varying(2),
    idtpnf integer,
    idcrtemit integer,
    iddest integer,
    idmod integer,
    idtpimp integer,
    idtpemis integer,
    idfinnfe integer,
    idindfinal integer,
    idindpres integer,
    idprocemi integer,
    dtinclusao date,
    dtemissao date,
    dhrecebimento timestamp(3) without time zone,
    chnfe character varying(44),
    versao character varying(4),
    cuf integer,
    natop character varying(60),
    serie integer,
    nnf integer,
    dhemi timestamp(3) without time zone,
    dhsaient timestamp(3) without time zone,
    cmunfg integer,
    cnpjentrega character varying(14),
    ufentrega character varying(2),
    vbc numeric(13,2),
    vicms numeric(13,2),
    vicmsdeson numeric(13,2),
    vfcpufdest numeric(13,2),
    vicmsufdest numeric(13,2),
    vicmsufremet numeric(13,2),
    vfcp numeric(13,2),
    vbcst numeric(13,2),
    vst numeric(13,2),
    vfcpst numeric(13,2),
    vfcpstret numeric(13,2),
    vprod numeric(13,2),
    vfrete numeric(13,2),
    vseg numeric(13,2),
    vdesc numeric(13,2),
    vii numeric(13,2),
    vipi numeric(13,2),
    vipidevol numeric(13,2),
    vpis numeric(13,2),
    vcofins numeric(13,2),
    voutro numeric(13,2),
    vnf numeric(13,2),
    vtottrib numeric(13,2),
    modfrete integer,
    vservtransp numeric(13,2),
    vbcrettransp numeric(13,2),
    picmsrettransp numeric(7,4),
    vicmsrettransp numeric(13,2),
    cfoptransp integer,
    cmunfgtransp integer,
    placaveic character varying(7),
    ufveic character varying(2),
    rntcveic character varying(20),
    nfat character varying(60),
    vorigfat numeric(13,2),
    vdescfat numeric(13,2),
    vliqfat numeric(13,2),
    infadfisco text,
    infcpl text,
    ufsaidapais character varying(3),
    xlocexporta character varying(60),
    xlocdespacho character varying(60),
    xnempcompras character varying(22),
    xpedcompras character varying(60),
    xcontcompras character varying(60),
    safra character varying(9),
    refcana character varying(7),
    "CNPJEmit" character varying(14),
    "xNomeEmit" character varying(100),
    "xFantEmit" character varying(100),
    "xLgrEmit" character varying(100),
    "nroEmit" character varying(100),
    "xCplEmit" character varying(100),
    "xBairroEmit" character varying(100),
    "cMunEmit" character varying(11),
    "xMunEmit" character varying(100),
    "UFEmit" character(2),
    "CEPEmit" character varying(10),
    "cPaisEmit" character varying(6),
    "xPaisEmit" character varying(100),
    "foneEmit" character varying(20),
    "IEEmit" character varying(14),
    "IESTEmit" character varying(14),
    "IMEmit" character varying(15),
    "CNAEEmit" character varying(10),
    "CRTEmit" character varying(2),
    "CPFEmit" character varying(12)

);

CREATE TABLE app.fatoitemnfe (
    id bigint NOT NULL,
    sqnfe bigint,
    nritemnfe integer,
    idstnfe character varying(2),
    idtpnfe integer,
    idufemit integer,
    idcrtemit integer,
    chnfe character varying(44),
    natop character varying(60),
    idmod integer,
    serie integer,
    nnf integer,
    dhemi timestamp(3) without time zone,
    dhsaient timestamp(3) without time zone,
    idtpoperacao integer,
    iddest integer,
    idmunfg integer,
    idfinnfe integer,
    idindfinal integer,
    idindpres integer,
    dtinclusao date,
    dtemissao date,
    idmodfrete integer,
    idemitentecadastro integer,
    iddestinatariocadastro integer,
    idtransportadorcadastro integer,
    idemitentenfe integer,
    iddestinatarionfe integer,
    idtransportadornfe integer,
    idcnaeemitente integer,
    idcnaedestinatario integer,
    idveiculo integer,
    idcombustivel integer,
    versao character varying(4),
    cprod character varying(60),
    idcean character varying(14),
    xprod character varying(200),
    ncm character varying(8),
    cest character varying(7),
    indescala character varying(1),
    cnpjfab character varying(14),
    cbenef character varying(10),
    extipi character varying(3),
    cfop character varying(4),
    ucom character varying(6),
    qcom numeric(15,4),
    vuncom numeric(21,10),
    vprod numeric(13,2),
    idceantrib character varying(14),
    utrib character varying(6),
    qtrib numeric(15,4),
    vuntrib numeric(21,10),
    vfrete numeric(13,2),
    vseg numeric(13,2),
    vdesc numeric(13,2),
    voutro numeric(13,2),
    idindtot character varying(1),
    cprodanvisa character varying(13),
    xmotivoisencao character varying(255),
    vpmc numeric(13,2),
    idorig integer,
    idcst integer,
    idmodbc integer,
    vbc numeric(13,2),
    picms numeric(8,4),
    vicms numeric(13,2),
    pfcp numeric(8,4),
    vfcp numeric(13,2),
    vbcfcp numeric(13,2),
    idmodbcst integer,
    pmvast numeric(8,4),
    predbcst numeric(8,4),
    vbcst numeric(13,2),
    picmsst numeric(8,4),
    vicmsst numeric(13,2),
    vbcfcpst numeric(13,2),
    pfcpst numeric(8,4),
    vfcpst numeric(13,2),
    predbc numeric(8,4),
    vicmsdeson numeric(13,2),
    idmotdesicms integer,
    vicmsop numeric(13,2),
    pdif numeric(8,4),
    vicmsdif numeric(13,2),
    vbcstret numeric(13,2),
    pst numeric(8,4),
    vicmssubstituto numeric(13,2),
    vicmsstret numeric(13,2),
    vbcfcpstret numeric(13,2),
    pfcpstret numeric(8,4),
    vfcpstret numeric(13,2),
    predbcefet numeric(8,4),
    vbcefet numeric(13,2),
    picmsefet numeric(8,4),
    vicmsefet numeric(13,2),
    idorigicmspart integer,
    idcsticmspart integer,
    idmodbcicmspart integer,
    vbcicmspart numeric(13,2),
    predbcicmspart numeric(8,4),
    picmsicmspart numeric(8,4),
    vicmsicmspart numeric(13,2),
    idmodbcsticmspart integer,
    pmvasticmspart numeric(8,4),
    predbcsticmspart numeric(8,4),
    vbcsticmspart numeric(13,2),
    picmssticmspart numeric(8,4),
    vicmssticmspart numeric(13,2),
    pbcopicmspart numeric(8,4),
    ufsticmspart character varying(2),
    idorigrepassest integer,
    idcstrepassest integer,
    vbcstretrepassest numeric(13,2),
    pstrepassest numeric(8,4),
    vicmssubstitutorepassest numeric(13,2),
    vicmsstretrepassest numeric(13,2),
    vbcfcpstretrepassest numeric(13,2),
    pfcpstretrepassest numeric(8,4),
    vfcpstretrepassest numeric(13,2),
    vbcstdestrepassest numeric(13,2),
    vicmsstdestrepassest numeric(13,2),
    predbcefetrepassest numeric(8,4),
    vbcefetrepassest numeric(13,2),
    picmsefetrepassest numeric(8,4),
    vicmsefetrepassest numeric(13,2),
    idorigcrt integer,
    csosn character varying(3),
    pcredsncrt numeric(8,4),
    vcredicmssncrt numeric(13,2),
    idmodbcstcrt integer,
    pmvasticmscrt numeric(8,4),
    predbcstcrt numeric(8,4),
    picmsstcrt numeric(8,4),
    vicmsstcrt numeric(13,2),
    vbcfcpstcrt numeric(13,2),
    pfcpstcrt numeric(8,4),
    vfcpstcrt numeric(13,2),
    vbcstretcrt numeric(13,2),
    vicmsstretcrt numeric(13,2),
    vbcstcrt numeric(13,2),
    vtottribgm numeric(13,2),
    vbcufdest numeric(13,2),
    vbcfcpufdest numeric(13,2),
    pfcpufdest numeric(8,4),
    picmsufdest numeric(8,4),
    picmsinter numeric(8,4),
    picmsinterpart numeric(8,4),
    vfcpufdestgna numeric(13,2),
    vicmsufdestgna numeric(13,2),
    vicmsufremetgna numeric(13,2),
    xped character varying(60),
    nitemped character varying(6),
    nrfci character varying(36),
    vbcimportacao numeric(13,2),
    vdespaduimportacao numeric(13,2),
    viiimportacao numeric(13,2),
    viofimportacao numeric(13,2),
    idcstpisaliq integer,
    vbcpisaliq numeric(13,2),
    ppispisaliq numeric(8,4),
    vpispisaliq numeric(13,2),
    idcstpisqtde integer,
    qbcprodpisqtde numeric(16,4),
    valiqprodpisqtde numeric(15,4),
    vpispisqtde numeric(13,2),
    idcstpisnt integer,
    idcstpisoutr integer,
    vbcpisoutr numeric(13,2),
    ppisoutr numeric(8,4),
    qbcprodpisoutr numeric(16,4),
    valiqprodpisoutr numeric(15,4),
    vpisoutr numeric(13,2),
    vbcpisst numeric(13,2),
    ppisst numeric(8,4),
    qbcprodpisst numeric(16,4),
    valiqprodpisst numeric(15,4),
    vpisst numeric(13,2),
    idcstcofinsaliq integer,
    vbccofinsaliq numeric(15,4),
    pcofinsaliq numeric(8,4),
    vcofinsaliq numeric(15,4),
    idcstcofinsqtde integer,
    qbcprodcofinsqtde numeric(16,4),
    valiqprodcofinsqtde numeric(15,4),
    vcofinsqtde numeric(13,2),
    idcstcofinsnt integer,
    idcstcofinsoutr integer,
    vbccofinsoutr numeric(13,2),
    pcofinsoutr numeric(8,4),
    qbcprodoutr numeric(16,4),
    valiqprodoutr numeric(15,4),
    vcofinsoutr numeric(13,2),
    vbccofinsst numeric(13,2),
    pcofinsst numeric(8,4),
    qbcprodcofinsst numeric(16,4),
    valiqprodcofinsst numeric(15,4),
    vcofinsst numeric(13,2),
    vbcissqn numeric(13,2),
    valiqissqn numeric(15,4),
    vissqn numeric(13,2),
    cmunfgissqn character varying(7),
    clistservissqn character varying(5),
    vdeducaoissqn numeric(13,2),
    voutroissqn numeric(13,2),
    vdescincondissqn numeric(13,2),
    vdesccondissqn numeric(13,2),
    vissretissqn numeric(13,2),
    idindississqn character varying(2),
    cservicoissqn character varying(20),
    cmunissqn character varying(7),
    cpaisissqn character varying(4),
    nprocessoissqn character varying(30),
    idindincentivoissqn character varying(1),
    pdevol numeric(5,2),
    vipidevol numeric(13,2),
    nfadprod text
);

-- change database and user
\connect datalake postgres

-- privileges and permissions
ALTER SCHEMA public OWNER TO datalakeuser;


-- Anonymizer - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/anonymizer

-- change database and user
\connect datalake postgres

-- preload extension on datalake
ALTER DATABASE datalake SET session_preload_libraries = 'anon';

-- create the extension
CREATE EXTENSION anon CASCADE;

-- load extension
SELECT anon.init();

-- privileges and permissions
ALTER SCHEMA anon OWNER TO datalakeuser;
GRANT USAGE ON SCHEMA anon TO datalakeuser;
GRANT ALL ON ALL TABLES IN SCHEMA anon TO datalakeuser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA anon TO datalakeuser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA anon TO datalakeuser;

-- change database and user
\connect datalake datalakeuser

-- creating anon mviews
CREATE MATERIALIZED VIEW appmask.fatonfe AS SELECT
    id,
    15*sqnfe AS sqnfe,
    13*tpnfe AS tpnfe,
    14*idemitentecadastro AS idemitentecadastro,
    17*iddestinatariocadastro AS iddestinatariocadastro,
    19*idtransportadorcadastro AS idtransportadorcadastro,
    14*idcnaeemitente AS idcnaeemitente,
    11*idcnaedestinatario AS idcnaedestinatario,
    10*idemitentenfe AS idemitentenfe,
    18*iddestinatarionfe AS iddestinatarionfe,
    11*idtransportadornfe AS idtransportadornfe,
    anon.partial(idstnfe,2,$$*****$$,2) AS idstnfe,
    idtpnf,
    12*idcrtemit AS idcrtemit,
    12*iddest AS iddest,
    idmod,
    idtpimp,
    idtpemis,
    idfinnfe,
    idindfinal,
    idindpres,
    idprocemi,
    dtinclusao,
    dtemissao,
    dhrecebimento,
    encode(digest(chnfe, 'sha256'), 'hex') AS chnfe,
    versao,
    cuf,
    natop,
    3*serie AS serie,
    nnf,
    dhemi,
    dhsaient,
    19*cmunfg AS cmunfg,
    anon.partial(cnpjentrega,2,$$*****$$,2) AS cnpjentrega,
    anon.partial(ufentrega,2,$$*****$$,2) AS ufentrega,
    vbc,
    vicms,
    vicmsdeson,
    vfcpufdest,
    vicmsufdest,
    vicmsufremet,
    vfcp,
    vbcst,
    vst,
    vfcpst,
    vfcpstret,
    vprod,
    vfrete,
    vseg,
    vdesc,
    vii,
    vipi,
    vipidevol,
    vpis,
    vcofins,
    voutro,
    vnf,
    vtottrib,
    modfrete,
    vservtransp,
    vbcrettransp,
    picmsrettransp,
    vicmsrettransp,
    cfoptransp,
    cmunfgtransp,
    placaveic,
    ufveic,
    rntcveic,
    nfat,
    vorigfat,
    vdescfat,
    vliqfat,
    infadfisco,
    infcpl,
    ufsaidapais,
    xlocexporta,
    xlocdespacho,
    xnempcompras,
    xpedcompras,
    xcontcompras,
    safra,
    refcana,
    3*Cast("CNPJEmit" as bigint) AS "CNPJEmit",
    anon.partial("CPFEmit",2,$$*****$$,2) AS "CPFEmit",
    anon.fake_first_name() AS "xNomeEmit",
    anon.fake_company() AS "xFantEmit",
    anon.fake_region() AS "xLgrEmit",
    anon.random_zip() AS "nroEmit",
    anon.random_string(8) AS "xCplEmit",
    anon.fake_region() AS "xBairroEmit",
    anon.fake_region() AS "cMunEmit",
    anon.random_zip() AS "xMunEmit",
    anon.random_string(3) AS "UFEmit",
    anon.random_zip() AS "CEPEmit",
    anon.random_string(4) AS "cPaisEmit",
    anon.fake_country() AS "xPaisEmit",
    3*Cast("foneEmit" as bigint) AS "foneEmit",
    anon.random_string(4) AS "IEEmit",
    anon.random_string(4) AS "IESTEmit",
    anon.random_string(8) AS "IMEmit",
    anon.partial("CNAEEmit",2,$$*****$$,2) AS "CNAEEmit",
    anon.partial("CRTEmit",2,$$*****$$,2) AS "CRTEmit"
FROM app.fatonfe;

CREATE MATERIALIZED VIEW appmask.fatoitemnfe AS SELECT
    id,
    20*sqnfe AS sqnfe,
    15*nritemnfe AS nritemnfe,
    anon.partial(idstnfe,2,$$*****$$,2) AS idstnfe,
    16*idtpnfe AS idtpnfe,
    13*idufemit AS idufemit,
    14*idcrtemit AS idcrtemit,
    encode(digest(chnfe, 'sha256'), 'hex') AS chnfe,
    natop,
    16*idmod AS idmod,
    10*serie AS serie,
    19*nnf AS nnf,
    dhemi,
    dhsaient,
    idtpoperacao,
    14*iddest AS iddest,
    16*idmunfg AS idmunfg,
    10*idfinnfe AS idfinnfe,
    idindfinal,
    idindpres,
    dtinclusao,
    dtemissao,
    13*idmodfrete AS idmodfrete,
    17*idemitentecadastro AS idemitentecadastro,
    17*iddestinatariocadastro AS iddestinatariocadastro,
    14*idtransportadorcadastro AS idtransportadorcadastro,
    20*idemitentenfe AS idemitentenfe,
    11*iddestinatarionfe AS iddestinatarionfe,
    idtransportadornfe,
    20*idcnaeemitente AS idcnaeemitente,
    13*idcnaedestinatario AS idcnaedestinatario,
    20*idveiculo AS idveiculo,
    17*idcombustivel AS idcombustivel,
    versao,
    cprod,
    idcean,
    xprod,
    ncm,
    cest,
    indescala,
    anon.partial(cnpjfab,2,$$*****$$,2) AS cnpjfab,
    cbenef,
    extipi,
    cfop,
    ucom,
    qcom,
    vuncom,
    vprod,
    idceantrib,
    utrib,
    qtrib,
    vuntrib,
    vfrete,
    vseg,
    vdesc,
    voutro,
    idindtot,
    cprodanvisa,
    xmotivoisencao,
    vpmc,
    idorig,
    idcst,
    idmodbc,
    vbc,
    picms,
    vicms,
    pfcp,
    vfcp,
    vbcfcp,
    idmodbcst,
    pmvast,
    predbcst,
    vbcst,
    picmsst,
    vicmsst,
    vbcfcpst,
    pfcpst,
    vfcpst,
    predbc,
    vicmsdeson,
    idmotdesicms,
    vicmsop,
    pdif,
    vicmsdif,
    vbcstret,
    pst,
    vicmssubstituto,
    vicmsstret,
    vbcfcpstret,
    pfcpstret,
    vfcpstret,
    predbcefet,
    vbcefet,
    picmsefet,
    vicmsefet,
    idorigicmspart,
    idcsticmspart,
    idmodbcicmspart,
    vbcicmspart,
    predbcicmspart,
    picmsicmspart,
    vicmsicmspart,
    idmodbcsticmspart,
    pmvasticmspart,
    predbcsticmspart,
    vbcsticmspart,
    picmssticmspart,
    vicmssticmspart,
    pbcopicmspart,
    ufsticmspart,
    idorigrepassest,
    idcstrepassest,
    vbcstretrepassest,
    pstrepassest,
    vicmssubstitutorepassest,
    vicmsstretrepassest,
    vbcfcpstretrepassest,
    pfcpstretrepassest,
    vfcpstretrepassest,
    vbcstdestrepassest,
    vicmsstdestrepassest,
    predbcefetrepassest,
    vbcefetrepassest,
    picmsefetrepassest,
    vicmsefetrepassest,
    idorigcrt,
    csosn,
    pcredsncrt,
    vcredicmssncrt,
    idmodbcstcrt,
    pmvasticmscrt,
    predbcstcrt,
    picmsstcrt,
    vicmsstcrt,
    vbcfcpstcrt,
    pfcpstcrt,
    vfcpstcrt,
    vbcstretcrt,
    vicmsstretcrt,
    vbcstcrt,
    vtottribgm,
    vbcufdest,
    vbcfcpufdest,
    pfcpufdest,
    picmsufdest,
    picmsinter,
    picmsinterpart,
    vfcpufdestgna,
    vicmsufdestgna,
    vicmsufremetgna,
    xped,
    nitemped,
    nrfci,
    vbcimportacao,
    vdespaduimportacao,
    viiimportacao,
    viofimportacao,
    idcstpisaliq,
    vbcpisaliq,
    ppispisaliq,
    vpispisaliq,
    idcstpisqtde,
    qbcprodpisqtde,
    valiqprodpisqtde,
    vpispisqtde,
    idcstpisnt,
    idcstpisoutr,
    vbcpisoutr,
    ppisoutr,
    qbcprodpisoutr,
    valiqprodpisoutr,
    vpisoutr,
    vbcpisst,
    ppisst,
    qbcprodpisst,
    valiqprodpisst,
    vpisst,
    idcstcofinsaliq,
    vbccofinsaliq,
    pcofinsaliq,
    vcofinsaliq,
    idcstcofinsqtde,
    qbcprodcofinsqtde,
    valiqprodcofinsqtde,
    vcofinsqtde,
    idcstcofinsnt,
    idcstcofinsoutr,
    vbccofinsoutr,
    pcofinsoutr,
    qbcprodoutr,
    valiqprodoutr,
    vcofinsoutr,
    vbccofinsst,
    pcofinsst,
    qbcprodcofinsst,
    valiqprodcofinsst,
    vcofinsst,
    vbcissqn,
    valiqissqn,
    vissqn,
    cmunfgissqn,
    clistservissqn,
    vdeducaoissqn,
    voutroissqn,
    vdescincondissqn,
    vdesccondissqn,
    vissretissqn,
    idindississqn,
    cservicoissqn,
    cmunissqn,
    cpaisissqn,
    nprocessoissqn,
    idindincentivoissqn,
    pdevol,
    vipidevol,
    nfadprod
FROM app.fatoitemnfe;


-- Hasura - see https://github.com/arialab/sefazpb-infra/tree/master/hasura

-- change database and user
\connect datalake postgres

-- create a separate user for hasura
CREATE USER hasurauser WITH PASSWORD 'quaevu8U';

-- grant connection to 'hasurauser' on database 'datalake'
GRANT CONNECT ON DATABASE datalake TO hasurauser;

-- create pgcrypto extension, required for UUID
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- create the schemas required by the hasura system
CREATE SCHEMA IF NOT EXISTS hdb_catalog;
CREATE SCHEMA IF NOT EXISTS hdb_views;

-- make the user an owner of system schemas
ALTER SCHEMA hdb_catalog OWNER TO hasurauser;
ALTER SCHEMA hdb_views OWNER TO hasurauser;

-- grant select permissions on information_schema and pg_catalog. This is
-- required for hasura to query list of available tables
GRANT SELECT ON ALL TABLES IN SCHEMA information_schema TO hasurauser;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO hasurauser;

-- set search path to include schemas for a particular role
ALTER ROLE hasurauser SET search_path TO public,app,appmask;

-- change database and user
\connect datalake datalakeuser

-- This is dependent on what access to your tables/schemas you want give 
-- to hasura. If you want expose the public schema for GraphQL query then 
-- give permissions on public schema to the hasura user.

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


-- Hasura JWT Auth - see https://github.com/arialab/sefazpb-infra/tree/master/hasura/hasura_jwt_auth

-- change database and user
\connect datalake postgres

-- setting jwt_secret_key
ALTER DATABASE datalake SET "hasura.jwt_secret_key" TO 'IouHeDgirik0vhBkNw4iFQkUo3tzrwPYNGWHfCjDqsNujDcpV77xIeg24luLGq2F';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- change database and user
\connect datalake datalakeuser

-- creating functions
CREATE OR REPLACE FUNCTION url_encode(data bytea) RETURNS text LANGUAGE sql AS $$
    SELECT translate(encode(data, 'base64'), E'+/=\n', '-_');
$$;

CREATE OR REPLACE FUNCTION url_decode(data text) RETURNS bytea LANGUAGE sql AS $$
WITH t AS (SELECT translate(data, '-_', '+/') AS trans),
     rem AS (SELECT length(t.trans) % 4 AS remainder FROM t) -- compute padding size
    SELECT decode(
        t.trans ||
        CASE WHEN rem.remainder > 0
           THEN repeat('=', (4 - rem.remainder))
           ELSE '' END,
    'base64') FROM t, rem;
$$;

CREATE OR REPLACE FUNCTION algorithm_sign(signables text, secret text, algorithm text)
RETURNS text LANGUAGE sql AS $$
WITH
  alg AS (
    SELECT CASE
      WHEN algorithm = 'HS256' THEN 'sha256'
      WHEN algorithm = 'HS384' THEN 'sha384'
      WHEN algorithm = 'HS512' THEN 'sha512'
      ELSE '' END AS id)  -- hmac throws error
SELECT url_encode(hmac(signables, secret, alg.id)) FROM alg;
$$;

CREATE OR REPLACE FUNCTION sign(payload json, secret text, algorithm text DEFAULT 'HS256')
RETURNS text LANGUAGE sql AS $$
WITH
  header AS (
    SELECT url_encode(convert_to('{"alg":"' || algorithm || '","typ":"JWT"}', 'utf8')) AS data
    ),
  payload AS (
    SELECT url_encode(convert_to(payload::text, 'utf8')) AS data
    ),
  signables AS (
    SELECT header.data || '.' || payload.data AS data FROM header, payload
    )
SELECT
    signables.data || '.' ||
    algorithm_sign(signables.data, secret, algorithm) FROM signables;
$$;

CREATE OR REPLACE FUNCTION verify(token text, secret text, algorithm text DEFAULT 'HS256')
RETURNS table(header json, payload json, valid boolean) LANGUAGE sql AS $$
  SELECT
    convert_from(url_decode(r[1]), 'utf8')::json AS header,
    convert_from(url_decode(r[2]), 'utf8')::json AS payload,
    r[3] = algorithm_sign(r[1] || '.' || r[2], secret, algorithm) AS valid
  FROM regexp_split_to_array(token, '\.') r;
$$;

create table hasura_user(
    id serial primary key,
    email varchar unique,
    crypt_password varchar,
    cleartext_password varchar,
    default_role varchar default 'user',
    allowed_roles jsonb default '["user"]',
    enabled boolean default true,
    jwt_token text
);

create or replace function hasura_encrypt_password(cleartext_password in text, salt in text) returns varchar as $$
    select crypt(
        encode(hmac(cleartext_password, current_setting('hasura.jwt_secret_key'), 'sha256'), 'escape'),
        salt);
$$ language sql stable;

create or replace function hasura_user_encrypt_password() returns trigger as $$
begin
    if new.cleartext_password is not null and trim(new.cleartext_password) <> '' then
        new.crypt_password := (hasura_encrypt_password(new.cleartext_password, gen_salt('bf')));
    end if;
    new.cleartext_password = null;
    new.jwt_token = null;
    return new;
end;
$$ language 'plpgsql';

create trigger hasura_user_encrypt_password_trigger
before insert or update on hasura_user
for each row execute procedure hasura_user_encrypt_password();

-- https://docs.hasura.io/1.0/graphql/manual/auth/authentication/jwt.html#configuring-jwt-mode
create or replace function hasura_auth(email in varchar, cleartext_password in varchar) returns setof hasura_user as $$
    select
        id,
        email,
        crypt_password,
        cleartext_password,
        default_role,
        allowed_roles,
        enabled,
        sign(
            json_build_object(
                'sub', id::text,
                'iss', 'Hasura-JWT-Auth',
                'iat', round(extract(epoch from now())),
                'exp', round(extract(epoch from now() + interval '24 hour')),
                'https://hasura.io/jwt/claims', json_build_object(
                    'x-hasura-user-id', id::text,
                    'x-hasura-default-role', default_role,
                    'x-hasura-allowed-roles', allowed_roles
                )
            ), current_setting('hasura.jwt_secret_key')) as jwt_token
    from hasura_user h
    where h.email = hasura_auth.email
    and h.enabled
    and h.crypt_password = hasura_encrypt_password(hasura_auth.cleartext_password, h.crypt_password);
$$ language 'sql' stable;

-- initial user
insert into hasura_user(email, cleartext_password, default_role, allowed_roles) values ('poc@serpb.local', '48jL1bzADd04', 'g_ufpb_datalake_anon', '["g_ufpb_datalake_all", "g_ufpb_datalake_admin", "g_ufpb_datalake_gecof1", "g_ufpb_datalake_anon"]');

GRANT USAGE ON SCHEMA public TO hasurauser;
GRANT ALL ON ALL TABLES IN SCHEMA public TO hasurauser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO hasurauser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO hasurauser;


-- EFD create_tables.sql - see https://github.com/arialab/sefazpb-infra/tree/master/postgres/datalake/EFD/loader
\connect datalake datalakeuser

--Create Master table
CREATE TABLE IF NOT EXISTS app.efd
(
    id serial PRIMARY KEY,
    protocolo varchar(50),
    origem char(12),
    cnpj character(14),
    insestadual character(9),
    retificacao boolean,
    periodo character(6),
    dtprotocolo timestamp,
    layout character varying(3),
    dtentrega timestamp,
    descricao bytea
);

--Create patitons table
CREATE TABLE app.efd_2013_11(PRIMARY KEY (id), CHECK (periodo = '201311')) INHERITS (app.efd);
CREATE TABLE app.efd_2013_12(PRIMARY KEY (id), CHECK (periodo = '201312')) INHERITS (app.efd);

CREATE TABLE app.efd_2014_01(PRIMARY KEY (id), CHECK (periodo = '201401')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_02(PRIMARY KEY (id), CHECK (periodo = '201402')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_03(PRIMARY KEY (id), CHECK (periodo = '201403')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_04(PRIMARY KEY (id), CHECK (periodo = '201404')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_05(PRIMARY KEY (id), CHECK (periodo = '201405')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_06(PRIMARY KEY (id), CHECK (periodo = '201406')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_07(PRIMARY KEY (id), CHECK (periodo = '201407')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_08(PRIMARY KEY (id), CHECK (periodo = '201408')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_09(PRIMARY KEY (id), CHECK (periodo = '201409')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_10(PRIMARY KEY (id), CHECK (periodo = '201410')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_11(PRIMARY KEY (id), CHECK (periodo = '201411')) INHERITS (app.efd);
CREATE TABLE app.efd_2014_12(PRIMARY KEY (id), CHECK (periodo = '201412')) INHERITS (app.efd);

CREATE TABLE app.efd_2016_08(PRIMARY KEY (id), CHECK (periodo = '201608')) INHERITS (app.efd);
CREATE TABLE app.efd_2016_10(PRIMARY KEY (id), CHECK (periodo = '201610')) INHERITS (app.efd);

CREATE TABLE app.efd_2018_01(PRIMARY KEY (id), CHECK (periodo = '201801')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_02(PRIMARY KEY (id), CHECK (periodo = '201802')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_03(PRIMARY KEY (id), CHECK (periodo = '201803')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_04(PRIMARY KEY (id), CHECK (periodo = '201804')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_05(PRIMARY KEY (id), CHECK (periodo = '201805')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_06(PRIMARY KEY (id), CHECK (periodo = '201806')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_07(PRIMARY KEY (id), CHECK (periodo = '201807')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_08(PRIMARY KEY (id), CHECK (periodo = '201808')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_09(PRIMARY KEY (id), CHECK (periodo = '201809')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_10(PRIMARY KEY (id), CHECK (periodo = '201810')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_11(PRIMARY KEY (id), CHECK (periodo = '201811')) INHERITS (app.efd);
CREATE TABLE app.efd_2018_12(PRIMARY KEY (id), CHECK (periodo = '201812')) INHERITS (app.efd);

CREATE TABLE app.efd_2019_01(PRIMARY KEY (id), CHECK (periodo = '201901')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_02(PRIMARY KEY (id), CHECK (periodo = '201902')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_03(PRIMARY KEY (id), CHECK (periodo = '201903')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_04(PRIMARY KEY (id), CHECK (periodo = '201904')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_05(PRIMARY KEY (id), CHECK (periodo = '201905')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_06(PRIMARY KEY (id), CHECK (periodo = '201906')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_07(PRIMARY KEY (id), CHECK (periodo = '201907')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_08(PRIMARY KEY (id), CHECK (periodo = '201908')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_09(PRIMARY KEY (id), CHECK (periodo = '201909')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_10(PRIMARY KEY (id), CHECK (periodo = '201910')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_11(PRIMARY KEY (id), CHECK (periodo = '201911')) INHERITS (app.efd);
CREATE TABLE app.efd_2019_12(PRIMARY KEY (id), CHECK (periodo = '201912')) INHERITS (app.efd);

CREATE TABLE app.efd_2020_01(PRIMARY KEY (id), CHECK (periodo = '202001')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_02(PRIMARY KEY (id), CHECK (periodo = '202002')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_03(PRIMARY KEY (id), CHECK (periodo = '202003')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_05(PRIMARY KEY (id), CHECK (periodo = '202005')) INHERITS (app.efd);
CREATE TABLE app.efd_2020_06(PRIMARY KEY (id), CHECK (periodo = '202006')) INHERITS (app.efd);


--Creating index to partitioned tables
CREATE INDEX idx_efd_2013_11 ON app.efd_2013_11 (periodo);
CREATE INDEX idx_efd_2013_12 ON app.efd_2013_12 (periodo);

CREATE INDEX idx_efd_2014_01 ON app.efd_2014_01 (periodo);
CREATE INDEX idx_efd_2014_02 ON app.efd_2014_02 (periodo);
CREATE INDEX idx_efd_2014_03 ON app.efd_2014_03 (periodo);
CREATE INDEX idx_efd_2014_04 ON app.efd_2014_04 (periodo);
CREATE INDEX idx_efd_2014_05 ON app.efd_2014_05 (periodo);
CREATE INDEX idx_efd_2014_06 ON app.efd_2014_06 (periodo);
CREATE INDEX idx_efd_2014_07 ON app.efd_2014_07 (periodo);
CREATE INDEX idx_efd_2014_08 ON app.efd_2014_08 (periodo);
CREATE INDEX idx_efd_2014_09 ON app.efd_2014_09 (periodo);
CREATE INDEX idx_efd_2014_10 ON app.efd_2014_10 (periodo);
CREATE INDEX idx_efd_2014_11 ON app.efd_2014_11 (periodo);
CREATE INDEX idx_efd_2014_12 ON app.efd_2014_12 (periodo);

CREATE INDEX idx_efd_2016_08 ON app.efd_2016_08 (periodo);
CREATE INDEX idx_efd_2016_10 ON app.efd_2016_10 (periodo);

CREATE INDEX idx_efd_2018_01 ON app.efd_2018_01 (periodo);
CREATE INDEX idx_efd_2018_02 ON app.efd_2018_02 (periodo);
CREATE INDEX idx_efd_2018_03 ON app.efd_2018_03 (periodo);
CREATE INDEX idx_efd_2018_04 ON app.efd_2018_04 (periodo);
CREATE INDEX idx_efd_2018_05 ON app.efd_2018_05 (periodo);
CREATE INDEX idx_efd_2018_06 ON app.efd_2018_06 (periodo);
CREATE INDEX idx_efd_2018_07 ON app.efd_2018_07 (periodo);
CREATE INDEX idx_efd_2018_08 ON app.efd_2018_08 (periodo);
CREATE INDEX idx_efd_2018_09 ON app.efd_2018_09 (periodo);
CREATE INDEX idx_efd_2018_10 ON app.efd_2018_10 (periodo);
CREATE INDEX idx_efd_2018_11 ON app.efd_2018_11 (periodo);
CREATE INDEX idx_efd_2018_12 ON app.efd_2018_12 (periodo);

CREATE INDEX idx_efd_2019_01 ON app.efd_2019_01 (periodo);
CREATE INDEX idx_efd_2019_02 ON app.efd_2019_02 (periodo);
CREATE INDEX idx_efd_2019_03 ON app.efd_2019_03 (periodo);
CREATE INDEX idx_efd_2019_04 ON app.efd_2019_04 (periodo);
CREATE INDEX idx_efd_2019_05 ON app.efd_2019_05 (periodo);
CREATE INDEX idx_efd_2019_06 ON app.efd_2019_06 (periodo);
CREATE INDEX idx_efd_2019_07 ON app.efd_2019_07 (periodo);
CREATE INDEX idx_efd_2019_08 ON app.efd_2019_08 (periodo);
CREATE INDEX idx_efd_2019_09 ON app.efd_2019_09 (periodo);
CREATE INDEX idx_efd_2019_10 ON app.efd_2019_10 (periodo);
CREATE INDEX idx_efd_2019_11 ON app.efd_2019_11 (periodo);
CREATE INDEX idx_efd_2019_12 ON app.efd_2019_12 (periodo);

CREATE INDEX idx_efd_2020_01 ON app.efd_2020_01 (periodo);
CREATE INDEX idx_efd_2020_02 ON app.efd_2020_02 (periodo);
CREATE INDEX idx_efd_2020_03 ON app.efd_2020_03 (periodo);
CREATE INDEX idx_efd_2020_05 ON app.efd_2020_05 (periodo);
CREATE INDEX idx_efd_2020_06 ON app.efd_2020_06 (periodo);

--Procedure to insert data into matching partitioned tables
CREATE OR REPLACE FUNCTION efd_insert()
	RETURNS TRIGGER AS $$
	BEGIN
  IF (NEW.periodo = '201311') THEN
	INSERT INTO app.efd_2013_11 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201312') THEN
	INSERT INTO app.efd_2013_12 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '201401') THEN
	INSERT INTO app.efd_2014_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201402') THEN
	INSERT INTO app.efd_2014_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201403') THEN
	INSERT INTO app.efd_2014_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201404') THEN
	INSERT INTO app.efd_2014_04 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201405') THEN
	INSERT INTO app.efd_2014_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201406') THEN
	INSERT INTO app.efd_2014_06 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201407') THEN
	INSERT INTO app.efd_2014_07 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201408') THEN
	INSERT INTO app.efd_2014_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201409') THEN
	INSERT INTO app.efd_2014_09 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201410') THEN
	INSERT INTO app.efd_2014_10 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201411') THEN
	INSERT INTO app.efd_2014_11 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201412') THEN
	INSERT INTO app.efd_2014_12 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '201608') THEN
	INSERT INTO app.efd_2016_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201610') THEN
	INSERT INTO app.efd_2016_10 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '201801') THEN
	INSERT INTO app.efd_2018_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201802') THEN
	INSERT INTO app.efd_2018_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201803') THEN
	INSERT INTO app.efd_2018_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201804') THEN
	INSERT INTO app.efd_2018_04 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201805') THEN
	INSERT INTO app.efd_2018_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201806') THEN
	INSERT INTO app.efd_2018_06 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201807') THEN
	INSERT INTO app.efd_2018_07 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201808') THEN
	INSERT INTO app.efd_2018_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201809') THEN
	INSERT INTO app.efd_2018_09 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201810') THEN
	INSERT INTO app.efd_2018_10 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201811') THEN
	INSERT INTO app.efd_2018_11 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201812') THEN
	INSERT INTO app.efd_2018_12 VALUES (NEW.*);

	ELSEIF (NEW.periodo = '201901') THEN
	INSERT INTO app.efd_2019_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201902') THEN
	INSERT INTO app.efd_2019_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201903') THEN
	INSERT INTO app.efd_2019_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201904') THEN
	INSERT INTO app.efd_2019_04 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201905') THEN
	INSERT INTO app.efd_2019_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201906') THEN
	INSERT INTO app.efd_2019_06 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201907') THEN
	INSERT INTO app.efd_2019_07 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201908') THEN
	INSERT INTO app.efd_2019_08 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201909') THEN
	INSERT INTO app.efd_2019_09 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '201910') THEN
	INSERT INTO app.efd_2019_10 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201911') THEN
	INSERT INTO app.efd_2019_11 VALUES (NEW.*);
	ELSEIF (NEW.periodo = '201912') THEN
	INSERT INTO app.efd_2019_12 VALUES (NEW.*);

  ELSEIF (NEW.periodo = '202001') THEN
	INSERT INTO app.efd_2020_01 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202002') THEN
	INSERT INTO app.efd_2020_02 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202003') THEN
	INSERT INTO app.efd_2020_03 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202005') THEN
	INSERT INTO app.efd_2020_05 VALUES (NEW.*);
  ELSEIF (NEW.periodo = '202006') THEN
	INSERT INTO app.efd_2020_06 VALUES (NEW.*);
	ELSE
	RAISE EXCEPTION 'Periodo não possui tabela definida';
	END IF;
	RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;

--Create a trigger to manage the insert process
DROP TRIGGER IF EXISTS efd_insert_trigger on app.efd;
CREATE TRIGGER efd_insert_trigger
  BEFORE INSERT ON app.efd
  FOR EACH ROW
  EXECUTE PROCEDURE efd_insert();

--Constraint exclusion to optimze performance for partitioned tables
SET constraint_exclusion = on;
SELECT count(*) FROM app.efd WHERE periodo >= '201311';
