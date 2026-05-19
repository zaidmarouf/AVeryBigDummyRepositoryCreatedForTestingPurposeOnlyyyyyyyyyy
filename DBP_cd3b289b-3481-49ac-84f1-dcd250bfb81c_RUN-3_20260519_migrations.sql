-- ============================================================
-- MIGRATION SCRIPT
-- ============================================================
-- Target: PROD.TEST1
-- ============================================================

USE DATABASE PROD;
USE SCHEMA TEST1;


-- ------------------------------------------------------------
-- DROP OBJECTS
-- ------------------------------------------------------------

DROP VIEW IF EXISTS "PROD"."TEST1"."PROD_ONLY_VIEW";
DROP PIPE IF EXISTS "PROD"."TEST1"."PROD_ONLY_PIPE";
DROP FUNCTION IF EXISTS "PROD"."TEST1".PROD_ONLY_FUNCTION(NUMBER);
DROP SEQUENCE IF EXISTS "PROD"."TEST1"."PROD_ONLY_SEQ";
DROP PROCEDURE IF EXISTS "PROD"."TEST1".PROD_ONLY_PROCEDURE();
DROP FILE FORMAT IF EXISTS "PROD"."TEST1"."PROD_ONLY_FORMAT";
DROP TABLE IF EXISTS "PROD"."TEST1"."PROD_ONLY_TABLE";
DROP STAGE IF EXISTS "PROD"."TEST1"."PROD_ONLY_STAGE";
DROP TASK IF EXISTS "PROD"."TEST1"."PROD_ONLY_TASK";
DROP STREAM IF EXISTS "PROD"."TEST1"."PROD_ONLY_STREAM";

-- ------------------------------------------------------------
-- CREATE OBJECTS
-- ------------------------------------------------------------

CREATE OR REPLACE sequence DEV_ONLY_SEQ start with 1 increment by 1 noorder;

CREATE OR REPLACE STAGE "PROD"."TEST1"."DEV_ONLY_STAGE"
  FILE_FORMAT = (
    TYPE = CSV
  )
  COMMENT = 'DEV only stage';

CREATE OR REPLACE TABLE DEV_ONLY_TABLE (
	ID NUMBER(38,0) NOT NULL,
	NAME VARCHAR(100) NOT NULL,
	CREATED_AT TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP(),
	primary key (ID)
);

CREATE OR REPLACE FUNCTION "DEV_ONLY_FUNCTION"("VAL" NUMBER(38,0))
RETURNS NUMBER(38,0)
LANGUAGE SQL
AS '
    val * 2
';

CREATE OR REPLACE FILE FORMAT "PROD"."TEST1"."DEV_ONLY_FORMAT"
  TYPE = CSV
  SKIP_HEADER = 1
  NULL_IF = ('\\N')
  MULTI_LINE = true
;

CREATE OR REPLACE view DEV_ONLY_VIEW(
	ID,
	NAME
) as
    SELECT id, name FROM dev_only_table;

CREATE OR REPLACE pipe DEV_ONLY_PIPE auto_ingest=false comment='DEV only pipe' as COPY INTO shared_table(id, first_name)
    FROM (SELECT $1, $2 FROM @dev_only_stage);

CREATE OR REPLACE stream DEV_ONLY_STREAM on table DEV_ONLY_TABLE;

CREATE OR REPLACE PROCEDURE "DEV_ONLY_PROCEDURE"()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    RETURN ''DEV only procedure'';
END;
';

CREATE OR REPLACE task DEV_ONLY_TASK
	warehouse=COMPUTE_WH
	schedule='60 MINUTE'
	as SELECT CURRENT_TIMESTAMP();


-- ------------------------------------------------------------
-- ALTER OBJECTS
-- ------------------------------------------------------------

ALTER TABLE "PROD"."TEST1"."SHARED_TABLE" ADD COLUMN "SALARY" NUMBER(10,2);
ALTER TABLE "PROD"."TEST1"."SHARED_TABLE" ADD COLUMN "EMAIL" VARCHAR(200);
ALTER TABLE "PROD"."TEST1"."SHARED_TABLE" DROP COLUMN "PHONE";
ALTER TABLE "PROD"."TEST1"."SHARED_TABLE" ALTER COLUMN "FIRST_NAME" SET DATA TYPE VARCHAR(100);
CREATE OR REPLACE task SHARED_TASK
	warehouse=COMPUTE_WH
	schedule='30 MINUTE'
	as SELECT CURRENT_TIMESTAMP();

CREATE OR REPLACE sequence SHARED_SEQ start with 1 increment by 1 noorder;

CREATE OR REPLACE FILE FORMAT "PROD"."TEST1"."SHARED_FORMAT"
  TYPE = CSV
  SKIP_HEADER = 1
  NULL_IF = ('\\N')
  MULTI_LINE = true
;

CREATE OR REPLACE STAGE "PROD"."TEST1"."SHARED_STAGE"
  FILE_FORMAT = (
    TYPE = CSV
  )
  COMMENT = 'DEV shared stage comment';

CREATE OR REPLACE view SHARED_VIEW(
	ID,
	FIRST_NAME,
	EMAIL
) as
    SELECT id, first_name, email FROM shared_table;

CREATE OR REPLACE PROCEDURE "SHARED_PROCEDURE"("INPUT_ID" NUMBER(38,0))
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    -- DEV version: returns name and email
    RETURN ''DEV: fetching name and email for id '' || input_id;
END;
';

CREATE OR REPLACE FUNCTION "SHARED_FUNCTION"("VAL" NUMBER(38,0))
RETURNS NUMBER(38,0)
LANGUAGE SQL
AS '
    val * 10  -- DEV multiplies by 10
';

CREATE OR REPLACE pipe SHARED_PIPE auto_ingest=false comment='DEV shared pipe' as COPY INTO shared_table(id, first_name, email)  -- DEV copies 3 columns
    FROM (SELECT $1, $2, $3 FROM @shared_stage);


-- ============================================================
-- END - 32 statement(s)
-- ============================================================