       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID. SUDOKU.                                             
                                                                        
      *******************************************                       
      *     PROJET SUDOKU  (AVEC DB2)           *                       
      *       REMPLISSAGE DE LA GRILLE          *                       
      *       AVEC LE PROGRAMME :               *                       
      *******************************************                       
      * RESOLUTION D'UNE GRILLE SUDOKU EN COBOL *                       
      *          PAR METHODE D'ANALYSE          *                       
      *    HORIZONTALE / VERTICALE / PAR CASE   *                       
      *******************************************                       
      *           AUTEUR : SIMON LEPLUS         *                       
      *        DATE DE MODIF : 03/05/2017       *                       
      *******************************************                       
       ENVIRONMENT DIVISION.                                            
       INPUT-OUTPUT SECTION.                                            
      *******************************************                       
       DATA DIVISION.                                                   
      *******************************************                       
       FILE SECTION.                                                    
      *******************************************                       
       WORKING-STORAGE SECTION.                                         
      *******************************************                       
      *ENREGISTREMENT*                                                  
      *ZONES DE TRAVAIL*                                                
       01    WS-NOM-PGM         PIC X(8) VALUE 'SUDOKU'.                
       01    WS-MESSAGE         PIC X(80) VALUE SPACE.                  
       01    WS-SQLCODE         PIC 9(6)  VALUE ZERO.                   
       01    WS-HOR             PIC S99  COMP VALUE ZERO.               
       01    WS-VER             PIC S99  COMP VALUE ZERO.               
       01    WS-I               PIC S99  COMP VALUE ZERO.               
       01    WS-POSS            PIC S99   COMP VALUE ZERO.              
       01    WS-CARRE           PIC S99  COMP.                          
       01    WS-CTR             PIC 9(3) VALUE ZERO.                    
       01    WS-TEST1           PIC 9    COMP.                          
       01    WS-TEST2           PIC 9    COMP.                          
       01    WS-INSOLUBLE       PIC 99   VALUE ZERO.                    
                                                                        
      * EDITION                                                         
                                                                        
       01    WS-HOR-E           PIC Z9.                                 
       01    WS-VER-E           PIC Z9.                                 
       01    WS-I-E             PIC Z9.                                 
                                                                        
      *SQL*                                                             
      *APPEL DES BASES DU LANGAGES SQL                                  
           EXEC SQL                                                     
              INCLUDE SQLCA                                             
           END-EXEC.                                                    
                                                                        
      *APPEL DES BDD ULIS‚ES                                            
           EXEC SQL                                                     
              INCLUDE TPOSS                                             
           END-EXEC.                                                    
           EXEC SQL                                                     
              INCLUDE TCASE                                             
           END-EXEC.                                                    
      ********************************************                      
       PROCEDURE DIVISION.                                              
      ********************************************                      
       0000-PGM-DEB.                                                    
                                                                        
      *LANCEMENT DU PROGRAMME                                           
           PERFORM 8910-DEBUT-PGM-DEB                                   
              THRU 8910-DEBUT-PGM-FIN.                                  
                                                                        
      *ANALYSE DE LA GRILLE (AU MOINS 1 FOIS) SI POSSIBILIT‚ > 1        
           PERFORM 1000-GRILLE-DEB                                      
              THRU 1000-GRILLE-FIN                                      
             UNTIL WS-MESSAGE NOT = 'OK'.                               
                                                                        
      *STATISTIQUES DE FIN DE PROGRAMME                                 
           PERFORM 8999-STATISTIQUES-DEB                                
              THRU 8999-STATISTIQUES-FIN.                               
                                                                        
      *ANNONCE DE FIN DE PROGRAMME SANS ERREUR RENCONTR‚E               
           PERFORM 9990-FIN-NORMALE-DEB                                 
              THRU 9990-FIN-NORMALE-FIN.                                
                                                                        
       0000-PGM-FIN.                                                    
           EXIT.                                                        
      **********************************************                    
       1000-GRILLE-DEB.                                                 
           DISPLAY '1000-GRILLE'.                                       
      *INITIALISATION DE MOT D'INSOLUBILIT‚                             
           MOVE ZERO TO WS-INSOLUBLE.                                   
                                                                        
      *INCR‚MENTATION DU COMPTEUR D'ANALYSE DE LA GRILLE                
           ADD 1 TO WS-CTR.                                             
                                                                        
      *R‚INITIALISATION DU FLAG DE BOUCLE                               
           MOVE SPACE TO WS-MESSAGE.                                    
                                                                        
      *ANALYSE PAR LIGNE                                                
           PERFORM 2000-LIGNE-DEB                                       
              THRU 2000-LIGNE-FIN                                       
             UNTIL WS-HOR > 9.                                          
                                                                        
           IF WS-INSOLUBLE > 80                                         
              DISPLAY "GRILLE INSOLUBLE AVEC CETTE METHODE"             
              PERFORM 9999-FIN-ANOMALIE-DEB                             
              THRU 9999-FIN-ANOMALIE-FIN.                               
                                                                        
       1000-GRILLE-FIN.                                                 
           EXIT.                                                        
      **********************************************                    
       2000-LIGNE-DEB.                                                  
           ADD 1 TO WS-HOR.                                             
           PERFORM 7000-EDITION-DEB                                     
              THRU 7000-EDITION-FIN.                                    
      *    DISPLAY '2000-LIGNE'                                         
      *            'WS-HOR : ' WS-HOR-E.                                
                                                                        
      *ANALYSE PAR COLONE                                               
           PERFORM 3000-COLONE-DEB                                      
              THRU 3000-COLONE-FIN                                      
             UNTIL WS-VER > 9.                                          
       2000-LIGNE-FIN.                                                  
           EXIT.                                                        
      **********************************************                    
       3000-COLONE-DEB.                                                 
           ADD 1 TO WS-VER.                                             
           PERFORM 7000-EDITION-DEB                                     
              THRU 7000-EDITION-FIN.                                    
      *    DISPLAY '3000-COLONNE'                                       
      *            'WS-VER : ' WS-VER-E.                                
                                                                        
      *RELEVE DU NOMBRE POSSIBILIT‚ DANS LA CASE CONSID‚R‚E             
           PERFORM 6500-NB-POSSIBILITE-DEB                              
              THRU 6500-NB-POSSIBILITE-FIN.                             
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
           IF SQLCODE NOT = 0                                           
              MOVE SQLCODE TO WS-SQLCODE                                
              DISPLAY 'ANOMALIE SUR LE COMPTEUR POSSIBILITE '           
                      'WS-SQLCODE : ' WS-SQLCODE                        
              PERFORM 9999-FIN-ANOMALIE-DEB                             
              THRU 9999-FIN-ANOMALIE-FIN                                
           END-IF.                                                      
                                                                        
      *SI NOMBRE POSSIBILITE > 1 ALORS ON CHERCHE A DIMINUER CE NB      
           IF WS-POSS > 1                                               
                                                                        
      *FLAG ENCLENCH‚                                                   
              MOVE 'OK' TO WS-MESSAGE                                   
                                                                        
      *RECUP‚RATION DU CARRE CONSIDERE                                  
              PERFORM 6510-RECUP-CARRE-DEB                              
                 THRU 6510-RECUP-CARRE-FIN                              
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
              IF SQLCODE NOT = 0                                        
                 MOVE SQLCODE TO WS-SQLCODE                             
                 DISPLAY 'ANOMALIE SUR LE RELEVE DU CARRE '             
                         'WS-SQLCODE : ' WS-SQLCODE                     
                 PERFORM 9999-FIN-ANOMALIE-DEB                          
                 THRU 9999-FIN-ANOMALIE-FIN                             
              END-IF                                                    
              MOVE 0 TO WS-I                                            
      *ANALYSE COMPARATIVE HORIZONTALE                                  
              PERFORM 4000-REVUE-HORIZONTALE-DEB                        
                 THRU 4000-REVUE-HORIZONTALE-FIN                        
                    9 TIMES                                             
                                                                        
              MOVE 0 TO WS-I                                            
      *ANALYSE COMPARATIVE VERTICALE                                    
              PERFORM 4100-REVUE-VERTICALE-DEB                          
                 THRU 4100-REVUE-VERTICALE-FIN                          
                    9 TIMES                                             
                                                                        
              MOVE 0 TO WS-I                                            
                                                                        
      *ANALYSE COMPARATIVE PAR CARR‚                                    
              PERFORM 4200-REVUE-CARRE-DEB                              
                 THRU 4200-REVUE-CARRE-FIN                              
                    9 TIMES                                             
                                                                        
      *MAJ DU NB POSSIBILIT‚ APRŠS ANALYSES                             
              MOVE WS-POSS TO WS-TEST1                                  
              PERFORM 6520-MAJ-NB-POSSIBILITE-DEB                       
                 THRU 6520-MAJ-NB-POSSIBILITE-FIN                       
                                                                        
              PERFORM 6500-NB-POSSIBILITE-DEB                           
                 THRU 6500-NB-POSSIBILITE-FIN                           
              MOVE WS-POSS TO WS-TEST2                                  
                                                                        
              IF WS-TEST1 = WS-TEST2 AND WS-TEST1 > 1                   
                 ADD 1 TO WS-INSOLUBLE                                  
              END-IF                                                    
           END-IF.                                                      
                                                                        
       3000-COLONE-FIN.                                                 
           EXIT.                                                        
      **********************************************                    
       4000-REVUE-HORIZONTALE-DEB.                                      
           ADD 1 TO WS-I.                                               
           PERFORM 7000-EDITION-DEB                                     
              THRU 7000-EDITION-FIN.                                    
      *    DISPLAY '4000-REVUE-HORIZONTALE'                             
      *            'WS-I : ' WS-I-E.                                    
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES HORIZONTALES
           PERFORM 6530-VERIF-HORIZONTALE-DEB                           
              THRU 6530-VERIF-HORIZONTALE-FIN.                          
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100                     
              MOVE SQLCODE TO WS-SQLCODE                                
              DISPLAY 'ANOMALIE SUR LE DELETE DE LA REVUE HORIZONTALE'  
                      'WS-SQLCODE : ' WS-SQLCODE                        
              PERFORM 9999-FIN-ANOMALIE-DEB                             
              THRU    9999-FIN-ANOMALIE-FIN                             
              END-IF.                                                   
                                                                        
       4000-REVUE-HORIZONTALE-FIN.                                      
           EXIT.                                                        
      **********************************************                    
       4100-REVUE-VERTICALE-DEB.                                        
           ADD 1 TO WS-I.                                               
           PERFORM 7000-EDITION-DEB                                     
              THRU 7000-EDITION-FIN.                                    
      *    DISPLAY '4100-REVUE-VERTICALE'                               
      *            'WS-I : ' WS-I-E.                                    
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES VERTICALES  
           PERFORM 6540-VERIF-VERTICALE-DEB                             
              THRU 6540-VERIF-VERTICALE-FIN.                            
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100                     
              MOVE SQLCODE TO WS-SQLCODE                                
              DISPLAY 'ANOMALIE SUR LE DELETE DE LA REVUE VERTICALE'    
                      'WS-SQLCODE : ' WS-SQLCODE                        
              PERFORM 9999-FIN-ANOMALIE-DEB                             
              THRU    9999-FIN-ANOMALIE-FIN                             
              END-IF.                                                   
                                                                        
       4100-REVUE-VERTICALE-FIN.                                        
           EXIT.                                                        
      **********************************************                    
       4200-REVUE-CARRE-DEB.                                            
           ADD 1 TO WS-I.                                               
           PERFORM 7000-EDITION-DEB                                     
              THRU 7000-EDITION-FIN.                                    
      *    DISPLAY '4200-REVUE-CARRE'                                   
      *            'WS-I : ' WS-I-E.                                    
            EVALUATE TRUE                                               
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 1     
               WHEN WS-CARRE = 1                                        
                    PERFORM 6550-VERIF-CARRE1-DEB                       
                       THRU 6550-VERIF-CARRE1-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 1'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 2     
               WHEN WS-CARRE = 2                                        
                    PERFORM 6560-VERIF-CARRE2-DEB                       
                       THRU 6560-VERIF-CARRE2-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 2'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 3     
               WHEN WS-CARRE = 3                                        
                    PERFORM 6570-VERIF-CARRE3-DEB                       
                       THRU 6570-VERIF-CARRE3-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 3'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 4     
               WHEN WS-CARRE = 4                                        
                    PERFORM 6580-VERIF-CARRE4-DEB                       
                       THRU 6580-VERIF-CARRE4-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 4'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 5     
               WHEN WS-CARRE = 5                                        
                    PERFORM 6590-VERIF-CARRE5-DEB                       
                       THRU 6590-VERIF-CARRE5-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 5'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 6     
               WHEN WS-CARRE = 6                                        
                    PERFORM 6600-VERIF-CARRE6-DEB                       
                       THRU 6600-VERIF-CARRE6-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 6'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 7     
               WHEN WS-CARRE = 7                                        
                    PERFORM 6610-VERIF-CARRE7-DEB                       
                       THRU 6610-VERIF-CARRE7-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 7'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 8     
               WHEN WS-CARRE = 8                                        
                    PERFORM 6620-VERIF-CARRE8-DEB                       
                       THRU 6620-VERIF-CARRE8-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 8'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 9     
               WHEN WS-CARRE = 9                                        
                    PERFORM 6630-VERIF-CARRE9-DEB                       
                       THRU 6630-VERIF-CARRE9-FIN                       
                                                                        
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            
                       MOVE SQLCODE TO WS-SQLCODE                       
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 9'         
                               'WS-SQLCODE : ' WS-SQLCODE               
                       PERFORM 9999-FIN-ANOMALIE-DEB                    
                       THRU 9999-FIN-ANOMALIE-FIN                       
                       END-IF                                           
                                                                        
           END-EVALUATE.                                                
                                                                        
       4200-REVUE-CARRE-FIN.                                            
           EXIT.                                                        
      **********************************************                    
      *   6000-6499       GESTION FICHERS          *                    
      **********************************************                    
      **********************************************                    
      *   6500-6999       SQL CODE                 *                    
      **********************************************                    
       6500-NB-POSSIBILITE-DEB.                                         
           DISPLAY '6500    WS-POSS : ' WS-POSS                         
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
           EXEC SQL                                                     
               SELECT COUNT(VAL)                                        
               INTO :WS-POSS                                            
               FROM POSS                                                
               WHERE HOR = :WS-HOR                                      
               AND   VER = :WS-VER                                      
           END-EXEC.                                                    
           DISPLAY '6500    WS-POSS : ' WS-POSS                         
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6500-NB-POSSIBILITE-FIN.                                         
           EXIT.                                                        
      **********************************************                    
       6510-RECUP-CARRE-DEB.                                            
           DISPLAY '6510 WS-CARRE : ' WS-CARRE                          
                   'WS-POSS' WS-POSS                                    
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR.                                   
              EXEC SQL                                                  
                SELECT CARRE INTO :WS-CARRE                             
                FROM CASE                                               
                WHERE HOR = :WS-HOR                                     
                AND   VER = :WS-VER                                     
              END-EXEC.                                                 
           DISPLAY '6510    WS-CARRE : ' WS-CARRE                       
                   'WS-I ' WS-I                                         
                   'WS-POSS ' WS-POSS                                   
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR.                                   
       6510-RECUP-CARRE-FIN.                                            
           EXIT.                                                        
      **********************************************                    
       6520-MAJ-NB-POSSIBILITE-DEB.                                     
           DISPLAY '6520  WS-POSS : ' WS-POSS                           
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
              EXEC SQL                                                  
                UPDATE POSS                                             
                SET NB = (                                              
                          SELECT COUNT(VAL)                             
                          FROM POSS                                     
                          WHERE HOR = :WS-HOR                           
                          AND   VER = :WS-VER                           
                         )                                              
                WHERE HOR = :WS-HOR                                     
                AND VER = :WS-VER                                       
              END-EXEC.                                                 
           DISPLAY '6520    WS-POSS : ' WS-POSS                         
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6520-MAJ-NB-POSSIBILITE-FIN.                                     
           EXIT.                                                        
      **********************************************                    
       6530-VERIF-HORIZONTALE-DEB.                                      
           DISPLAY '6530    WS-POSS : ' WS-POSS                         
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
            EXEC SQL                                                    
                DELETE FROM POSS                                        
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   VER = :WS-VER                        
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
            END-EXEC.                                                   
           DISPLAY '6530    WS-POSS : ' WS-POSS                         
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6530-VERIF-HORIZONTALE-FIN.                                      
           EXIT.                                                        
      **********************************************                    
       6540-VERIF-VERTICALE-DEB.                                        
           DISPLAY '6540    WS-POSS : ' WS-POSS                         
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
            EXEC SQL                                                    
                DELETE FROM POSS                                        
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR = :WS-HOR                        
                             AND   VER != :WS-VER                       
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
            END-EXEC.                                                   
           DISPLAY '6540    WS-POSS : ' WS-POSS                         
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6540-VERIF-VERTICALE-FIN.                                        
           EXIT.                                                        
                                                                        
      **********************************************                    
       6550-VERIF-CARRE1-DEB.                                           
           DISPLAY '6550 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 0                              
                             AND   HOR < 4                              
                             AND   VER != :WS-VER                       
                             AND   VER > 0                              
                             AND   VER < 4                              
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6550 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                                                                        
       6550-VERIF-CARRE1-FIN.                                           
           EXIT.                                                        
                                                                        
      **********************************************                    
       6560-VERIF-CARRE2-DEB.                                           
           DISPLAY '6560 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 3                              
                             AND   HOR < 7                              
                             AND   VER != :WS-VER                       
                             AND   VER > 0                              
                             AND   VER < 4                              
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6560 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6560-VERIF-CARRE2-FIN.                                           
           EXIT.                                                        
      **********************************************                    
       6570-VERIF-CARRE3-DEB.                                           
           DISPLAY '6570 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 6                              
                             AND   HOR < 10                             
                             AND   VER != :WS-VER                       
                             AND   VER > 0                              
                             AND   VER < 4                              
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6570 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6570-VERIF-CARRE3-FIN.                                           
           EXIT.                                                        
      **********************************************                    
       6580-VERIF-CARRE4-DEB.                                           
           DISPLAY '6580 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 0                              
                             AND   HOR < 4                              
                             AND   VER != :WS-VER                       
                             AND   VER > 3                              
                             AND   VER < 7                              
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6580 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6580-VERIF-CARRE4-FIN.                                           
           EXIT.                                                        
      **********************************************                    
       6590-VERIF-CARRE5-DEB.                                           
           DISPLAY '6590 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 3                              
                             AND   HOR < 7                              
                             AND   VER != :WS-VER                       
                             AND   VER > 3                              
                             AND   VER < 7                              
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6590 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6590-VERIF-CARRE5-FIN.                                           
           EXIT.                                                        
      **********************************************                    
       6600-VERIF-CARRE6-DEB.                                           
           DISPLAY '6600 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 6                              
                             AND   HOR < 10                             
                             AND   VER != :WS-VER                       
                             AND   VER > 3                              
                             AND   VER < 7                              
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6600 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6600-VERIF-CARRE6-FIN.                                           
           EXIT.                                                        
      **********************************************                    
       6610-VERIF-CARRE7-DEB.                                           
           DISPLAY '6610 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 0                              
                             AND   HOR < 4                              
                             AND   VER != :WS-VER                       
                             AND   VER > 6                              
                             AND   VER < 10                             
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6610 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6610-VERIF-CARRE7-FIN.                                           
           EXIT.                                                        
      **********************************************                    
       6620-VERIF-CARRE8-DEB.                                           
           DISPLAY '6620 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 3                              
                             AND   HOR < 7                              
                             AND   VER != :WS-VER                       
                             AND   VER > 6                              
                             AND   VER < 10                             
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6620 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6620-VERIF-CARRE8-FIN.                                           
           EXIT.                                                        
      **********************************************                    
       6630-VERIF-CARRE9-DEB.                                           
           DISPLAY '6630 WS-POS ' WS-POSS                               
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
                    EXEC SQL                                            
                       DELETE FROM POSS                                 
                       WHERE HOR = :WS-HOR                              
                       AND   VER = :WS-VER                              
                       AND   VAL = :WS-I                                
                       AND   EXISTS (                                   
                             SELECT *                                   
                             FROM POSS                                  
                             WHERE HOR != :WS-HOR                       
                             AND   HOR > 6                              
                             AND   HOR < 10                             
                             AND   VER != :WS-VER                       
                             AND   VER > 6                              
                             AND   VER < 10                             
                             AND   VAL = :WS-I                          
                             AND   NB  = 1)                             
                    END-EXEC.                                           
           DISPLAY '6630 WS-POSS ' WS-POSS                              
                   'WS-I ' WS-I                                         
                   'WS-HOR  ' WS-VER                                    
                   'WS-VER  ' WS-HOR                                    
                   'WS-CARRE ' WS-CARRE.                                
       6630-VERIF-CARRE9-FIN.                                           
           EXIT.                                                        
                                                                        
       7000-EDITION-DEB.                                                
           MOVE WS-VER TO WS-VER-E.                                     
           MOVE WS-HOR TO WS-HOR-E.                                     
           MOVE WS-I   TO WS-I-E.                                       
       7000-EDITION-FIN.                                                
           EXIT.                                                        
                                                                        
      **********************************************                    
      *    8....  STATISTIQUES DU PROGRAMME        *                    
      **********************************************                    
                                                                        
       8910-DEBUT-PGM-DEB.                                              
           DISPLAY 'DEBUT DU PROGRAMME ' WS-NOM-PGM.                    
       8910-DEBUT-PGM-FIN.                                              
           EXIT.                                                        
                                                                        
       8999-STATISTIQUES-DEB.                                           
           DISPLAY 'STATISTIQUES DU PROGRAMME ' WS-NOM-PGM.             
       8999-STATISTIQUES-FIN.                                           
           EXIT.                                                        
                                                                        
      **********************************************                    
      *         FIN NORMALE DU PROGRAMME           *                    
      **********************************************                    
                                                                        
       9990-FIN-NORMALE-DEB.                                            
           DISPLAY 'FIN NORMALE DU PROGRAMME ' WS-NOM-PGM.              
           DISPLAY 'GRILLE ANALYS‚E : ' WS-CTR ' FOIS.'                
           GOBACK.                                                      
       9990-FIN-NORMALE-FIN.                                            
           EXIT.                                                        
                                                                        
      **********************************************                    
      *         FIN ANORMALE DU PROGRAMME          *                    
      **********************************************                    
                                                                        
       9999-FIN-ANOMALIE-DEB.                                           
           DISPLAY 'FIN ANORMALE DU PROGRAMME ' WS-NOM-PGM.             
           MOVE 12 TO RETURN-CODE.                                      
           GOBACK.                                                      
       9999-FIN-ANOMALIE-FIN.                                           
           EXIT.                                                        
