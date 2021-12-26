   DROP   TABLE T3COMM ;                                                00000100
   COMMIT              ;                                                00000110
--                                                                      00000200
-- *************************************************************        00000201
-- CREATION D'UNE TABLE T3COMM                                          00000202
-- *************************************************************        00000203
--                                                                      00000204
--                                                                      00000210
   CREATE TABLE T3COMM (                                                00000211
       IDCOMM   DEC(2)    NOT NULL ,                                    00000216
       DATECOMM DATE      NOT NULL ,                                    00000217
       DALICOMM DATE               ,                                    00000218
       IDFOUR   DEC(2)             ,                                    00000219
       PRIMARY KEY (IDCOMM)        ,                                    00000221
       FOREIGN KEY FKCOMM1 (IDFOUR) REFERENCES T3FOUR                   00000222
                                      ON DELETE RESTRICT                00000223
                       )                                                00000226
   IN DBMATE1.TSLEMA03                                                  00000231
   ;                                                                    00000233
   CREATE UNIQUE INDEX                                                  00000240
      UXT3COMM_ID                                                       00000250
      ON T3COMM (IDCOMM)                                                00000260
   ;                                                                    00000270
   SELECT * FROM T3COMM                                                 00000280
   ;                                                                    00000290
