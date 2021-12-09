       IDENTIFICATION DIVISION.
       PROGRAM-ID. B30101.
      *****************************************************
      * EXERCICE : 4                                      *
      *                                                   *
      * LIRE UNE LISTE DE NOMBRES                         *
      * ET CHERCHER LE MINIMUM                            *
      *          ET LE MAXIMUM                            *
      *                                                   *
      * LA LISTE CONTIENT AU MOINS UN NOMBRE              *
      * LA LECTURE SE FAIT PAR ACCEPT                     *
      * LE NOMBRE 999 INDIQUE LA FIN DE LISTE             *
      * IL NE DOIT PAS ETRE PRIS EN COMPTE                *
      *                                                   *
      *****************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROGRAM-ID  PIC X(8) VALUE 'B30101'.
       01 WS-NOMBRE      PIC 999.
       01 WS-MIN         PIC 999.
       01 WS-MAX         PIC 999.
      *****************************************************
       PROCEDURE DIVISION.
       0000-NOMBRE-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.
      *
           ACCEPT WS-NOMBRE.
           MOVE WS-NOMBRE TO WS-MIN
                             WS-MAX.
           PERFORM 1000-COMPARAISON-DEB
              THRU 1000-COMPARAISON-FIN
             UNTIL WS-NOMBRE = 999.
           DISPLAY 'LE PLUS PETIT NOMBRE LU  ' WS-MIN.
           DISPLAY 'LE PLUS GRAND NOMBRE LU  ' WS-MAX.
      *
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
           IF WS-NOMBRE > WS-MAX
              PERFORM 2010-GRAND-DEB
                 THRU 2010-GRAND-FIN
           END-IF.
           ACCEPT WS-NOMBRE.
       1000-COMPARAISON-FIN.
           EXIT.
       2000-PETIT-DEB.
           MOVE WS-NOMBRE TO WS-MIN.
       2000-PETIT-FIN.
           EXIT.
       2010-GRAND-DEB.
           MOVE WS-NOMBRE TO WS-MAX.
       2010-GRAND-FIN.
           EXIT.
      *****************************************************
      *       STATISTIQUES                                *
      *****************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'DEBUT DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           DISPLAY 'LIRE UNE LISTE DE NOMBRES              '.
           DISPLAY 'ET CHERCHER LE MINIMUM                 '.
           DISPLAY 'ET LE MAXIMUM                          '.
           DISPLAY '                                       '.
           DISPLAY 'LA LISTE CONTIENT AU MOINS UN NOMBRE   '.
           DISPLAY 'LA LECTURE SE FAIT PAR ACCEPT          '.
           DISPLAY 'LE NOMBRE 999 INDIQUE LA FIN DE LISTE  '.
           DISPLAY 'IL NE DOIT PAS ETRE PRIS EN COMPTE     '.
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
