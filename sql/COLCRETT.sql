   SET CURRENT SQLID=USER;                                              00010000
--------------------                                                    00010100
--   DROP TABLE TCOLLABO;                                               00010223
--------------------                                                    00010300
   CREATE TABLE TCOLLABO(                                               00010420
      IDCOLL CHAR(2) NOT NULL,                                          00010500
          PRIMARY KEY (IDCOLL),                                         00010600
      NOM CHAR (5),                                                     00010707
      IDSUP CHAR(2))                                                    00010816
      IN ADCD01DB.ADCD$01;                                              00011700
-----------------------                                                 00011800
   COMMIT   ;                                                           00011919
-----------------------                                                 00012019
   CREATE UNIQUE INDEX                                                  00012119
     IXCOLL                                                             00012219
     ON TCOLLABO(IDCOLL);                                               00012320
--------------------                                                    00012419
   COMMIT   ;                                                           00012519
--------------------                                                    00012619
   GRANT ALL ON TABLE  TCOLLABO TO PUBLIC;                              00012720
--------------------                                                    00012819
   COMMIT   ;                                                           00012919
--------------------                                                    00013019
   SET CURRENT SQLID=USER;                                              00014021
--------------------                                                    00015021
   SELECT *                                                             00016021
   FROM  TCOLLABO ;                                                     00017021
