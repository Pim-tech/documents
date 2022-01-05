   DROP   TABLE T3LIGC ;
   COMMIT;
-- *************************************************************
-- CREATION D'UNE TABLE T3LIGC
-- *************************************************************
--
   CREATE TABLE T3LIGC (
       IDDEC    DEC(5)             NOT NULL,
       IDCOMM   DEC(2)             NOT NULL,
       QCOMLIGC DEC(5)             NOT NULL,

       PRIMARY KEY (IDDEC,IDCOMM)          ,
       FOREIGN KEY FKLIGC1 (IDDEC)  REFERENCES T3DECL
                                      ON DELETE RESTRICT,
       FOREIGN KEY FKLIGC2 (IDCOMM) REFERENCES T3COMM
                                      ON DELETE CASCADE
                       )

   IN DBMATE1.TSLEMA03

   ;
   CREATE UNIQUE INDEX
      IST3LIGCX_ID
      ON T3LIGC (IDDEC,IDCOMM)
   ;
   SELECT * FROM T3LIGC
   ;
