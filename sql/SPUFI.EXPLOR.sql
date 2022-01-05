--                                                                      
-- *************************************************************        
-- SUITE DE COMMANDES POUR EXPLORER LES TABLES EXISTANTES               
-- ET AUTRES EXPLORATIONS                                               
-- *************************************************************        
--                                                                      
   SELECT * FROM SYSIBM.SYSTABLES                                       
     WHERE CREATOR =    'ADCDA'                                        
     ORDER BY NAME                                                      
   ;                                                                    
   SELECT NAME,PARENTS,CHILDREN FROM SYSIBM.SYSTABLES                   
     WHERE CREATOR =    'ADCDA'                                        
     ORDER BY NAME                                                      
   ;                                                                    
   SELECT * FROM SYSIBM.SYSKEYS                                         
--   WHERE CREATOR =    'ADCDA'                                        
--   ORDER BY NAME                                                      
   ;                                                                    
   SELECT * FROM SYSIBM.SYSINDEXES                                      
     WHERE CREATOR =    'ADCDA'                                        
     ORDER BY NAME                                                      
   ;                                                                    
   SELECT * FROM SYSIBM.SYSFOREIGNKEYS                                  
     WHERE CREATOR =    'ADCDA'                                        
--   ORDER BY NAME                                                      
   ;                                                                    
   SELECT * FROM SYSIBM.SYSCOLUMNS                                      
--   WHERE CREATOR =    'ADCDA'                                        
     ORDER BY NAME                                                      
   ;                                                                    
   SELECT * FROM SYSIBM.SYSVIEWS                                        
--   WHERE CREATOR =    'ADCDA'                                        
---  ORDER BY NAME                                                      
   ;                                                                    
   SELECT * FROM SYSIBM.SYSPLAN                                         
--   WHERE CREATOR =    'ADCDA'                                        
     ORDER BY NAME                                                      
   ;                                                                    
   SELECT * FROM SYSIBM.SYSTRIGGERS                                     
--   WHERE CREATOR =    'ADCDA'                                        
--   ORDER BY NAME                                                      
   ;                                                                    
