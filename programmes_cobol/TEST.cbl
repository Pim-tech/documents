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
               ACCEPT WS-VOITURE.
               

           0200-TRAITEMENT-FIN.
               EXIT.

      



