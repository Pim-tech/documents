       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. TMOIS.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
      *        CREATION D'UNE TABLE      *
      *        POUR SAISIR LE NOMBRE     *
      *        DE STAGIAIRES PAR MOIS    *
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID PIC X(6) VALUE 'TMOIS'.
       01  WS-STAGIAIRES.
           05 WS-MOIS  OCCURS 12.
              10 WS-NOMBRE PIC 9(2).
              10 WS-LIBELLE PIC X(10).

       01  WS-CARTE.
           05 WS-NOMBREC PIC 99.
           05 WS-LIBELLEC PIC X(10).
           05 FILLER PIC X(68).

       01  WS-INDICE PIC 99 VALUE 1.
      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       0000-TABLEMOIS-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.
           MOVE SPACES TO WS-STAGIAIRES.
           PERFORM 0100-SAISIE-DEB
              THRU 0100-SAISIE-FIN
              12 TIMES.

           PERFORM 8990-FIN-STATISTIQUES-DEB
              THRU 8990-FIN-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.
       0000-TABLEMOIS-FIN.
           EXIT.
           STOP RUN.

       0100-SAISIE-DEB.
           DISPLAY 'Saisir l''effectif (2 chiffres) '.
           ACCEPT WS-CARTE.
           DISPLAY WS-LIBELLEC.
           EVALUATE WS-LIBELLEC
               WHEN 'JANVIER'   MOVE 1 TO WS-INDICE
               WHEN 'FEVRIER'   MOVE 2 TO WS-INDICE
               WHEN 'MARS'      MOVE 3 TO WS-INDICE
               WHEN 'AVRIL'     MOVE 4 TO WS-INDICE
               WHEN 'MAI'       MOVE 5 TO WS-INDICE
               WHEN 'JUIN'      MOVE 6 TO WS-INDICE
               WHEN 'JUILLET'   MOVE 7 TO WS-INDICE
               WHEN 'AOUT'      MOVE 8 TO WS-INDICE
               WHEN 'SEPTEMBRE' MOVE 9 TO WS-INDICE
               WHEN 'OCTOBRE'   MOVE 10 TO WS-INDICE
               WHEN 'NOVEMBRE'  MOVE 11 TO WS-INDICE
               WHEN 'DECEMBRE'  MOVE 12 TO WS-INDICE
               WHEN OTHER DISPLAY 'ERREUR DE SAISIE'
           END-EVALUATE.

           MOVE WS-LIBELLEC TO WS-LIBELLE(WS-INDICE).
           MOVE WS-NOMBREC  TO WS-NOMBRE(WS-INDICE).

           PERFORM 0200-AFFICHAGE-DEB
              THRU 0200-AFFICHAGE-FIN.

       0100-SAISIE-FIN.
           EXIT.

       0200-AFFICHAGE-DEB.
           MOVE 1 TO WS-INDICE.
           PERFORM 0300-BOUCLE-DEB
              THRU 0300-BOUCLE-FIN
              12 TIMES.

       0200-AFFICHAGE-FIN.
           EXIT.

       0300-BOUCLE-DEB.
           IF WS-LIBELLE(WS-INDICE) NOT = SPACES
               DISPLAY 'IL Y A ' WS-NOMBRE(WS-INDICE)
               ' STAGIAIRES EN ' WS-LIBELLE(WS-INDICE) ' .'
           END-IF.
           ADD 1 TO WS-INDICE.
       0300-BOUCLE-FIN.
           EXIT.

       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '********************************************'.
           DISPLAY '*     DEBUT DU PROGRAMME' WS-PROGRAM-ID   '*'.
           DISPLAY '********************************************'.
           DISPLAY '*      TABLE DE MOIS                       *'.
           DISPLAY '********************************************'.
       8910-DEB-STATISTIQUES-FIN.
           EXIT.

       8990-FIN-STATISTIQUES-DEB.
           DISPLAY '********************************************'.
           DISPLAY '*     FIN DU PROGRAMME' WS-PROGRAM-ID     '*'.
           DISPLAY '********************************************'.
       8990-FIN-STATISTIQUES-FIN.
           EXIT.

       9990-FIN-ANORMALE-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'FIN ANORMALE DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           STOP RUN.
       9990-FIN-ANORMALE-FIN.
           EXIT.

       9999-FIN-NORMALE-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'FIN NORMALE DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           STOP RUN.
       9999-FIN-NORMALE-FIN.
           EXIT.
