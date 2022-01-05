       IDENTIFICATION DIVISION.
       PROGRAM-ID.  INDEXREC.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
               SELECT FRESERV         ASSIGN TO RESERVA
                      ORGANIZATION IS SEQUENTIAL.
               SELECT FTRAVAIL        ASSIGN TO TRAVAIL.
               SELECT FTRI ASSIGN TO TRI
                      ORGANIZATION IS SEQUENTIAL.
               SELECT FRECAP          ASSIGN TO RECAPIT
                      ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD      FRESERV.
       01      FS-ENREG-CLIENT-FA.
           02    FS-NOM-CLIENT-FA        PIC X(30).
           02    FS-NOM-DEST-FA            PIC X(20).
           02    FS-FRAIS-RESERV-FA        PIC 9(5)V99.
           02    FS-NB-HOMMES-FA            PIC 99.
           02    FS-NB-DAMES-FA            PIC 99.
           02    FS-NB-ENFANTS-FA        PIC 99.
           02    FS-CATEGORIE-FA            PIC X.
               88    TOURISTE       VALUE "T".

       SD    FTRAVAIL.
       01    SD-ENREG-TRAVAIL-FB.
           02    FILLER                PIC X(30).
           02    SD-NOM-DEST-FB        PIC X(20).
           02    FILLER                PIC X(14).

       FD    FTRI.
       01     FS-ENREG-CLIENT-FC.
           02    FS-NOM-CLIENT-FC        PIC X(30).
           02    FS-NOM-DEST-FC            PIC X(20).
           02    FS-FRAIS-RESERV-FC        PIC 9(5)V99.
           02    FS-NB-HOMMES-FC            PIC 99.
           02    FS-NB-DAMES-FC            PIC 99.
           02    FS-NB-ENFANTS-FC        PIC 99.
           02    FS-CATEGORIE-FC            PIC X.

       FD    FRECAP.
       01    FS-ENREG-RECAP.
           02    FS-NOM-DEST-FD            PIC X(20).
           02    FS-TOTAL-RECU-FD        PIC 9(8)V99.
           02    FS-TOTAL-HOMMES-FD        PIC 9(6).
           02    FS-TOTAL-DAMES-FD        PIC 9(6).
           02    FS-TOTAL-ENFANTS-FD        PIC 9(6).


       WORKING-STORAGE SECTION.
       01    WS-FLAGS-WA.
           02    EST-CE-LA-FIN-DE-FICHIER        PIC 9 VALUE ZERO.
               88    FIN-DE-FICHIER            VALUE 1.
               88    PAS-FIN-DE-FICHIER        VALUE 0.

       01    WS-TABLE-DES-SURTAXES-WB.
           02    FILLER        PIC X(39)
                  VALUE "AFGHANISTAN50CAMBODGE   24CORSE      18".
           02    FILLER        PIC X(39)
                  VALUE "SALVADOR   85HAITI      21HONDURAS   23".
           02    FILLER        PIC X(39)
                  VALUE "ISRAEL     11IRAN       57IRAK       33".
           02    FILLER        PIC X(39)
                  VALUE "LAOS       13LIBAN      90LIBYE      20".
           02    FILLER        PIC X(39)
                  VALUE "NICARAGUA  47SARDAIGNE  25SICILE     20".
           02    FILLER        PIC X(26)
                  VALUE "ESPAGNE    05SURINAM    07".

       01    FILLER REDEFINES WS-TABLE-DES-SURTAXES-WB.
           02    WS-ENSEMBLE-DES-LIEUX-WB
                   OCCURS 17 TIMES INDEXED BY   INDEX-DES-LIEUX.
               03    WS-LIEU-WB    PIC X(11).
               03    WS-SURTAXE-WB    PIC 99.


       01    WS-VARIABLES-DIVERSES-WC.
           02    WS-SURTAXE-WC            PIC 9(4)V99.
           02    WS-DEST-WC                PIC X(20).


       PROCEDURE DIVISION.
       MAIN SECTION.
       10-DEBUT.
           SORT FTRAVAIL
               ON ASCENDING SD-NOM-DEST-FB
               INPUT PROCEDURE IS PREPARER-LE-FICHIER-A-TRIER
               GIVING FTRI.

           OPEN INPUT FTRI.
           OPEN OUTPUT FRECAP.

           READ FTRI
               AT END SET FIN-DE-FICHIER TO TRUE.
           PERFORM 20-CREER-FRECAP
                    UNTIL FIN-DE-FICHIER.

           CLOSE     FTRI
                   FRECAP.
           STOP RUN.

       20-CREER-FRECAP.
           MOVE ZEROS TO FS-ENREG-RECAP.
           MOVE FS-NOM-DEST-FC TO FS-NOM-DEST-FD.
           PERFORM 30-TRT-RESERVATION-DESTINATION
               UNTIL FS-NOM-DEST-FC NOT EQUAL TO FS-NOM-DEST-FD
                  OR FIN-DE-FICHIER.

           SET INDEX-DES-LIEUX TO 1.
           SEARCH WS-ENSEMBLE-DES-LIEUX-WB
               AT END DISPLAY FS-NOM-DEST-FD
                    " PAS DE SURTAXE POUR CETTE DESTINATION "
                    FS-NOM-DEST-FD
               WHEN WS-LIEU-WB(INDEX-DES-LIEUX) = FS-NOM-DEST-FD
                  COMPUTE WS-SURTAXE-WC ROUNDED
                      = (FS-TOTAL-RECU-FD / 100) *
                       ws-SURTAXE-WB(INDEX-DES-LIEUX )

                  ADD WS-SURTAXE-WC TO FS-TOTAL-RECU-FD.

           WRITE FS-ENREG-RECAP.


       30-TRT-RESERVATION-DESTINATION.
           ADD FS-FRAIS-RESERV-FC  TO FS-TOTAL-RECU-FD.
           ADD FS-NB-HOMMES-FC     TO FS-TOTAL-HOMMES-FD.
           ADD FS-NB-DAMES-FC      TO FS-TOTAL-DAMES-FD.
           ADD FS-NB-ENFANTS-FC    TO FS-TOTAL-ENFANTS-FD
           READ FTRI
               AT END SET FIN-DE-FICHIER TO TRUE.



       PREPARER-LE-FICHIER-A-TRIER SECTION.
       BEGIN.
           OPEN INPUT FRESERV.
           READ FRESERV
               AT END SET FIN-DE-FICHIER TO TRUE.
           PERFORM UNTIL FIN-DE-FICHIER
               IF TOURISTE THEN
                   INSPECT FS-NOM-DEST-FA CONVERTING
                       "abcdefghijklmnopqrstuvwxyz"
                                      TO
                       "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                   RELEASE SD-ENREG-TRAVAIL-FB FROM FS-ENREG-CLIENT-FA
               END-IF
               READ FRESERV
                   AT END SET FIN-DE-FICHIER TO TRUE
               END-READ
           END-PERFORM.
           SET PAS-FIN-DE-FICHIER TO TRUE.
           CLOSE FRESERV.
