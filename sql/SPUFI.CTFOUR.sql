-- DROP   TABLE T3FOUR ;
--
-- *************************************************************
-- CREATION D'UNE TABLE T3FOUR
-- *************************************************************
--
   CREATE TABLE T3FOUR (
       IDFOUR  DEC(2)             NOT NULL,
       NOMFOUR CHAR(20)                   ,
       ADRFOUR CHAR(50)                   ,
       PRIMARY KEY (IDFOUR)
                       )

   IN DBMATE1.TSLEMA03

   ;
   CREATE UNIQUE INDEX
      UXT3FOUR_ID
      ON T3FOUR (IDFOUR)
   ;
   SELECT * FROM T3FOUR
   ;
