-- ============================================================
-- MIGRATION SCRIPT
-- ============================================================
-- Target: PRODAUTO.TESTDEVAUTOP
-- ============================================================

USE DATABASE PRODAUTO;
USE SCHEMA TESTDEVAUTOP;


-- ------------------------------------------------------------
-- CREATE OBJECTS
-- ------------------------------------------------------------

CREATE OR REPLACE TABLE DEV_ONLY_TABLE (
	ID NUMBER(38,0) NOT NULL,
	NAME VARCHAR(100) NOT NULL,
	CREATED_AT TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP(),
	primary key (ID)
);

CREATE OR REPLACE TABLE SHARED_TABLE (
	ID NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(100),
	EMAIL VARCHAR(200),
	SALARY NUMBER(10,2),
	CREATED_AT TIMESTAMP_NTZ(9),
	primary key (ID)
);


-- ============================================================
-- END - 2 statement(s)
-- ============================================================