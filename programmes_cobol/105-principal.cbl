       IDENTIFICATION DIVISION.
       PROGRAM-ID. P22601.
      *****************************************************
      *      PROGRAMME PRINCIPAL                          *
      *                                                   *
      *      APPEL D'UN SOUS-PROGRAMME                    *
      *                                                   *
      *****************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID    PIC X(8) VALUE 'P22601'.
       01  WS-CHAINE1    PIC X(5)  VALUE ALL   "ABCD".
       01  WS-CHAINE2    PIC X(5)  VALUE ALL   "12334".
       01  WS-ZONE-APPEL.
          05  WS-ENVOI          PIC X(5).
          05  WS-CODE-RETOUR    PIC X(2).
          05  WS-REPONSE        PIC X(50).
       01     WS-SOUS-PROGRAMME   PIC X(8)  VALUE "SP001".	
       PROCEDURE DIVISION.
       0000-APPEL-DEB.
           DISPLAY 'BONJOUR TOUT LE MONDE'.
           DISPLAY 'CE PROGRAMME NE LIT RIEN '.
           DISPLAY 'IL APPELLE UN SOUS-PROGRAMME'.
           MOVE SPACE TO WS-ZONE-APPEL.
           MOVE WS-CHAINE1 TO WS-ENVOI .
           DISPLAY "AVANT APPEL : "  WS-ZONE-APPEL.
           CALL WS-SOUS-PROGRAMME USING WS-ZONE-APPEL.
           DISPLAY "APRES APPEL : "  WS-ZONE-APPEL
           DISPLAY " ".
           MOVE SPACE TO WS-ZONE-APPEL.
           MOVE WS-CHAINE2  	TO WS-ENVOI .
           DISPLAY "AVANT APPEL : "  WS-ZONE-APPEL
           CALL WS-SOUS-PROGRAMME USING WS-ZONE-APPEL.
           DISPLAY "APRES APPEL : "  WS-ZONE-APPEL
           STOP RUN.
       0000-APPEL-FIN.
           EXIT.
      *****************************************************
      *      STATISTIQUES                                 *
      *****************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '************************************'.
           DISPLAY 'DEBUT DU PROGRAMME '    WS-PROGRAM-ID.
           DISPLAY '************************************'.
       8910-DEB-STATISTIQUES-FIN.
           EXIT.
       8990-FIN-STATISTIQUES-DEB.
           DISPLAY '************************************'.
           DISPLAY 'STATISTIQUES DU PROGRAMME ' WS-PROGRAM-ID.
           DISPLAY '************************************'.
       8990-FIN-STATISTIQUES-FIN.
           EXIT.
      *****************************************************
      *      FIN ANORMALE                                 *
      *****************************************************
       9990-FIN-ANORMALE-DEB.
           DISPLAY '************************************'
           DISPLAY 'FIN ANORMALE DU PROGRAMME '    WS-PROGRAM-ID.
           DISPLAY '************************************'
           STOP RUN.
       9990-FIN-ANORMALE-FIN.
           EXIT.
      *****************************************************
      *      FIN NORMALE                                  *
      *****************************************************
       9999-FIN-ANORMALE-DEB.
           DISPLAY '************************************'
           DISPLAY 'FIN NORMALE DU PROGRAMME '    WS-PROGRAM-ID.
           DISPLAY '************************************'
           PERFORM  8990-FIN-STATISTIQUES-DEB
               THRU 8990-FIN-STATISTIQUES-FIN
           STOP RUN.
       9999-FIN-ANORMALE-FIN.
           EXIT.
