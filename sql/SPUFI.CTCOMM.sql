   DROP   TABLE T3COMM ;                                                
   COMMIT              ;                                                
--                                                                      
-- *************************************************************        
-- CREATION D'UNE TABLE T3COMM                                          
-- *************************************************************        
--                                                                      
--                                                                      
   CREATE TABLE T3COMM (                                                
       IDCOMM   DEC(2)    NOT NULL ,                                    
       DATECOMM DATE      NOT NULL ,                                    
       DALICOMM DATE               ,                                    
       IDFOUR   DEC(2)             ,                                    
       PRIMARY KEY (IDCOMM)        ,                                    
       FOREIGN KEY FKCOMM1 (IDFOUR) REFERENCES T3FOUR                   
                                      ON DELETE RESTRICT                
                       )                                                
   IN DBMATE1.TSLEMA03                                                  
   ;                                                                    
   CREATE UNIQUE INDEX                                                  
      UXT3COMM_ID                                                       
      ON T3COMM (IDCOMM)                                                
   ;                                                                    
   SELECT * FROM T3COMM                                                 
   ;                                                                    
