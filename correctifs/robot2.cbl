       IDENTIFICATION DIVISION.
       PROGRAM-ID. B30401.
      **********************************************************
      * EXERCICE 7                                             *
      *                                                        *
      * UN ROBOT PARCOURS UNE ALLEE DE 11 CASES                *
      *    PUIS S'EN RETOURNE SUR L'ALLEE D'A-COTEE            *
      *                                                        *
      * IL FAUT AFFICHER 1 ETOILE A CHAQUE PAS EFFECTUE        *
      * PAR EXEMPLE, POUR LE 1ER PAS A L'ALLER :               *
      *  SUR LA 1ERE LIGNE : *                                 *
      *  SUR LA 2EME LIGNE :                                   *
      *                                                        *
      *                                                        *
      * PAR EXEMPLE, POUR LE 5EME PAS A L'ALLER :              *
      *  SUR LA 1ERE LIGNE : *****                             *
      *  SUR LA 2EME LIGNE :                                   *
      *                                                        *
      * PAR EXEMPLE, POUR LE 5EME PAS AU RETOUR :              *
      *  SUR LA 1ERE LIGNE : **********                        *
      *  SUR LA 2EME LIGNE :      *****                        *
      *                                                        *
      *                                                        *
      **********************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROGRAM-ID  PIC X(8) VALUE 'B30401'.
       01 WS-PAS         PIC 99   VALUE ZERO.
       01 WS-ALLER.
          05 WS-DESTA    PIC X(3).
          05 WS-A1       PIC X.
          05 WS-A2       PIC X.
          05 WS-A3       PIC X.
          05 WS-A4       PIC X.
          05 WS-A5       PIC X.
          05 WS-A6       PIC X.
          05 WS-A7       PIC X.
          05 WS-A8       PIC X.
          05 WS-A9       PIC X.
          05 WS-A10      PIC X.
       01 WS-RETOUR.
          05 WS-DESTR    PIC X(3).
          05 WS-R10      PIC X.
          05 WS-R9       PIC X.
          05 WS-R8       PIC X.
          05 WS-R7       PIC X.
          05 WS-R6       PIC X.
          05 WS-R5       PIC X.
          05 WS-R4       PIC X.
          05 WS-R3       PIC X.
          05 WS-R2       PIC X.
          05 WS-R1       PIC X.
      **********************************************************
       PROCEDURE DIVISION.
       0000-INITIALISATION-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
             THRU  8910-DEB-STATISTIQUES-FIN
      *
           MOVE SPACE TO WS-ALLER
                         WS-RETOUR.
           MOVE '=> ' TO WS-DESTA.
           MOVE '<= ' TO WS-DESTR.
           PERFORM 1000-ALLER-DEB
              THRU 1000-ALLER-FIN
                10 TIMES.
      *
           PERFORM 1010-INIT-DEB
              THRU 1010-INIT-FIN
      *
           PERFORM 1020-RETOUR-DEB
              THRU 1020-RETOUR-FIN
                10 TIMES.
      *
           PERFORM 8990-FIN-STATISTIQUES-DEB
              THRU 8990-FIN-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.
       0000-INITIALISATION-FIN.
           EXIT.
       1000-ALLER-DEB.
           ADD 1 TO WS-PAS.
           EVALUATE WS-PAS
           WHEN  1
              MOVE '*' TO WS-A1
           WHEN 2
              MOVE '*' TO WS-A2
           WHEN 3
              MOVE '*' TO WS-A3
           WHEN 4
              MOVE '*' TO WS-A4
           WHEN 5
              MOVE '*' TO WS-A5
           WHEN 6
              MOVE '*' TO WS-A6
           WHEN 7
              MOVE '*' TO WS-A7
           WHEN 8
              MOVE '*' TO WS-A8
           WHEN 9
              MOVE '*' TO WS-A9
           WHEN 10
              MOVE '*' TO WS-A10
           END-EVALUATE.
           DISPLAY WS-ALLER.
           DISPLAY WS-RETOUR.
           DISPLAY ' '.
       1000-ALLER-FIN.
           EXIT.
       1010-INIT-DEB.
           MOVE 0  TO WS-PAS.
       1010-INIT-FIN.
           EXIT.
       1020-RETOUR-DEB.
           ADD 1 TO WS-PAS.
           IF WS-PAS = 1
              MOVE '*' TO WS-R1.
           IF WS-PAS = 2
              MOVE '*' TO WS-R2.
           IF WS-PAS = 3
              MOVE '*' TO WS-R3.
           IF WS-PAS = 4
              MOVE '*' TO WS-R4.
           IF WS-PAS = 5
              MOVE '*' TO WS-R5.
           IF WS-PAS = 6
              MOVE '*' TO WS-R6.
           IF WS-PAS = 7
              MOVE '*' TO WS-R7.
           IF WS-PAS = 8
              MOVE '*' TO WS-R8.
           IF WS-PAS = 9
              MOVE '*' TO WS-R9.
           IF WS-PAS = 10
              MOVE '*' TO WS-R10.
           DISPLAY WS-ALLER.
           DISPLAY WS-RETOUR.
           DISPLAY ' '.
       1020-RETOUR-FIN.
           EXIT.
      *****************************************************
      *       STATISTIQUES                                *
      *****************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'DEBUT DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           DISPLAY 'UN ROBOT PARCOURS UNE ALLEE DE 11 CASES         '.
           DISPLAY 'PUIS S''EN RETOURNE SUR L''ALLEE D''A-COTE '.
           DISPLAY '                                                '.
           DISPLAY 'IL FAUT AFFICHER 1 ETOILE A CHAQUE PAS EFFECTUE '.
           DISPLAY 'PAR EXEMPLE, POUR LE 1ER PAS A L''ALLER :        '.
           DISPLAY '    SUR LA 1ERE LIGNE : *                       '.
           DISPLAY '    SUR LA 2EME LIGNE :                         '.
           DISPLAY '                                                '.
           DISPLAY '                                                '.
           DISPLAY 'PAR EXEMPLE, POUR LE 5EME PAS A L''ALLER :       '.
           DISPLAY '    SUR LA 1ERE LIGNE : *****                   '.
           DISPLAY '    SUR LA 2EME LIGNE :                         '.
           DISPLAY '                                                '.
           DISPLAY 'PAR EXEMPLE, POUR LE 5EME PAS AU RETOUR :       '.
           DISPLAY '    SUR LA 1ERE LIGNE : **********              '.
           DISPLAY '    SUR LA 2EME LIGNE :      *****              '.
           DISPLAY '***********************************'.
       8910-DEB-STATISTIQUES-FIN.
           EXIT.
       8990-FIN-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'STATISTIQUES DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
       8990-FIN-STATISTIQUES-FIN.
           EXIT.
      *****************************************************
      *       FIN ANORMALE                                *
      *****************************************************
       9990-FIN-ANORMALE-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'FIN ANORMALE DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           STOP RUN.
       9990-FIN-ANORMALE-FIN.
           EXIT.
      *****************************************************
      *       FIN NORMALE                                 *
      *****************************************************
       9999-FIN-NORMALE-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'FIN NORMALE DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           STOP RUN.
       9999-FIN-NORMALE-FIN.
           EXIT.
