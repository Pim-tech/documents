       IDENTIFICATION DIVISION.
       PROGRAM-ID. B22801.
      *****************************************************
      * EXERCICE : 3                                      *
      *                                                   *
      *   LIRE UNE LISTE DE NOMBRES                       *
      *      ET CHERCHER LE PLUS PETIT                    *
      *                                                   *
      *   LA LECTURE SE FAIT PAR ACCEPT                   *
      *   LE NOMBRE 999 LU INDIQUE LA FIN DE FICHIER      *
      *   IL NE FAUT PAS LE TRAITER                       *
      *                                                   *
      *****************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROGRAM-ID  PIC X(8) VALUE 'B22801'.
       01 WS-NOMBRE      PIC 999.
       01 WS-MIN         PIC 999.
      *****************************************************
       PROCEDURE DIVISION.
       0000-NOMBRE-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.

           ACCEPT WS-NOMBRE.
           MOVE   WS-NOMBRE     TO WS-MIN.
           PERFORM 1000-COMPARAISON-DEB
              THRU 1000-COMPARAISON-FIN
             UNTIL WS-NOMBRE = 999.

           PERFORM 8990-FIN-STATISTIQUES-DEB
              THRU 8990-FIN-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.
       0000-NOMBRE-FIN.
           EXIT.
       1000-COMPARAISON-DEB.
           IF WS-NOMBRE < WS-MIN
              PERFORM 2000-PETIT-DEB
                 THRU 2000-PETIT-FIN
           END-IF.
           ACCEPT WS-NOMBRE.
       1000-COMPARAISON-FIN.
           EXIT.
       2000-PETIT-DEB.
           MOVE WS-NOMBRE TO WS-MIN.
           DISPLAY 'LE PLUS PETIT NOMBRE LU EST ' WS-MIN.
       2000-PETIT-FIN.
           EXIT.
      *****************************************************
      *       STATISTIQUES                                *
      *****************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'DEBUT DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           DISPLAY 'LIRE UNE LISTE DE NOMBRES                  '.
           DISPLAY 'ET CHERCHER LE PLUS PETIT                  '.
           DISPLAY '                                           '.
           DISPLAY 'LA LECTURE SE FAIT PAR ACCEPT              '.
           DISPLAY 'LE NOMBRE 999 LU INDIQUE LA FIN DE FICHIER '.
           DISPLAY 'IL NE FAUT PAS LE TRAITER                  '.
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
