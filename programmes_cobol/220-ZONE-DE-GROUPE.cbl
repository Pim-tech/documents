       IDENTIFICATION DIVISION.
       PROGRAM-ID. B30102.
      **********************************************************
      * EXERCICE 5                                             *
      *                                                        *
      * OBJECTIF : MAITRISER LE DECOUPAGE DES DONNEES          *
      *            EN NIVEAU                                   *
      *            EN ZONES DE GROUPE                          *
      *            EN ZONES ELEMENTAIRES                       *
      **********************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROGRAM-ID  PIC X(8) VALUE 'B30102'.
       01 WS-BOUCLE PIC 9 VALUE ZERO.
       01 WS-CITATION.
          05 FILLER            PIC X     VALUE '"'.
          05 WS-PRINCIPALE.
             10 WS-SUJET       PIC X(2)  VALUE 'JE'.
             10 FILLER         PIC X     VALUE SPACE.
             10 WS-VERBE       PIC X(5)  VALUE 'CROIS'.
             10 FILLER         PIC X     VALUE SPACE.
          05 WS-SUBORDONNEE.
             10 WS-CONJONCTION PIC X(2)  VALUE 'QU'.
             10 FILLER         PIC X     VALUE ''''.
             10 WS-VERBE       PIC X(6)  VALUE 'IL Y A'.
             10 FILLER         PIC X     VALUE SPACE.
             10 WS-SUJET.
                15 WS-ARTICLE  PIC X(2)  VALUE 'UN'.
                15 FILLER      PIC X     VALUE SPACE.
                15 WS-NOM      PIC X(6)  VALUE 'MARCHE'.
                15 FILLER      PIC X     VALUE SPACE.
                15 WS-ADJECTIF PIC X(7)  VALUE 'MONDIAL'.
             10 FILLER         PIC X     VALUE SPACE.
          05 WS-COMPLEMENT     PIC X(33) VALUE 'POUR, AU MIEUX, CINQ ORD
      -    'INATEURS.'.
          05 FILLER            PIC X     VALUE '"'.
          05 FILLER            PIC X     VALUE ','.
          05 WS-AUTEUR.
             10 WS-NOM         PIC X(6)  VALUE 'WATSON'.
             10 FILLER         PIC X     VALUE SPACE.
             10 WS-ANNEE       PIC 9(4)  VALUE 1943.
      **********************************************************
       PROCEDURE DIVISION.
       0000-INITIALISATION-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.
      *
           DISPLAY 'WS-CITATION    : ' WS-CITATION.
           DISPLAY 'WS-SUBORDONNEE : ' WS-SUBORDONNEE.
           DISPLAY 'WS-AUTEUR      : ' WS-AUTEUR     .
      *
           PERFORM 8990-FIN-STATISTIQUES-DEB
              THRU 8990-FIN-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.
       0000-INITIALISATION-FIN.
           EXIT.
      *****************************************************
      *       STATISTIQUES                                *
      *****************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'DEBUT DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           DISPLAY 'OBJECTIF : MAITRISER LE DECOUPAGE DES DONNEES '.
           DISPLAY '           EN NIVEAU                          '.
           DISPLAY '           EN ZONES DE GROUPE                 '.
           DISPLAY '           EN ZONES ELEMENTAIRES              '.
           DISPLAY '                                              '.
           DISPLAY 'L''EXEMPLE PORTE SUR UNE PHRASE               '.
           DISPLAY 'A DECOUPER EN NIVEAU                          '.
           DISPLAY 'ET DONT IL FAUT AFFICHER                      '.
           DISPLAY 'LA PHRASE EN ENTIER                           '.
           DISPLAY 'LA SUBORDONNEE                                '.
           DISPLAY 'ET L''AUTEUR                                  '.
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
