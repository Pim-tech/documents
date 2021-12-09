      ******************************************************************
      * Author: Jean-Yves
      * Date: 01/12/2020

      * Purpose: Un parking à 2 étages de 10 places :
      * Il faut gérer les entrées et les sorties afin que:
      * 1/ Quand une nouvelle voiture arrive, on lui trouve une place
      * libre.      *
      * 2/ parking est plein, on accepte plus de voiture.

      * Le compilateur est : /usr/local/bin/cobc
      *
      ******************************************************************
       IDENTIFICATION DIVISION.

       PROGRAM-ID. PARKING1.
       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-PROGRAM-ID PIC X(8) VALUE 'PARKING'.
       
           01 WS-PARK-TABLE.
               05 WS-ETAGE OCCURS 2.
                   10 WS-PLACE OCCURS 10 PIC X(3).

           01 WS-NIVEAU          PIC 99.
           01 WS-ENTREES         PIC 99 VALUE 0.
           01 WS-INC             PIC 99.
           01 WS-VOITURE         PIC X(3).
           01 WS-TYPE            PIC X(1).
           01 WS-TROUVEE         PIC X(3).


       PROCEDURE DIVISION.
           0000-INITIALISATION-DEB.
               MOVE SPACES TO WS-PARK-TABLE.
               PERFORM 0100-VOITURE-DEB THRU 0100-VOITURE-FIN.
               STOP RUN.

           0000-INITIAALISATION-FIN.
               EXIT.

           0100-VOITURE-DEB.

               PERFORM
                    0200-TRAITEMENT-DEB THRU 0200-TRAITEMENT-FIN
               UNTIL WS-VOITURE = 'FIN'.

           0100-VOITURE-FIN.
               EXIT.

           0200-TRAITEMENT-DEB.
               DISPLAY 'VOITURE: ' NO ADVANCING.
               ACCEPT WS-VOITURE.
               DISPLAY 'ENTREE ou SORTIE (E/S) ?:' NO ADVANCING.
               ACCEPT WS-TYPE.
               EVALUATE WS-TYPE
                   WHEN 'E'
                       PERFORM 0300-ENTREE-DEB THRU 0300-ENTREE-FIN
                   WHEN 'S'
                       PERFORM 0300-SORTIE-DEB THRU 0300-SORTIE-FIN
                   WHEN OTHER
                       DISPLAY "MAUVAIS CHOIX : '" WS-TYPE  "'"
               END-EVALUATE.

           0200-TRAITEMENT-FIN.
               EXIT.

           0300-ENTREE-DEB.
               DISPLAY 'ENTREE'.
               PERFORM 0400-CHERCHER-ETAGE-DEB THRU
               0400-CHERCHER-ETAGE-FIN.

           0300-ENTREE-FIN.
               EXIT.

           0300-SORTIE-DEB.
                DISPLAY 'SORTIE'.
           0300-SORTIE-FIN.
               EXIT.

           0400-CHERCHER-ETAGE-DEB.

               MOVE 1 TO WS-NIVEAU.
               MOVE 1 TO WS-INC.
               MOVE 'NON' TO WS-TROUVEE.

               PERFORM 0500-CHERCHER-PLACE-DEB THRU
               0500-CHERCHER-PLACE-FIN UNTIL WS-NIVEAU >= 2
               OR  WS-TROUVEE = 'OUI'.
               DISPLAY 'Etage: ' WS-NIVEAU ', Place: ',WS-INC. 
           0400-CHERCHER-ETAGE-FIN.
               EXIT.

           0500-CHERCHER-PLACE-DEB.
                PERFORM UNIL WS-ENTREES > 20 OR WS-TROUVEE = 'OUI'
                   IF WS-PLACE(WS-NIVEAU WS-INC) = SPACES
                       MOVE 'OUI' TO WS-TROUVEE
                       MOVE WS-VOITURE
                       TO WS-PLACE(WS-NIVEAU WS-INC)
                   END-IF
                   ADD 1 TO WS-INC
                   IF WS-NIVEAU = 1 AND WS-INC > 10
                       MOVE 1 TO WS-INC
                       ADD 1 TO WS-NIVEAU
                   END-IF
                   ADD 1 TO WS-ENTREES
               END-PERFORM.
               DISPLAY 'PASS 2'.

           0500-CHERCHER-PLACE-FIN.
               EXIT.

           9999-FIN-NORMALE-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'FIN NORMALE DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           STOP RUN.
           9999-FIN-NORMALE-FIN.
           EXIT.

           9999-FIN-NORMALE-FIN.
            EXIT.
               END PROGRAM PARKING1.
