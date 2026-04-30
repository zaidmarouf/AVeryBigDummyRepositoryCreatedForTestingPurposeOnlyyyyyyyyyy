-- ============================================================
-- MIGRATION SCRIPT
-- ============================================================
-- Target: PROD_DB.DYNAMIC_PROD1
-- ============================================================

USE DATABASE PROD_DB;
USE SCHEMA DYNAMIC_PROD1;


-- ------------------------------------------------------------
-- DROP OBJECTS
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "PROD_DB"."DYNAMIC_PROD1"."SRC_TABLE2";
DROP TABLE IF EXISTS "PROD_DB"."DYNAMIC_PROD1"."SRC_TABLE";

-- ------------------------------------------------------------
-- CREATE OBJECTS
-- ------------------------------------------------------------

CREATE OR REPLACE TABLE "MY TABLE 4" (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE "MY  TABLE  5" (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE " MY  TABLE 6 " (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE " MY_TABLE_1" (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE MY_TABLE_4 (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE MY_TABLE_2 (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE MY_TABLE_1 (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE "MY_TABLE_2 " (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE " MY_TABLE_3 " (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE MY_TABLE_5 (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE MY_TABLE_3 (
	ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE MY_TABLE_6 (
	ID NUMBER(38,0)
);


-- ============================================================
-- END - 14 statement(s)
-- ============================================================