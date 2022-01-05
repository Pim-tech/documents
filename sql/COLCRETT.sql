   SET CURRENT SQLID=USER;
--------------------
--   DROP TABLE TCOLLABO;
--------------------
   CREATE TABLE TCOLLABO(
      IDCOLL CHAR(2) NOT NULL,
          PRIMARY KEY (IDCOLL),
      NOM CHAR (5),
      IDSUP CHAR(2))
      IN ADCD01DB.ADCD$01;
-----------------------
   COMMIT   ;
-----------------------
   CREATE UNIQUE INDEX
     IXCOLL
     ON TCOLLABO(IDCOLL);
--------------------
   COMMIT   ;
--------------------
   GRANT ALL ON TABLE  TCOLLABO TO PUBLIC;
--------------------
   COMMIT   ;
--------------------
   SET CURRENT SQLID=USER;
--------------------
   SELECT *
   FROM  TCOLLABO ;
