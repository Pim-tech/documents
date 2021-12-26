-- DROP   TABLE T3FOUR ;                                                00000100
--                                                                      00000200
-- *************************************************************        00000201
-- CREATION D'UNE TABLE T3FOUR                                          00000202
-- *************************************************************        00000203
--                                                                      00000204
   CREATE TABLE T3FOUR (                                                00000211
       IDFOUR  DEC(2)             NOT NULL,                             00000216
       NOMFOUR CHAR(20)                   ,                             00000217
       ADRFOUR CHAR(50)                   ,                             00000218
       PRIMARY KEY (IDFOUR)                                             00000219
                       )                                                00000220
                                                                        00000221
   IN DBMATE1.TSLEMA03                                                  00000223
                                                                        00000224
   ;                                                                    00000230
   CREATE UNIQUE INDEX                                                  00000240
      UXT3FOUR_ID                                                       00000250
      ON T3FOUR (IDFOUR)                                                00000260
   ;                                                                    00000270
   SELECT * FROM T3FOUR                                                 00000280
   ;                                                                    00000290
