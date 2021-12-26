-- DROP   TABLE T3DECL ;                                                00000100
--                                                                      00000200
-- *************************************************************        00000201
-- CREATION D'UNE TABLE T3DECL                                          00000202
-- *************************************************************        00000203
--                                                                      00000204
-- *************************************************************        00000205
-- EN DB2, PAS D'ETENDU, QUE DU BINAIRE OU DU COMP-3                    00000206
-- ET ON N'UTILISE DU BINAIRE PRESQUE JAMAIS                            00000207
-- DEC CORRESPOND A PIC S99 COMP-3                                      00000208
-- *************************************************************        00000209
--                                                                      00000210
   CREATE TABLE T3DECL (                                                00000211
       IDDEC   DEC(5) PRIMARY KEY NOT NULL,                             00000216
       IDART   DEC(5)                     ,                             00000217
       SIZDEC  CHAR(3)                    ,                             00000218
       COLDEC  CHAR(20)                   ,                             00000219
       QSTODEC DEC(6)             NOT NULL,                             00000220
       QALEDEC DEC(3)                     ,                             00000221
                                                                        00000222
       FOREIGN KEY FKDEC1 (IDART) REFERENCES T3ARTI                     00000223
                                      ON DELETE CASCADE                 00000224
                       )                                                00000225
                                                                        00000226
   IN DBMATE1.TSLEMA03                                                  00000227
                                                                        00000228
   ;                                                                    00000230
   CREATE UNIQUE INDEX                                                  00000240
      IST3DECLX_ID                                                      00000250
      ON T3DECL (IDDEC)                                                 00000260
   ;                                                                    00000270
   SELECT * FROM T3DECL                                                 00000280
   ;                                                                    00000290
