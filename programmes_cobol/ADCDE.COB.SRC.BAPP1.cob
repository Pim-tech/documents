       IDENTIFICATION DIVISION.
       PROGRAM-ID.     BAPP1.
      **********************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      *======================
       SPECIAL-NAMES.
      *--------------
           DECIMAL-POINT IS COMMA.
      *
      *=====================
       INPUT-OUTPUT SECTION.
      *=====================
       FILE-CONTROL.
           SELECT CLIENT
            ASSIGN TO FCLIENT
            FILE STATUS IS WS-STATUS-CLIENT.
      *
           SELECT COMMANDE
            ASSIGN TO FCOMMAND
            FILE STATUS IS WS-STATUS-COMMANDE.
      *
           SELECT  ENRICHIE
            ASSIGN TO FENRICHI
            FILE STATUS IS WS-STATUS-ENRICHIE.
      ***************
       DATA DIVISION.
      ***************
      *
      *=============
       FILE SECTION.
         FD CLIENT.
         01 FS-CLIENT PIC X(100).
         FD COMMANDE.
         01 FS-COMMANDE PIC X(110).
         FD ENRICHIE.
         01 FS-ENRICHIE PIC X(110).
      *========================
       WORKING-STORAGE SECTION.
         01 WS-CLIENT.
            05 CLIENT-IDCLIENT            PIC 9(5).
            05 CLIENT-NOM                 PIC X(30).
            05 FILLER                     PIC X(65).
         01 WS-COMMANDE.
            05 IDCOMMAND                  PIC 9(5).
            05 CODESTR                    PIC X.
            05 NUMLIGNE                   PIC 99.
            05 COMMANDE-IDCLIENT          PIC 9(5).
            05 FILLER                     PIC X(97).
         01 WS-ENRICHIE.
            05 ENR-IDCOMMANDE             PIC 9(5).
            05 ENR-CODESTR                PIC X.
            05 ENR-NUMLIGNE               PIC 99.
            05 ENR-IDCLIENT               PIC 9(5).
            05 ENR-NOMCLIENT              PIC X(30).
            05 FILLER                     PIC X(67).
      *
          01 WS-STATUS-CLIENT PIC XX.
          01 WS-STATUS-COMMANDE PIC XX.
          01 WS-STATUS-ENRICHIE PIC XX.

      *
          01 WS-CTR-CLIENT PIC 9(3) VALUE ZERO.
          01 WS-CTR-COMMANDE PIC 9(3) VALUE ZERO.
          01 WS-CTR-ENRICHIE PIC 9(3) VALUE ZERO.

       PROCEDURE           DIVISION.
      *
       0000-PROGRAMME-DEB.
      *
           PERFORM 6000-OPEN-CLIENT-DEB
           THRU 6000-OPEN-CLIENT-FIN.
      *
           PERFORM 6100-OPEN-COMMANDE-DEB
           THRU 6100-OPEN-COMMANDE-FIN.

      *
           PERFORM 6200-OPEN-ENRICHIE-DEB
              THRU 6200-OPEN-ENRICHIE-FIN.
      *
           PERFORM 6020-READ-CLIENT-DEB
              THRU 6020-READ-CLIENT-FIN.
      *
           PERFORM 6120-READ-COMMANDE-DEB
              THRU 6120-READ-COMMANDE-FIN.
      *
           PERFORM  1000-CLIENT-DEB
              THRU  1000-CLIENT-FIN
              UNTIL WS-STATUS-CLIENT   NOT = ZERO
              OR    WS-STATUS-COMMANDE NOT = ZERO.
      *
           PERFORM  6010-CLOSE-CLIENT-DEB
              THRU  6010-CLOSE-CLIENT-FIN.
      *
           PERFORM  6110-CLOSE-COMMANDE-DEB
              THRU  6110-CLOSE-COMMANDE-FIN.
      *
           PERFORM  6210-CLOSE-ENRICHI-DEB
              THRU  6210-CLOSE-ENRICHI-FIN.
      *
           PERFORM  8999-STATISTIQUES-DEB
              THRU  8999-STATISTIQUES-FIN.
      *
           PERFORM  9999-FIN-PROGRAMME-DEB
              THRU  9999-FIN-PROGRAMME-FIN.

       0000-PROGRAMME-FIN.
            EXIT.
      *
       1000-CLIENT-DEB.
            PERFORM 2000-COMMANDE-DEB
               THRU 2000-COMMANDE-FIN
               UNTIL WS-STATUS-COMMANDE  NOT = ZERO
               OR CLIENT-IDCLIENT NOT = COMMANDE-IDCLIENT.

      *
           PERFORM 6020-READ-CLIENT-DEB
           THRU 6020-READ-CLIENT-FIN.
      *
       1000-CLIENT-FIN.
            EXIT.
      *
       2000-COMMANDE-DEB.
           MOVE  WS-COMMANDE TO  WS-ENRICHIE.
           MOVE  CLIENT-NOM  TO  ENR-NOMCLIENT.
      *
           PERFORM 6220-WRIT-ENRICHIE-DEB
           THRU 6220-WRIT-ENRICHIE-FIN.
      *
           PERFORM 6120-READ-COMMANDE-DEB
           THRU 6120-READ-COMMANDE-FIN.
      *
      *
       2000-COMMANDE-FIN.
            EXIT.
      *===============================================================*
      *

       6000-OPEN-CLIENT-DEB.
           OPEN INPUT CLIENT.
               IF WS-STATUS-CLIENT NOT = ZERO
                  DISPLAY 'ERREUR OPEN CLIENT ' WS-STATUS-CLIENT
                  PERFORM 9999-ERREUR-PROGRAMME-DEB
                     THRU 9999-ERREUR-PROGRAMME-FIN
               END-IF.
       6000-OPEN-CLIENT-FIN.
            EXIT.
       6020-READ-CLIENT-DEB.
            READ CLIENT INTO WS-CLIENT.
             EVALUATE WS-STATUS-CLIENT
              WHEN  '00'
                 ADD 1 TO WS-CTR-CLIENT
              WHEN  '10'
                 CONTINUE
              WHEN OTHER
                 DISPLAY 'ERROR READ CLIENT '
                          WS-STATUS-CLIENT
             END-EVALUATE.
       6020-READ-CLIENT-FIN.
            EXIT.
      *
       6100-OPEN-COMMANDE-DEB.
           OPEN INPUT COMMANDE.
           IF WS-STATUS-COMMANDE NOT = ZERO
               DISPLAY 'ERREUR OPEN COMMANDE ' WS-STATUS-COMMANDE
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                  THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
       6100-OPEN-COMMANDE-FIN.
              EXIT.
       6120-READ-COMMANDE-DEB.
             READ COMMANDE INTO WS-COMMANDE.
             EVALUATE WS-STATUS-COMMANDE
                 WHEN  '00'
                    ADD 1 TO WS-CTR-COMMANDE
                 WHEN  '10'
                    CONTINUE
                 WHEN OTHER
                    DISPLAY 'ERREUR READ COMMANDE' WS-STATUS-COMMANDE
                    PERFORM 9999-ERREUR-PROGRAMME-DEB
                       THRU 9999-ERREUR-PROGRAMME-FIN
              END-EVALUATE.
       6120-READ-COMMANDE-FIN.
            EXIT.
      *
       6200-OPEN-ENRICHIE-DEB.
           OPEN OUTPUT ENRICHIE.
           IF WS-STATUS-ENRICHIE NOT = ZERO
               DISPLAY 'ERREUR OPEN ENRICHIE '
                       WS-STATUS-ENRICHIE
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                   THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
       6220-WRIT-ENRICHIE-DEB.
           WRITE FS-ENRICHIE FROM WS-ENRICHIE.
           IF WS-STATUS-ENRICHIE = ZERO
                ADD 1 TO WS-CTR-ENRICHIE
           ELSE
               DISPLAY 'ERREUR WRITE ENRICHIE '
                      WS-STATUS-ENRICHIE
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                   THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
      *
       6220-WRIT-ENRICHIE-FIN.
           EXIT.
      *
       6200-OPEN-ENRICHIE-FIN.
            EXIT.
      *
       6010-CLOSE-CLIENT-DEB.
            CLOSE CLIENT.
            IF WS-STATUS-CLIENT NOT = ZERO
               DISPLAY "PROBLEME CLOSE CLIENT: " WS-STATUS-CLIENT
            END-IF.
       6010-CLOSE-CLIENT-FIN.
            EXIT.
      *
       6110-CLOSE-COMMANDE-DEB.
           CLOSE COMMANDE.
           IF WS-STATUS-COMMANDE NOT = ZERO
               DISPLAY "PROBLEME CLOSE COMMAND: "
           WS-STATUS-COMMANDE
           END-IF.
       6110-CLOSE-COMMANDE-FIN.
           EXIT.
      *
       6210-CLOSE-ENRICHI-DEB.
            CLOSE ENRICHIE.
            IF WS-STATUS-ENRICHIE NOT = ZERO
                DISPLAY "PROBLEME CLOSE ENRICHIE " WS-STATUS-ENRICHIE
            END-IF.
       6210-CLOSE-ENRICHI-FIN.
           EXIT.
      *
       8999-STATISTIQUES-DEB.
      *
            DISPLAY '************************************************'
            DISPLAY '*     STATISTIQUES DU PROGRAMME BAPP1          *'
            DISPLAY '*     ==================================       *'
            DISPLAY '*     TODO                                     *'
            DISPLAY '************************************************'.
      *
       8999-STATISTIQUES-FIN.
            EXIT.
      *
       9999-FIN-PROGRAMME-DEB.
      *
            DISPLAY '*==============================================*'
            DISPLAY '*     FIN NORMALE DU PROGRAMME XXXXXXXX        *'
            DISPLAY '*==============================================*'.
      *
       9999-FIN-PROGRAMME-FIN.
            STOP RUN.
      *
       9999-ERREUR-PROGRAMME-DEB.
      *
            DISPLAY '*==============================================*'
            DISPLAY '*        UNE ANOMALIE A ETE DETECTEE           *'
            DISPLAY '*     FIN ANORMALE DU PROGRAMME XXXXXXXX       *'
            DISPLAY '*==============================================*'.
      *
       9999-ERREUR-PROGRAMME-FIN.
            STOP RUN.
