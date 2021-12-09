       IDENTIFICATION DIVISION.
       PROGRAM-ID. SP001.
      *****************************************************
      *      PROGRAMME PRINCIPAL                          *
      *                                                   *
      *      APPEL D'UN SOUS-PROGRAMME                    *
      *                                                   *
      *****************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID    PIC X(8) VALUE 'SP001'.
       LINKAGE SECTION.
       01  LS-LIEN.
          05  LS-RECU          PIC X(5).
          05  LS-CR            PIC X(2).
          05  LS-ENVOI         PIC X(50).
       PROCEDURE DIVISION USING LS-LIEN.
       0000-APPEL-DEB.
           DISPLAY 'CE SOUS-PROGRAMME NE LIT RIEN '
           DISPLAY 'IL N''ECRIT RIEN'
           DISPLAY 'IL EST APPELE PAR PROGRAMME'.
   
           IF LS-RECU  IS NUMERIC 
                MOVE "CETTE CHAINE EST NUMERIQUE" 	TO LS-ENVOI 
           ELSE 
               MOVE "CETTE CHAINE EST ALPHANUMERIQUE" 	TO LS-ENVOI 
           END-IF.
           DISPLAY WS-PROGRAM-ID  " VOUS DIT BYE " LS-LIEN.
 
           GOBACK.
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
