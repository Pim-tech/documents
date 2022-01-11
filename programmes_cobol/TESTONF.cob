        IDENTIFICATION DIVISION.
        PROGRAM-ID. TESTONF.
      ******************************************************
      *  PROGRAMME DESTINE A TESTER LA SEQUENCE DE LECTURE * 
      *  DE 2 FICHIERS EN CONTROLANT LES CODES ERREURS     * 
      ******************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FIN-VEN ASSIGN TO './data/FVEN'
              ORGANIZATION IS SEQUENTIAL
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS WS-FS-IN-VEN.
      *****************************************************
       DATA DIVISION.
      *****************************************************
       FILE SECTION.
       FD FIN-VEN
           RECORDING MODE IS F.
       01 FS-IN-VEN PIC X(100).
      *****************************************************
       WORKING-STORAGE SECTION.
      *****************************************************
       01 WS-IN-VEN.
          05 WS-CLE-VEN.
              10  WS-IN-VEN-IDART  PIC 9(5).
              10 WS-IN-VEN-IDDEC   PIC 99.
          05 WS-IN-VEN-QTEMVT   PIC 9(3).
          05 FILLER             PIC X(90).
      ****************************************************
      *    ZONES DE TRAVAIL
      ****************************************************
       01 WS-PROGRAM            PIC X(8) VALUE 'TESTONF'.
       01 WS-CTR-RET            PIC 999.
       01 WS-CTR-VEN            PIC 999                  .
      * STATUS
       01 WS-FS-IN-VEN          PIC XX.
       PROCEDURE DIVISION.
      **************************************************
       0000-START-DEB.
          DISPLAY 'DEBUT DU PROGRAMME.'. 
          PERFORM 6010-OPEN-FICHIER-VEN-DEB
               THRU 6010-OPEN-FICHIER-VEN-FIN.

           PERFORM 6050-LEC-FICHIER-VEN-DEB
              THRU 6050-LEC-FICHIER-VEN-FIN.
       6010-OPEN-FICHIER-VEN-DEB.
          DISPLAY ' OUVERTURE FICHIER VENTES.'.
          OPEN INPUT FIN-VEN.
          IF WS-FS-IN-VEN NOT = '00'
              DISPLAY 'PB OUVERTURE DU FICHIER DES VENTES'
              DISPLAY 'CODE : ' WS-FS-IN-VEN
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
          END-IF.
       6010-OPEN-FICHIER-VEN-FIN. EXIT.

       6050-LEC-FICHIER-VEN-DEB.
           READ FIN-VEN INTO WS-IN-VEN
      *    AT END MOVE 'FIN' TO WS-F-FLAG.
      *    IF WS-FS-IN-VEN = '10'
      *        MOVE 'FIN' TO WS-F-FLAG
      *     END-IF.
           IF WS-FS-IN-VEN NOT = ZERO AND NOT = '10'
              DISPLAY 'ERREUR LECTURE FICHIER FIN-VEN'
              DISPLAY 'CODE = ' WS-FS-IN-VEN
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
           IF WS-FS-IN-VEN = ZERO
              ADD 1 TO WS-CTR-VEN
           DISPLAY WS-IN-VEN-IDART  ' EST L"IDENTIFIANT ARTICLE LU'
           DISPLAY WS-IN-VEN-IDDEC  ' EST L"IDENTIFIANT DECLINAISON LU'
           DISPLAY WS-IN-VEN-QTEMVT ' EST LE MOUVEMENT VENTES LU'
           END-IF.
       6050-LEC-FICHIER-VEN-FIN. EXIT.
       9990-FIN-NORMALE-DEB.
            DISPLAY '       FIN NORMALE DU PROGRAMME'.
            STOP RUN.

       9999-ERREUR-PROGRAMME-DEB.
            DISPLAY '********************************************'.
            DISPLAY '*      UNE ANOMALIE A ETE DETECTEE         *'.
            DISPLAY '********************************************'.
       9999-ERREUR-PROGRAMME-FIN. EXIT.
