-- DROP   TABLE T3DECL ;
--
-- *************************************************************
-- CREATION D'UNE TABLE T3DECL
-- *************************************************************
--
-- *************************************************************
-- EN DB2, PAS D'ETENDU, QUE DU BINAIRE OU DU COMP-3
-- ET ON N'UTILISE DU BINAIRE PRESQUE JAMAIS
-- DEC CORRESPOND A PIC S99 COMP-3
-- *************************************************************
--
   CREATE TABLE T3DECL (
       IDDEC   DEC(5) PRIMARY KEY NOT NULL,
       IDART   DEC(5)                     ,
       SIZDEC  CHAR(3)                    ,
       COLDEC  CHAR(20)                   ,
       QSTODEC DEC(6)             NOT NULL,
       QALEDEC DEC(3)                     ,

       FOREIGN KEY FKDEC1 (IDART) REFERENCES T3ARTI
                                      ON DELETE CASCADE
                       )

   IN DBMATE1.TSLEMA03

   ;
   CREATE UNIQUE INDEX
      IST3DECLX_ID
      ON T3DECL (IDDEC)
   ;
   SELECT * FROM T3DECL
   ;
