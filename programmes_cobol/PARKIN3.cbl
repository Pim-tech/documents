       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. PARKING.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
      *        GESTION D'UN PARKING       *
      *      DE 20 PLACES A 2 NIVEAUX     *
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID PIC X(7) VALUE 'PARKING'.
       01  WS-PARK.
           05 NIVEAU OCCURS 2.
               10 WS-PLACES PIC XXX OCCURS 10.

       01  WS-COUNT PIC 99.
       01  WS-CTLVL PIC 9 VALUE 1.
       01  WS-TROUVE PIC XX VALUE 'KO'.
       01  WS-CAR.
           05 WS-MOUVEMENT PIC X.
           05 WS-IMMATRICULATION PIC XX.
           05 FILLER PIC X(77).
      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       0000-PARKING-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.

           MOVE SPACES TO WS-PARK.
           PERFORM 0100-MOUVEMENT-DEB
              THRU 0100-MOUVEMENT-FIN
               UNTIL WS-MOUVEMENT = 'F'.

           PERFORM 8990-FIN-STATISTIQUES-DEB
              THRU 8990-FIN-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.

       0000-PARKING-FIN.
           EXIT.
           STOP RUN.
       0100-MOUVEMENT-DEB.
           DISPLAY 'ENTRER ''E'' OU ''S'' SUIVI DE 2 VALEURS'.
           ACCEPT WS-CAR
           MOVE 'KO' TO WS-TROUVE

           EVALUATE WS-MOUVEMENT
               WHEN 'E' PERFORM 0200-ENTREE-DEB
                          THRU  0200-ENTREE-FIN

               WHEN 'S' PERFORM 0210-SORTIE-DEB
                          THRU  0210-SORTIE-FIN

           END-EVALUATE.
       0100-MOUVEMENT-FIN.
           EXIT.
       0200-ENTREE-DEB.
           MOVE 1 TO WS-CTLVL.
           PERFORM 0300-BOUCLE-ENTREELVL-DEB
              THRU 0300-BOUCLE-ENTREELVL-FIN
              VARYING WS-CTLVL FROM 1 BY 1 UNTIL WS-CTLVL =3
              OR WS-TROUVE = 'OK'.

           IF WS-TROUVE = 'KO' DISPLAY 'PARKING PLEIN'.
       0200-ENTREE-FIN.
           EXIT.

       0210-SORTIE-DEB.
           MOVE 1 TO WS-CTLVL.
           PERFORM 0310-BOUCLE-SORTIELVL-DEB
              THRU 0310-BOUCLE-SORTIELVL-FIN
              VARYING WS-CTLVL FROM 1 BY 1 UNTIL WS-CTLVL > 2
                               OR WS-TROUVE = 'OK'.

           IF WS-TROUVE = 'KO' DISPLAY 'VOITURE PAS DANS LE PARKING'.
       0210-SORTIE-FIN.
           EXIT.

       0300-BOUCLE-ENTREELVL-DEB.
           PERFORM 0400-BOUCLE-EPLACES-DEB
              THRU 0400-BOUCLE-EPLACES-FIN
              VARYING WS-COUNT FROM 1 BY 1 UNTIL WS-COUNT > 10
                               OR WS-TROUVE = 'OK'.
       0300-BOUCLE-ENTREELVL-FIN.
           EXIT.

       0310-BOUCLE-SORTIELVL-DEB.
           PERFORM 0410-BOUCLE-SPLACES-DEB
              THRU 0410-BOUCLE-SPLACES-FIN
               VARYING WS-COUNT FROM 1 BY 1 UNTIL WS-COUNT > 10
               OR WS-TROUVE = 'OK'.
       0310-BOUCLE-SORTIELVL-FIN.
           EXIT.

       0400-BOUCLE-EPLACES-DEB.
           EVALUATE WS-PLACES(WS-CTLVL,WS-COUNT)
                     WHEN SPACES MOVE WS-IMMATRICULATION
                     TO WS-PLACES(WS-CTLVL,WS-COUNT)
                            MOVE 'OK' TO  WS-TROUVE
                            DISPLAY NIVEAU(1)
                            DISPLAY NIVEAU(2).
       0400-BOUCLE-EPLACES-FIN.
           EXIT.

       0410-BOUCLE-SPLACES-DEB.
           EVALUATE WS-PLACES(WS-CTLVL,WS-COUNT)
                   WHEN WS-IMMATRICULATION MOVE SPACES
                   TO WS-PLACES(WS-CTLVL,WS-COUNT)

                   MOVE 'OK' TO WS-TROUVE
                   DISPLAY NIVEAU(1)
                   DISPLAY NIVEAU(2).
       0410-BOUCLE-SPLACES-FIN.
           EXIT.

       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '***************************************'.
           DISPLAY ' DEBUT DU PROGRAMME ' WS-PROGRAM-ID.
           DISPLAY '***************************************'.
           DISPLAY 'AFFICHER LA GESTION D''UN PARKING '.
           DISPLAY '         A 2 ETAGES '.
           DISPLAY '***************************************'.
       8910-DEB-STATISTIQUES-FIN.
           EXIT.

       8990-FIN-STATISTIQUES-DEB.
           DISPLAY '***************************************'.
           DISPLAY ' FIN DU PROGRAMME ' WS-PROGRAM-ID.
           DISPLAY '***************************************'.
       8990-FIN-STATISTIQUES-FIN.
           EXIT.

       9990-FIN-ANORMALE-DEB.
           DISPLAY '********************************************'.
           DISPLAY 'FIN ANORMALE DU PROGRAMME '  WS-PROGRAM-ID   .
           DISPLAY '********************************************'.
           STOP RUN.
       9990-FIN-ANORMALE-FIN.
           EXIT.

       9999-FIN-NORMALE-DEB.
           DISPLAY '*********************************************'.
           DISPLAY 'FIN NORMALE DU PROGRAMME '   WS-PROGRAM-ID    .
           DISPLAY '*********************************************'.
           STOP RUN.
       9999-FIN-NORMALE-FIN.
           EXIT.
