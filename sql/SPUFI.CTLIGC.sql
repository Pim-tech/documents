   DROP   TABLE T3LIGC ;                                                00000100
   COMMIT;                                                              00000200
-- *************************************************************        00000201
-- CREATION D'UNE TABLE T3LIGC                                          00000202
-- *************************************************************        00000203
--                                                                      00000204
   CREATE TABLE T3LIGC (                                                00000211
       IDDEC    DEC(5)             NOT NULL,                            00000216
       IDCOMM   DEC(2)             NOT NULL,                            00000217
       QCOMLIGC DEC(5)             NOT NULL,                            00000220
                                                                        00000222
       PRIMARY KEY (IDDEC,IDCOMM)          ,                            00000223
       FOREIGN KEY FKLIGC1 (IDDEC)  REFERENCES T3DECL                   00000224
                                      ON DELETE RESTRICT,               00000225
       FOREIGN KEY FKLIGC2 (IDCOMM) REFERENCES T3COMM                   00000226
                                      ON DELETE CASCADE                 00000227
                       )                                                00000228
                                                                        00000229
   IN DBMATE1.TSLEMA03                                                  00000230
                                                                        00000231
   ;                                                                    00000232
   CREATE UNIQUE INDEX                                                  00000240
      IST3LIGCX_ID                                                      00000250
      ON T3LIGC (IDDEC,IDCOMM)                                          00000260
   ;                                                                    00000270
   SELECT * FROM T3LIGC                                                 00000280
   ;                                                                    00000290
