       IDENTIFICATION DIVISION.                                         00010004
       PROGRAM-ID. SUDOKU.                                              00020004
                                                                        00021004
      *******************************************                       00021104
      *     PROJET SUDOKU  (AVEC DB2)           *                       00021204
      *       REMPLISSAGE DE LA GRILLE          *                       00021304
      *       AVEC LE PROGRAMME :               *                       00021404
      *******************************************                       00021504
      * RESOLUTION D'UNE GRILLE SUDOKU EN COBOL *                       00021604
      *          PAR METHODE D'ANALYSE          *                       00021704
      *    HORIZONTALE / VERTICALE / PAR CASE   *                       00021804
      *******************************************                       00021904
      *           AUTEUR : SIMON LEPLUS         *                       00022004
      *        DATE DE MODIF : 03/05/2017       *                       00022104
      *******************************************                       00022204
       ENVIRONMENT DIVISION.                                            00022304
       INPUT-OUTPUT SECTION.                                            00022404
      *******************************************                       00022504
       DATA DIVISION.                                                   00022604
      *******************************************                       00022704
       FILE SECTION.                                                    00022804
      *******************************************                       00022904
       WORKING-STORAGE SECTION.                                         00023004
      *******************************************                       00024004
      *ENREGISTREMENT*                                                  00025004
      *ZONES DE TRAVAIL*                                                00026004
       01    WS-NOM-PGM         PIC X(8) VALUE 'SUDOKU'.                00027004
       01    WS-MESSAGE         PIC X(80) VALUE SPACE.                  00028004
       01    WS-SQLCODE         PIC 9(6)  VALUE ZERO.                   00029004
       01    WS-HOR             PIC S99  COMP VALUE ZERO.               00030004
       01    WS-VER             PIC S99  COMP VALUE ZERO.               00040004
       01    WS-I               PIC S99  COMP VALUE ZERO.               00040104
       01    WS-POSS            PIC S99   COMP VALUE ZERO.              00040204
       01    WS-CARRE           PIC S99  COMP.                          00040304
       01    WS-CTR             PIC 9(3) VALUE ZERO.                    00040404
       01    WS-TEST1           PIC 9    COMP.                          00040504
       01    WS-TEST2           PIC 9    COMP.                          00040604
       01    WS-INSOLUBLE       PIC 99   VALUE ZERO.                    00040704
                                                                        00040804
      * EDITION                                                         00040904
                                                                        00041004
       01    WS-HOR-E           PIC Z9.                                 00041104
       01    WS-VER-E           PIC Z9.                                 00041204
       01    WS-I-E             PIC Z9.                                 00041304
                                                                        00041404
      *SQL*                                                             00041504
      *APPEL DES BASES DU LANGAGES SQL                                  00041604
           EXEC SQL                                                     00041704
              INCLUDE SQLCA                                             00041804
           END-EXEC.                                                    00041904
                                                                        00042004
      *APPEL DES BDD ULIS‚ES                                            00042104
           EXEC SQL                                                     00042204
              INCLUDE TPOSS                                             00042305
           END-EXEC.                                                    00042404
           EXEC SQL                                                     00042504
              INCLUDE TCASE                                             00042605
           END-EXEC.                                                    00042704
      ********************************************                      00042804
       PROCEDURE DIVISION.                                              00042904
      ********************************************                      00043004
       0000-PGM-DEB.                                                    00044004
                                                                        00044104
      *LANCEMENT DU PROGRAMME                                           00044204
           PERFORM 8910-DEBUT-PGM-DEB                                   00044304
              THRU 8910-DEBUT-PGM-FIN.                                  00044404
                                                                        00044504
      *ANALYSE DE LA GRILLE (AU MOINS 1 FOIS) SI POSSIBILIT‚ > 1        00044604
           PERFORM 1000-GRILLE-DEB                                      00044704
              THRU 1000-GRILLE-FIN                                      00044804
             UNTIL WS-MESSAGE NOT = 'OK'.                               00044904
                                                                        00045004
      *STATISTIQUES DE FIN DE PROGRAMME                                 00046004
           PERFORM 8999-STATISTIQUES-DEB                                00046104
              THRU 8999-STATISTIQUES-FIN.                               00046204
                                                                        00046304
      *ANNONCE DE FIN DE PROGRAMME SANS ERREUR RENCONTR‚E               00046404
           PERFORM 9990-FIN-NORMALE-DEB                                 00046504
              THRU 9990-FIN-NORMALE-FIN.                                00046604
                                                                        00046704
       0000-PGM-FIN.                                                    00046804
           EXIT.                                                        00046904
      **********************************************                    00047004
       1000-GRILLE-DEB.                                                 00048004
           DISPLAY '1000-GRILLE'.                                       00049004
      *INITIALISATION DE MOT D'INSOLUBILIT‚                             00050004
           MOVE ZERO TO WS-INSOLUBLE.                                   00060004
                                                                        00061004
      *INCR‚MENTATION DU COMPTEUR D'ANALYSE DE LA GRILLE                00062004
           ADD 1 TO WS-CTR.                                             00063004
                                                                        00064004
      *R‚INITIALISATION DU FLAG DE BOUCLE                               00065004
           MOVE SPACE TO WS-MESSAGE.                                    00066004
                                                                        00066104
      *ANALYSE PAR LIGNE                                                00066204
           PERFORM 2000-LIGNE-DEB                                       00066304
              THRU 2000-LIGNE-FIN                                       00066404
             UNTIL WS-HOR > 9.                                          00066504
                                                                        00066604
           IF WS-INSOLUBLE > 80                                         00066704
              DISPLAY "GRILLE INSOLUBLE AVEC CETTE METHODE"             00066804
              PERFORM 9999-FIN-ANOMALIE-DEB                             00066904
              THRU 9999-FIN-ANOMALIE-FIN.                               00067004
                                                                        00067104
       1000-GRILLE-FIN.                                                 00067204
           EXIT.                                                        00067304
      **********************************************                    00067404
       2000-LIGNE-DEB.                                                  00067504
           ADD 1 TO WS-HOR.                                             00067604
           PERFORM 7000-EDITION-DEB                                     00067704
              THRU 7000-EDITION-FIN.                                    00067804
      *    DISPLAY '2000-LIGNE'                                         00067904
      *            'WS-HOR : ' WS-HOR-E.                                00068004
                                                                        00068104
      *ANALYSE PAR COLONE                                               00068204
           PERFORM 3000-COLONE-DEB                                      00068304
              THRU 3000-COLONE-FIN                                      00068404
             UNTIL WS-VER > 9.                                          00068504
       2000-LIGNE-FIN.                                                  00068604
           EXIT.                                                        00068704
      **********************************************                    00068804
       3000-COLONE-DEB.                                                 00068904
           ADD 1 TO WS-VER.                                             00069004
           PERFORM 7000-EDITION-DEB                                     00069104
              THRU 7000-EDITION-FIN.                                    00069204
      *    DISPLAY '3000-COLONNE'                                       00069304
      *            'WS-VER : ' WS-VER-E.                                00069404
                                                                        00069504
      *RELEVE DU NOMBRE POSSIBILIT‚ DANS LA CASE CONSID‚R‚E             00069604
           PERFORM 6500-NB-POSSIBILITE-DEB                              00069704
              THRU 6500-NB-POSSIBILITE-FIN.                             00069804
                                                                        00069904
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00070004
           IF SQLCODE NOT = 0                                           00070104
              MOVE SQLCODE TO WS-SQLCODE                                00070204
              DISPLAY 'ANOMALIE SUR LE COMPTEUR POSSIBILITE '           00070304
                      'WS-SQLCODE : ' WS-SQLCODE                        00070404
              PERFORM 9999-FIN-ANOMALIE-DEB                             00070504
              THRU 9999-FIN-ANOMALIE-FIN                                00070604
           END-IF.                                                      00070704
                                                                        00070804
      *SI NOMBRE POSSIBILITE > 1 ALORS ON CHERCHE A DIMINUER CE NB      00070904
           IF WS-POSS > 1                                               00071004
                                                                        00071104
      *FLAG ENCLENCH‚                                                   00071204
              MOVE 'OK' TO WS-MESSAGE                                   00071304
                                                                        00071404
      *RECUP‚RATION DU CARRE CONSIDERE                                  00071504
              PERFORM 6510-RECUP-CARRE-DEB                              00071604
                 THRU 6510-RECUP-CARRE-FIN                              00071704
                                                                        00071804
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00071904
              IF SQLCODE NOT = 0                                        00072004
                 MOVE SQLCODE TO WS-SQLCODE                             00072104
                 DISPLAY 'ANOMALIE SUR LE RELEVE DU CARRE '             00072204
                         'WS-SQLCODE : ' WS-SQLCODE                     00072304
                 PERFORM 9999-FIN-ANOMALIE-DEB                          00072404
                 THRU 9999-FIN-ANOMALIE-FIN                             00072504
              END-IF                                                    00072604
              MOVE 0 TO WS-I                                            00072704
      *ANALYSE COMPARATIVE HORIZONTALE                                  00072804
              PERFORM 4000-REVUE-HORIZONTALE-DEB                        00072904
                 THRU 4000-REVUE-HORIZONTALE-FIN                        00073004
                    9 TIMES                                             00073104
                                                                        00073204
              MOVE 0 TO WS-I                                            00073304
      *ANALYSE COMPARATIVE VERTICALE                                    00073404
              PERFORM 4100-REVUE-VERTICALE-DEB                          00073504
                 THRU 4100-REVUE-VERTICALE-FIN                          00073604
                    9 TIMES                                             00073704
                                                                        00073804
              MOVE 0 TO WS-I                                            00073904
                                                                        00074004
      *ANALYSE COMPARATIVE PAR CARR‚                                    00074104
              PERFORM 4200-REVUE-CARRE-DEB                              00074204
                 THRU 4200-REVUE-CARRE-FIN                              00074304
                    9 TIMES                                             00074404
                                                                        00074504
      *MAJ DU NB POSSIBILIT‚ APRŠS ANALYSES                             00074604
              MOVE WS-POSS TO WS-TEST1                                  00074704
              PERFORM 6520-MAJ-NB-POSSIBILITE-DEB                       00074804
                 THRU 6520-MAJ-NB-POSSIBILITE-FIN                       00074904
                                                                        00075004
              PERFORM 6500-NB-POSSIBILITE-DEB                           00075104
                 THRU 6500-NB-POSSIBILITE-FIN                           00075204
              MOVE WS-POSS TO WS-TEST2                                  00075304
                                                                        00075404
              IF WS-TEST1 = WS-TEST2 AND WS-TEST1 > 1                   00075504
                 ADD 1 TO WS-INSOLUBLE                                  00075604
              END-IF                                                    00075704
           END-IF.                                                      00075804
                                                                        00075904
       3000-COLONE-FIN.                                                 00076004
           EXIT.                                                        00076104
      **********************************************                    00076204
       4000-REVUE-HORIZONTALE-DEB.                                      00076304
           ADD 1 TO WS-I.                                               00076404
           PERFORM 7000-EDITION-DEB                                     00076504
              THRU 7000-EDITION-FIN.                                    00076604
      *    DISPLAY '4000-REVUE-HORIZONTALE'                             00076704
      *            'WS-I : ' WS-I-E.                                    00076804
                                                                        00076904
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES HORIZONTALES00077004
           PERFORM 6530-VERIF-HORIZONTALE-DEB                           00077104
              THRU 6530-VERIF-HORIZONTALE-FIN.                          00077204
                                                                        00077304
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00077404
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100                     00077504
              MOVE SQLCODE TO WS-SQLCODE                                00077604
              DISPLAY 'ANOMALIE SUR LE DELETE DE LA REVUE HORIZONTALE'  00077704
                      'WS-SQLCODE : ' WS-SQLCODE                        00077804
              PERFORM 9999-FIN-ANOMALIE-DEB                             00077904
              THRU    9999-FIN-ANOMALIE-FIN                             00078004
              END-IF.                                                   00078104
                                                                        00078204
       4000-REVUE-HORIZONTALE-FIN.                                      00078304
           EXIT.                                                        00078404
      **********************************************                    00078504
       4100-REVUE-VERTICALE-DEB.                                        00078604
           ADD 1 TO WS-I.                                               00078704
           PERFORM 7000-EDITION-DEB                                     00078804
              THRU 7000-EDITION-FIN.                                    00078904
      *    DISPLAY '4100-REVUE-VERTICALE'                               00079004
      *            'WS-I : ' WS-I-E.                                    00079104
                                                                        00079204
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES VERTICALES  00079304
           PERFORM 6540-VERIF-VERTICALE-DEB                             00079404
              THRU 6540-VERIF-VERTICALE-FIN.                            00079504
                                                                        00079604
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00079704
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100                     00079804
              MOVE SQLCODE TO WS-SQLCODE                                00079904
              DISPLAY 'ANOMALIE SUR LE DELETE DE LA REVUE VERTICALE'    00080004
                      'WS-SQLCODE : ' WS-SQLCODE                        00080104
              PERFORM 9999-FIN-ANOMALIE-DEB                             00080204
              THRU    9999-FIN-ANOMALIE-FIN                             00080304
              END-IF.                                                   00080404
                                                                        00080504
       4100-REVUE-VERTICALE-FIN.                                        00080604
           EXIT.                                                        00080704
      **********************************************                    00080804
       4200-REVUE-CARRE-DEB.                                            00080904
           ADD 1 TO WS-I.                                               00081004
           PERFORM 7000-EDITION-DEB                                     00082004
              THRU 7000-EDITION-FIN.                                    00082104
      *    DISPLAY '4200-REVUE-CARRE'                                   00082204
      *            'WS-I : ' WS-I-E.                                    00082304
            EVALUATE TRUE                                               00082404
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 1     00082504
               WHEN WS-CARRE = 1                                        00082604
                    PERFORM 6550-VERIF-CARRE1-DEB                       00082704
                       THRU 6550-VERIF-CARRE1-FIN                       00082804
                                                                        00082904
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00083004
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00083104
                       MOVE SQLCODE TO WS-SQLCODE                       00083204
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 1'         00083304
                               'WS-SQLCODE : ' WS-SQLCODE               00083404
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00083504
                       THRU 9999-FIN-ANOMALIE-FIN                       00083604
                       END-IF                                           00083704
                                                                        00083804
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 2     00083904
               WHEN WS-CARRE = 2                                        00084004
                    PERFORM 6560-VERIF-CARRE2-DEB                       00084104
                       THRU 6560-VERIF-CARRE2-FIN                       00084204
                                                                        00084304
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00084404
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00084504
                       MOVE SQLCODE TO WS-SQLCODE                       00084604
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 2'         00084704
                               'WS-SQLCODE : ' WS-SQLCODE               00084804
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00084904
                       THRU 9999-FIN-ANOMALIE-FIN                       00085004
                       END-IF                                           00085104
                                                                        00085204
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 3     00085304
               WHEN WS-CARRE = 3                                        00085404
                    PERFORM 6570-VERIF-CARRE3-DEB                       00085504
                       THRU 6570-VERIF-CARRE3-FIN                       00085604
                                                                        00085704
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00085804
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00085904
                       MOVE SQLCODE TO WS-SQLCODE                       00086004
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 3'         00087004
                               'WS-SQLCODE : ' WS-SQLCODE               00088004
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00088104
                       THRU 9999-FIN-ANOMALIE-FIN                       00088204
                       END-IF                                           00088304
                                                                        00088404
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 4     00088504
               WHEN WS-CARRE = 4                                        00088604
                    PERFORM 6580-VERIF-CARRE4-DEB                       00088704
                       THRU 6580-VERIF-CARRE4-FIN                       00088804
                                                                        00088904
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00089004
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00090004
                       MOVE SQLCODE TO WS-SQLCODE                       00091004
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 4'         00091104
                               'WS-SQLCODE : ' WS-SQLCODE               00091204
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00091304
                       THRU 9999-FIN-ANOMALIE-FIN                       00091404
                       END-IF                                           00091504
                                                                        00091604
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 5     00091704
               WHEN WS-CARRE = 5                                        00091804
                    PERFORM 6590-VERIF-CARRE5-DEB                       00091904
                       THRU 6590-VERIF-CARRE5-FIN                       00092004
                                                                        00093004
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00093104
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00093204
                       MOVE SQLCODE TO WS-SQLCODE                       00093304
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 5'         00093404
                               'WS-SQLCODE : ' WS-SQLCODE               00093504
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00093604
                       THRU 9999-FIN-ANOMALIE-FIN                       00093704
                       END-IF                                           00093804
                                                                        00093904
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 6     00094004
               WHEN WS-CARRE = 6                                        00094104
                    PERFORM 6600-VERIF-CARRE6-DEB                       00094204
                       THRU 6600-VERIF-CARRE6-FIN                       00094304
                                                                        00094404
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00094504
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00094604
                       MOVE SQLCODE TO WS-SQLCODE                       00094704
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 6'         00094804
                               'WS-SQLCODE : ' WS-SQLCODE               00094904
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00095004
                       THRU 9999-FIN-ANOMALIE-FIN                       00096004
                       END-IF                                           00097004
                                                                        00097104
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 7     00097204
               WHEN WS-CARRE = 7                                        00097304
                    PERFORM 6610-VERIF-CARRE7-DEB                       00097404
                       THRU 6610-VERIF-CARRE7-FIN                       00097504
                                                                        00097604
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00097704
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00097804
                       MOVE SQLCODE TO WS-SQLCODE                       00097904
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 7'         00098004
                               'WS-SQLCODE : ' WS-SQLCODE               00099004
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00100004
                       THRU 9999-FIN-ANOMALIE-FIN                       00100104
                       END-IF                                           00100204
                                                                        00100304
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 8     00100404
               WHEN WS-CARRE = 8                                        00100504
                    PERFORM 6620-VERIF-CARRE8-DEB                       00100604
                       THRU 6620-VERIF-CARRE8-FIN                       00100704
                                                                        00100804
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00100904
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00101004
                       MOVE SQLCODE TO WS-SQLCODE                       00102004
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 8'         00102104
                               'WS-SQLCODE : ' WS-SQLCODE               00102204
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00102304
                       THRU 9999-FIN-ANOMALIE-FIN                       00102404
                       END-IF                                           00102504
                                                                        00102604
      *SUPPRESSION DES POSSIBILIT‚S EN FONCTION DES DONN‚ES CARRE 9     00102704
               WHEN WS-CARRE = 9                                        00102804
                    PERFORM 6630-VERIF-CARRE9-DEB                       00102904
                       THRU 6630-VERIF-CARRE9-FIN                       00103004
                                                                        00104004
      *SI ERREUR SQL => FIN DU PROGRAMME EN ANOMALIE                    00105004
                    IF SQLCODE NOT = 0 AND SQLCODE NOT = 100            00105104
                       MOVE SQLCODE TO WS-SQLCODE                       00105204
                       DISPLAY 'ANOMALIE SUR LE DELETE CARRE 9'         00105304
                               'WS-SQLCODE : ' WS-SQLCODE               00105404
                       PERFORM 9999-FIN-ANOMALIE-DEB                    00105504
                       THRU 9999-FIN-ANOMALIE-FIN                       00105604
                       END-IF                                           00105704
                                                                        00105804
           END-EVALUATE.                                                00105904
                                                                        00106004
       4200-REVUE-CARRE-FIN.                                            00106104
           EXIT.                                                        00106204
      **********************************************                    00106304
      *   6000-6499       GESTION FICHERS          *                    00106404
      **********************************************                    00106504
      **********************************************                    00106604
      *   6500-6999       SQL CODE                 *                    00106704
      **********************************************                    00106804
       6500-NB-POSSIBILITE-DEB.                                         00106904
           DISPLAY '6500    WS-POSS : ' WS-POSS                         00107004
                   'WS-I ' WS-I                                         00108004
                   'WS-HOR  ' WS-VER                                    00109004
                   'WS-VER  ' WS-HOR                                    00110004
                   'WS-CARRE ' WS-CARRE.                                00120004
           EXEC SQL                                                     00121004
               SELECT COUNT(VAL)                                        00122004
               INTO :WS-POSS                                            00122104
               FROM POSS                                                00122204
               WHERE HOR = :WS-HOR                                      00122304
               AND   VER = :WS-VER                                      00122404
           END-EXEC.                                                    00122504
           DISPLAY '6500    WS-POSS : ' WS-POSS                         00122604
                   'WS-I ' WS-I                                         00122704
                   'WS-HOR  ' WS-VER                                    00122804
                   'WS-VER  ' WS-HOR                                    00122904
                   'WS-CARRE ' WS-CARRE.                                00123004
       6500-NB-POSSIBILITE-FIN.                                         00123104
           EXIT.                                                        00123204
      **********************************************                    00123304
       6510-RECUP-CARRE-DEB.                                            00123404
           DISPLAY '6510 WS-CARRE : ' WS-CARRE                          00123504
                   'WS-POSS' WS-POSS                                    00123604
                   'WS-I ' WS-I                                         00123704
                   'WS-HOR  ' WS-VER                                    00123804
                   'WS-VER  ' WS-HOR.                                   00123904
              EXEC SQL                                                  00124004
                SELECT CARRE INTO :WS-CARRE                             00124104
                FROM CASE                                               00124204
                WHERE HOR = :WS-HOR                                     00124304
                AND   VER = :WS-VER                                     00124404
              END-EXEC.                                                 00124504
           DISPLAY '6510    WS-CARRE : ' WS-CARRE                       00124604
                   'WS-I ' WS-I                                         00124704
                   'WS-POSS ' WS-POSS                                   00124804
                   'WS-HOR  ' WS-VER                                    00124904
                   'WS-VER  ' WS-HOR.                                   00125004
       6510-RECUP-CARRE-FIN.                                            00125104
           EXIT.                                                        00125204
      **********************************************                    00125304
       6520-MAJ-NB-POSSIBILITE-DEB.                                     00125404
           DISPLAY '6520  WS-POSS : ' WS-POSS                           00125504
                   'WS-I ' WS-I                                         00125604
                   'WS-HOR  ' WS-VER                                    00125704
                   'WS-VER  ' WS-HOR                                    00125804
                   'WS-CARRE ' WS-CARRE.                                00125904
              EXEC SQL                                                  00126004
                UPDATE POSS                                             00126104
                SET NB = (                                              00126204
                          SELECT COUNT(VAL)                             00126304
                          FROM POSS                                     00126404
                          WHERE HOR = :WS-HOR                           00126504
                          AND   VER = :WS-VER                           00126604
                         )                                              00126704
                WHERE HOR = :WS-HOR                                     00126804
                AND VER = :WS-VER                                       00126904
              END-EXEC.                                                 00127004
           DISPLAY '6520    WS-POSS : ' WS-POSS                         00127104
                   'WS-I ' WS-I                                         00127204
                   'WS-HOR  ' WS-VER                                    00127304
                   'WS-VER  ' WS-HOR                                    00127404
                   'WS-CARRE ' WS-CARRE.                                00127504
       6520-MAJ-NB-POSSIBILITE-FIN.                                     00127604
           EXIT.                                                        00127704
      **********************************************                    00127804
       6530-VERIF-HORIZONTALE-DEB.                                      00127904
           DISPLAY '6530    WS-POSS : ' WS-POSS                         00128004
                   'WS-I ' WS-I                                         00128104
                   'WS-HOR  ' WS-VER                                    00128204
                   'WS-VER  ' WS-HOR                                    00128304
                   'WS-CARRE ' WS-CARRE.                                00128404
            EXEC SQL                                                    00128504
                DELETE FROM POSS                                        00128604
                       WHERE HOR = :WS-HOR                              00128704
                       AND   VER = :WS-VER                              00128804
                       AND   VAL = :WS-I                                00128904
                       AND   EXISTS (                                   00129004
                             SELECT *                                   00129104
                             FROM POSS                                  00129204
                             WHERE HOR != :WS-HOR                       00129304
                             AND   VER = :WS-VER                        00129404
                             AND   VAL = :WS-I                          00129504
                             AND   NB  = 1)                             00129604
            END-EXEC.                                                   00129704
           DISPLAY '6530    WS-POSS : ' WS-POSS                         00129804
                   'WS-I ' WS-I                                         00129904
                   'WS-HOR  ' WS-VER                                    00130004
                   'WS-VER  ' WS-HOR                                    00130104
                   'WS-CARRE ' WS-CARRE.                                00130204
       6530-VERIF-HORIZONTALE-FIN.                                      00130304
           EXIT.                                                        00130404
      **********************************************                    00130504
       6540-VERIF-VERTICALE-DEB.                                        00130604
           DISPLAY '6540    WS-POSS : ' WS-POSS                         00130704
                   'WS-I ' WS-I                                         00130804
                   'WS-HOR  ' WS-VER                                    00130904
                   'WS-VER  ' WS-HOR                                    00131004
                   'WS-CARRE ' WS-CARRE.                                00131104
            EXEC SQL                                                    00131204
                DELETE FROM POSS                                        00131304
                       WHERE HOR = :WS-HOR                              00131404
                       AND   VER = :WS-VER                              00131504
                       AND   VAL = :WS-I                                00131604
                       AND   EXISTS (                                   00131704
                             SELECT *                                   00131804
                             FROM POSS                                  00131904
                             WHERE HOR = :WS-HOR                        00132004
                             AND   VER != :WS-VER                       00132104
                             AND   VAL = :WS-I                          00132204
                             AND   NB  = 1)                             00132304
            END-EXEC.                                                   00132404
           DISPLAY '6540    WS-POSS : ' WS-POSS                         00132504
                   'WS-I ' WS-I                                         00132604
                   'WS-HOR  ' WS-VER                                    00132704
                   'WS-VER  ' WS-HOR                                    00132804
                   'WS-CARRE ' WS-CARRE.                                00132904
       6540-VERIF-VERTICALE-FIN.                                        00133004
           EXIT.                                                        00133104
                                                                        00133204
      **********************************************                    00133304
       6550-VERIF-CARRE1-DEB.                                           00133404
           DISPLAY '6550 WS-POSS ' WS-POSS                              00133504
                   'WS-I ' WS-I                                         00133604
                   'WS-HOR  ' WS-VER                                    00133704
                   'WS-VER  ' WS-HOR                                    00133804
                   'WS-CARRE ' WS-CARRE.                                00133904
                    EXEC SQL                                            00134004
                       DELETE FROM POSS                                 00134104
                       WHERE HOR = :WS-HOR                              00134204
                       AND   VER = :WS-VER                              00134304
                       AND   VAL = :WS-I                                00134404
                       AND   EXISTS (                                   00134504
                             SELECT *                                   00134604
                             FROM POSS                                  00134704
                             WHERE HOR != :WS-HOR                       00134804
                             AND   HOR > 0                              00134904
                             AND   HOR < 4                              00135004
                             AND   VER != :WS-VER                       00135104
                             AND   VER > 0                              00135204
                             AND   VER < 4                              00135304
                             AND   VAL = :WS-I                          00135404
                             AND   NB  = 1)                             00135504
                    END-EXEC.                                           00135604
           DISPLAY '6550 WS-POSS ' WS-POSS                              00135704
                   'WS-I ' WS-I                                         00135804
                   'WS-HOR  ' WS-VER                                    00135904
                   'WS-VER  ' WS-HOR                                    00136004
                   'WS-CARRE ' WS-CARRE.                                00136104
                                                                        00136204
       6550-VERIF-CARRE1-FIN.                                           00136304
           EXIT.                                                        00136404
                                                                        00136504
      **********************************************                    00136604
       6560-VERIF-CARRE2-DEB.                                           00136704
           DISPLAY '6560 WS-POSS ' WS-POSS                              00136804
                   'WS-I ' WS-I                                         00136904
                   'WS-HOR  ' WS-VER                                    00137004
                   'WS-VER  ' WS-HOR                                    00137104
                   'WS-CARRE ' WS-CARRE.                                00137204
                    EXEC SQL                                            00137304
                       DELETE FROM POSS                                 00137404
                       WHERE HOR = :WS-HOR                              00137504
                       AND   VER = :WS-VER                              00137604
                       AND   VAL = :WS-I                                00137704
                       AND   EXISTS (                                   00137804
                             SELECT *                                   00137904
                             FROM POSS                                  00138004
                             WHERE HOR != :WS-HOR                       00138104
                             AND   HOR > 3                              00138204
                             AND   HOR < 7                              00138304
                             AND   VER != :WS-VER                       00138404
                             AND   VER > 0                              00138504
                             AND   VER < 4                              00138604
                             AND   VAL = :WS-I                          00138704
                             AND   NB  = 1)                             00138804
                    END-EXEC.                                           00138904
           DISPLAY '6560 WS-POSS ' WS-POSS                              00139004
                   'WS-I ' WS-I                                         00139104
                   'WS-HOR  ' WS-VER                                    00139204
                   'WS-VER  ' WS-HOR                                    00139304
                   'WS-CARRE ' WS-CARRE.                                00139404
       6560-VERIF-CARRE2-FIN.                                           00139504
           EXIT.                                                        00139604
      **********************************************                    00139704
       6570-VERIF-CARRE3-DEB.                                           00139804
           DISPLAY '6570 WS-POSS ' WS-POSS                              00139904
                   'WS-I ' WS-I                                         00140004
                   'WS-HOR  ' WS-VER                                    00140104
                   'WS-VER  ' WS-HOR                                    00140204
                   'WS-CARRE ' WS-CARRE.                                00140304
                    EXEC SQL                                            00140404
                       DELETE FROM POSS                                 00140504
                       WHERE HOR = :WS-HOR                              00140604
                       AND   VER = :WS-VER                              00140704
                       AND   VAL = :WS-I                                00140804
                       AND   EXISTS (                                   00140904
                             SELECT *                                   00141004
                             FROM POSS                                  00141104
                             WHERE HOR != :WS-HOR                       00141204
                             AND   HOR > 6                              00141304
                             AND   HOR < 10                             00141404
                             AND   VER != :WS-VER                       00141504
                             AND   VER > 0                              00141604
                             AND   VER < 4                              00141704
                             AND   VAL = :WS-I                          00141804
                             AND   NB  = 1)                             00141904
                    END-EXEC.                                           00142004
           DISPLAY '6570 WS-POSS ' WS-POSS                              00142104
                   'WS-I ' WS-I                                         00142204
                   'WS-HOR  ' WS-VER                                    00142304
                   'WS-VER  ' WS-HOR                                    00142404
                   'WS-CARRE ' WS-CARRE.                                00142504
       6570-VERIF-CARRE3-FIN.                                           00142604
           EXIT.                                                        00142704
      **********************************************                    00142804
       6580-VERIF-CARRE4-DEB.                                           00142904
           DISPLAY '6580 WS-POSS ' WS-POSS                              00143004
                   'WS-I ' WS-I                                         00143104
                   'WS-HOR  ' WS-VER                                    00143204
                   'WS-VER  ' WS-HOR                                    00143304
                   'WS-CARRE ' WS-CARRE.                                00143404
                    EXEC SQL                                            00143504
                       DELETE FROM POSS                                 00143604
                       WHERE HOR = :WS-HOR                              00143704
                       AND   VER = :WS-VER                              00143804
                       AND   VAL = :WS-I                                00143904
                       AND   EXISTS (                                   00144004
                             SELECT *                                   00144104
                             FROM POSS                                  00144204
                             WHERE HOR != :WS-HOR                       00144304
                             AND   HOR > 0                              00144404
                             AND   HOR < 4                              00144504
                             AND   VER != :WS-VER                       00144604
                             AND   VER > 3                              00144704
                             AND   VER < 7                              00144804
                             AND   VAL = :WS-I                          00144904
                             AND   NB  = 1)                             00145004
                    END-EXEC.                                           00145104
           DISPLAY '6580 WS-POSS ' WS-POSS                              00145204
                   'WS-I ' WS-I                                         00145304
                   'WS-HOR  ' WS-VER                                    00145404
                   'WS-VER  ' WS-HOR                                    00145504
                   'WS-CARRE ' WS-CARRE.                                00145604
       6580-VERIF-CARRE4-FIN.                                           00145704
           EXIT.                                                        00145804
      **********************************************                    00145904
       6590-VERIF-CARRE5-DEB.                                           00146004
           DISPLAY '6590 WS-POSS ' WS-POSS                              00146104
                   'WS-I ' WS-I                                         00146204
                   'WS-HOR  ' WS-VER                                    00146304
                   'WS-VER  ' WS-HOR                                    00146404
                   'WS-CARRE ' WS-CARRE.                                00146504
                    EXEC SQL                                            00146604
                       DELETE FROM POSS                                 00146704
                       WHERE HOR = :WS-HOR                              00146804
                       AND   VER = :WS-VER                              00146904
                       AND   VAL = :WS-I                                00147004
                       AND   EXISTS (                                   00147104
                             SELECT *                                   00147204
                             FROM POSS                                  00147304
                             WHERE HOR != :WS-HOR                       00147404
                             AND   HOR > 3                              00147504
                             AND   HOR < 7                              00147604
                             AND   VER != :WS-VER                       00147704
                             AND   VER > 3                              00147804
                             AND   VER < 7                              00147904
                             AND   VAL = :WS-I                          00148004
                             AND   NB  = 1)                             00148104
                    END-EXEC.                                           00148204
           DISPLAY '6590 WS-POSS ' WS-POSS                              00148304
                   'WS-I ' WS-I                                         00148404
                   'WS-HOR  ' WS-VER                                    00148504
                   'WS-VER  ' WS-HOR                                    00148604
                   'WS-CARRE ' WS-CARRE.                                00148704
       6590-VERIF-CARRE5-FIN.                                           00148804
           EXIT.                                                        00148904
      **********************************************                    00149004
       6600-VERIF-CARRE6-DEB.                                           00149104
           DISPLAY '6600 WS-POSS ' WS-POSS                              00149204
                   'WS-I ' WS-I                                         00149304
                   'WS-HOR  ' WS-VER                                    00149404
                   'WS-VER  ' WS-HOR                                    00149504
                   'WS-CARRE ' WS-CARRE.                                00149604
                    EXEC SQL                                            00149704
                       DELETE FROM POSS                                 00149804
                       WHERE HOR = :WS-HOR                              00149904
                       AND   VER = :WS-VER                              00150004
                       AND   VAL = :WS-I                                00150104
                       AND   EXISTS (                                   00150204
                             SELECT *                                   00150304
                             FROM POSS                                  00150404
                             WHERE HOR != :WS-HOR                       00150504
                             AND   HOR > 6                              00150604
                             AND   HOR < 10                             00150704
                             AND   VER != :WS-VER                       00150804
                             AND   VER > 3                              00150904
                             AND   VER < 7                              00151004
                             AND   VAL = :WS-I                          00151104
                             AND   NB  = 1)                             00151204
                    END-EXEC.                                           00151304
           DISPLAY '6600 WS-POSS ' WS-POSS                              00151404
                   'WS-I ' WS-I                                         00151504
                   'WS-HOR  ' WS-VER                                    00151604
                   'WS-VER  ' WS-HOR                                    00151704
                   'WS-CARRE ' WS-CARRE.                                00151804
       6600-VERIF-CARRE6-FIN.                                           00151904
           EXIT.                                                        00152004
      **********************************************                    00152104
       6610-VERIF-CARRE7-DEB.                                           00152204
           DISPLAY '6610 WS-POSS ' WS-POSS                              00152304
                   'WS-I ' WS-I                                         00152404
                   'WS-HOR  ' WS-VER                                    00152504
                   'WS-VER  ' WS-HOR                                    00152604
                   'WS-CARRE ' WS-CARRE.                                00152704
                    EXEC SQL                                            00152804
                       DELETE FROM POSS                                 00152904
                       WHERE HOR = :WS-HOR                              00153004
                       AND   VER = :WS-VER                              00153104
                       AND   VAL = :WS-I                                00153204
                       AND   EXISTS (                                   00153304
                             SELECT *                                   00153404
                             FROM POSS                                  00153504
                             WHERE HOR != :WS-HOR                       00153604
                             AND   HOR > 0                              00153704
                             AND   HOR < 4                              00153804
                             AND   VER != :WS-VER                       00153904
                             AND   VER > 6                              00154004
                             AND   VER < 10                             00154104
                             AND   VAL = :WS-I                          00154204
                             AND   NB  = 1)                             00154304
                    END-EXEC.                                           00154404
           DISPLAY '6610 WS-POSS ' WS-POSS                              00154504
                   'WS-I ' WS-I                                         00154604
                   'WS-HOR  ' WS-VER                                    00154704
                   'WS-VER  ' WS-HOR                                    00154804
                   'WS-CARRE ' WS-CARRE.                                00154904
       6610-VERIF-CARRE7-FIN.                                           00155004
           EXIT.                                                        00155104
      **********************************************                    00155204
       6620-VERIF-CARRE8-DEB.                                           00155304
           DISPLAY '6620 WS-POSS ' WS-POSS                              00155404
                   'WS-I ' WS-I                                         00155504
                   'WS-HOR  ' WS-VER                                    00155604
                   'WS-VER  ' WS-HOR                                    00155704
                   'WS-CARRE ' WS-CARRE.                                00155804
                    EXEC SQL                                            00155904
                       DELETE FROM POSS                                 00156004
                       WHERE HOR = :WS-HOR                              00156104
                       AND   VER = :WS-VER                              00156204
                       AND   VAL = :WS-I                                00156304
                       AND   EXISTS (                                   00156404
                             SELECT *                                   00156504
                             FROM POSS                                  00156604
                             WHERE HOR != :WS-HOR                       00156704
                             AND   HOR > 3                              00156804
                             AND   HOR < 7                              00156904
                             AND   VER != :WS-VER                       00157004
                             AND   VER > 6                              00157104
                             AND   VER < 10                             00157204
                             AND   VAL = :WS-I                          00157304
                             AND   NB  = 1)                             00157404
                    END-EXEC.                                           00157504
           DISPLAY '6620 WS-POSS ' WS-POSS                              00157604
                   'WS-I ' WS-I                                         00157704
                   'WS-HOR  ' WS-VER                                    00157804
                   'WS-VER  ' WS-HOR                                    00157904
                   'WS-CARRE ' WS-CARRE.                                00158004
       6620-VERIF-CARRE8-FIN.                                           00158104
           EXIT.                                                        00158204
      **********************************************                    00158304
       6630-VERIF-CARRE9-DEB.                                           00158404
           DISPLAY '6630 WS-POS ' WS-POSS                               00158504
                   'WS-I ' WS-I                                         00158604
                   'WS-HOR  ' WS-VER                                    00158704
                   'WS-VER  ' WS-HOR                                    00158804
                   'WS-CARRE ' WS-CARRE.                                00158904
                    EXEC SQL                                            00159004
                       DELETE FROM POSS                                 00159104
                       WHERE HOR = :WS-HOR                              00159204
                       AND   VER = :WS-VER                              00159304
                       AND   VAL = :WS-I                                00159404
                       AND   EXISTS (                                   00159504
                             SELECT *                                   00159604
                             FROM POSS                                  00159704
                             WHERE HOR != :WS-HOR                       00159804
                             AND   HOR > 6                              00159904
                             AND   HOR < 10                             00160004
                             AND   VER != :WS-VER                       00160104
                             AND   VER > 6                              00160204
                             AND   VER < 10                             00160304
                             AND   VAL = :WS-I                          00160404
                             AND   NB  = 1)                             00160504
                    END-EXEC.                                           00160604
           DISPLAY '6630 WS-POSS ' WS-POSS                              00160704
                   'WS-I ' WS-I                                         00160804
                   'WS-HOR  ' WS-VER                                    00160904
                   'WS-VER  ' WS-HOR                                    00161004
                   'WS-CARRE ' WS-CARRE.                                00161104
       6630-VERIF-CARRE9-FIN.                                           00161204
           EXIT.                                                        00161304
                                                                        00161404
       7000-EDITION-DEB.                                                00161504
           MOVE WS-VER TO WS-VER-E.                                     00161604
           MOVE WS-HOR TO WS-HOR-E.                                     00161704
           MOVE WS-I   TO WS-I-E.                                       00161804
       7000-EDITION-FIN.                                                00161904
           EXIT.                                                        00162004
                                                                        00162104
      **********************************************                    00162204
      *    8....  STATISTIQUES DU PROGRAMME        *                    00162304
      **********************************************                    00162404
                                                                        00162504
       8910-DEBUT-PGM-DEB.                                              00162604
           DISPLAY 'DEBUT DU PROGRAMME ' WS-NOM-PGM.                    00162704
       8910-DEBUT-PGM-FIN.                                              00162804
           EXIT.                                                        00162904
                                                                        00163004
       8999-STATISTIQUES-DEB.                                           00163104
           DISPLAY 'STATISTIQUES DU PROGRAMME ' WS-NOM-PGM.             00163204
       8999-STATISTIQUES-FIN.                                           00163304
           EXIT.                                                        00163404
                                                                        00163504
      **********************************************                    00163604
      *         FIN NORMALE DU PROGRAMME           *                    00163704
      **********************************************                    00163804
                                                                        00163904
       9990-FIN-NORMALE-DEB.                                            00164004
           DISPLAY 'FIN NORMALE DU PROGRAMME ' WS-NOM-PGM.              00164104
           DISPLAY 'GRILLE ANALYS‚E : ' WS-CTR ' FOIS.'                 00164204
           GOBACK.                                                      00164304
       9990-FIN-NORMALE-FIN.                                            00164404
           EXIT.                                                        00164504
                                                                        00164604
      **********************************************                    00164704
      *         FIN ANORMALE DU PROGRAMME          *                    00164804
      **********************************************                    00164904
                                                                        00165004
       9999-FIN-ANOMALIE-DEB.                                           00165104
           DISPLAY 'FIN ANORMALE DU PROGRAMME ' WS-NOM-PGM.             00165204
           MOVE 12 TO RETURN-CODE.                                      00165304
           GOBACK.                                                      00165404
       9999-FIN-ANOMALIE-FIN.                                           00165504
           EXIT.                                                        00165604
