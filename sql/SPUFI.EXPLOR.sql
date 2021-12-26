--                                                                      00000200
-- *************************************************************        00000201
-- SUITE DE COMMANDES POUR EXPLORER LES TABLES EXISTANTES               00000202
-- ET AUTRES EXPLORATIONS                                               00000203
-- *************************************************************        00000204
--                                                                      00000205
   SELECT * FROM SYSIBM.SYSTABLES                                       00000280
     WHERE CREATOR =    'ADCDA'                                        00000281
     ORDER BY NAME                                                      00000282
   ;                                                                    00000290
   SELECT NAME,PARENTS,CHILDREN FROM SYSIBM.SYSTABLES                   00000300
     WHERE CREATOR =    'ADCDA'                                        00000400
     ORDER BY NAME                                                      00000500
   ;                                                                    00000600
   SELECT * FROM SYSIBM.SYSKEYS                                         00000700
--   WHERE CREATOR =    'ADCDA'                                        00000800
--   ORDER BY NAME                                                      00000900
   ;                                                                    00001000
   SELECT * FROM SYSIBM.SYSINDEXES                                      00001100
     WHERE CREATOR =    'ADCDA'                                        00001200
     ORDER BY NAME                                                      00001300
   ;                                                                    00001400
   SELECT * FROM SYSIBM.SYSFOREIGNKEYS                                  00001500
     WHERE CREATOR =    'ADCDA'                                        00001600
--   ORDER BY NAME                                                      00001700
   ;                                                                    00001800
   SELECT * FROM SYSIBM.SYSCOLUMNS                                      00001900
--   WHERE CREATOR =    'ADCDA'                                        00002000
     ORDER BY NAME                                                      00002100
   ;                                                                    00002200
   SELECT * FROM SYSIBM.SYSVIEWS                                        00002300
--   WHERE CREATOR =    'ADCDA'                                        00002400
---  ORDER BY NAME                                                      00002500
   ;                                                                    00002600
   SELECT * FROM SYSIBM.SYSPLAN                                         00002700
--   WHERE CREATOR =    'ADCDA'                                        00002800
     ORDER BY NAME                                                      00002900
   ;                                                                    00003000
   SELECT * FROM SYSIBM.SYSTRIGGERS                                     00003100
--   WHERE CREATOR =    'ADCDA'                                        00003200
--   ORDER BY NAME                                                      00003300
   ;                                                                    00003400
