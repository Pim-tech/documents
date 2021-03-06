       IDENTIFICATION DIVISION.
       PROGRAM-ID. DEMAJS2.

      ********************************************************
      *          PROGRAMME METTANT A JOUR LE SQL T2DECL      *
      *          EN FONCTION DES VENTES ET DES RETOURS       *
      *          PRECISE DANS LES FICHIERS VENTES ET         *
      *          AVEC UPDATE DE TOUTES LES OPERATIONS        *
      *          CORRESPONDANT A UN IDDEC EN UNE SEULE       *
      *          FOIS                                        *
      ********************************************************
       ENVIRONMENT DIVISION.
      ********************************************************
       CONFIGURATION SECTION.
      ********************************************************
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT FIN-VEN ASSIGN TO FVEN
              ORGANIZATION IS SEQUENTIAL
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS WS-FS-IN-VEN.

      ********************************************************
      *                                                      *
      *       /\                                     /\      *
      *      /  \       CE PROGRAMME NE FONCTIONNE  /  \     *
      *     / |  \      PAS ENCORE CORRECTEMENT.   / |  \    *
      *    /  |   \                               /  |   \   *
      *   /   |    \    PAS ENCORE DU TOUT       /   |    \  *
      *  /    O     \   POUR ETRE EXACT.        /    O     \ *
      * /____________\                         /____________\*
      *                                                      *
      ********************************************************


           SELECT FIN-RET ASSIGN TO FRET
              ORGANIZATION IS SEQUENTIAL
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS WS-FS-IN-RET.
      ********************************************************
       DATA DIVISION.
      ********************************************************
       FILE SECTION.

       FD FIN-VEN
           RECORDING MODE IS F.
       01 FS-IN-VEN  PIC X(100).

       FD FIN-RET
           RECORDING MODE IS F.
       01 FS-IN-RET  PIC X(100).
      ********************************************************
       WORKING-STORAGE SECTION.
      ********************************************************
      * ENREGISTREMENTS
      ********************************************************
       01 WS-IN-VEN.
          05 WS-CLE-VEN.
              10 WS-IN-VEN-IDART    PIC 9(5).
              10 WS-IN-VEN-IDDEC    PIC 99.
          05 WS-IN-VEN-QTEMVT       PIC 9(3).
          05 FILLER                 PIC X(100).

       01 WS-IN-RET.
          05 WS-CLE-RET.
              10 WS-IN-RET-IDART        PIC 9(5).
              10 WS-IN-RET-IDDEC        PIC 99.
          05 WS-IN-RET-QTEMVT       PIC 9(3).
          05 FILLER                 PIC X(100).
      ********************************************************
           EXEC SQL
              INCLUDE SQLCA
           END-EXEC.

           EXEC SQL
              INCLUDE TDECL
           END-EXEC.
      ********************************************************
      *    ZONES DE TRAVAIL
      ********************************************************
       01 WS-SQLCODE            PIC -(6)9                .
       01 WS-PROGRAM            PIC X(8)  VALUE 'DEMAJS22' .
       01 WS-CTR-VEN            PIC 999   VALUE 0.
       01 WS-CTR-RET            PIC 999   VALUE 0.
       01 WS-OPERATION          PIC S9(6)  COMP-3        .
      ********************************************************
      * STATUS
       01 WS-FS-IN-VEN          PIC XX.
       01 WS-FS-IN-RET          PIC XX.
      ********************************************************
      * ZONES DE LIEN VERS SOUS-PROGRAMME
      ********************************************************
      * ZONES D'ETAT
      ********************************************************
      *LINKAGE SECTION.
      ********************************************************
       PROCEDURE DIVISION.
      ********************************************************
       0000-START-DEB.

           DISPLAY "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\".
           DISPLAY "\ DEBUT DU PROGRAMME: " WS-PROGRAM "       /".
           DISPLAY " \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ ".

           PERFORM 6010-OPEN-FICHIER-VEN-DEB
              THRU 6010-OPEN-FICHIER-VEN-FIN.

           PERFORM 6020-OPEN-FICHIER-RET-DEB
              THRU 6020-OPEN-FICHIER-RET-FIN.

           PERFORM 6050-LEC-FICHIER-VEN-DEB
              THRU 6050-LEC-FICHIER-VEN-FIN.

           PERFORM 6060-LEC-FICHIER-RET-DEB
              THRU 6060-LEC-FICHIER-RET-FIN.

           PERFORM 1000-TRT-FICHIER-VEN-DEB
              THRU 1000-TRT-FICHIER-VEN-FIN
              UNTIL WS-FS-IN-VEN NOT = ZERO
                AND WS-FS-IN-RET NOT = ZERO.

           PERFORM 6030-CLOSE-FICHIER-VEN-DEB
              THRU 6030-CLOSE-FICHIER-VEN-FIN.

           PERFORM 6040-CLOSE-FICHIER-RET-DEB
              THRU 6040-CLOSE-FICHIER-RET-FIN.

           PERFORM 9995-STATISTIQUES-DEB
              THRU 9995-STATISTIQUES-FIN.

           PERFORM 9990-FIN-NORMALE-DEB
              THRU 9990-FIN-NORMALE-FIN.

       0000-START-FIN. EXIT.

      *****************************************************************

       1000-TRT-FICHIER-VEN-DEB.

           DISPLAY 'ENTREE DANS LE 1000 OK'.
           MOVE 0 TO WS-OPERATION.

           EVALUATE TRUE
                WHEN (WS-FS-IN-VEN = ZERO
                      AND WS-FS-IN-RET = ZERO
                      AND WS-CLE-VEN = WS-CLE-RET)
                PERFORM 2000-OPERATION-DEB
                   THRU 2000-OPERATION-FIN
                WHEN (WS-FS-IN-VEN = ZERO
                      AND WS-FS-IN-RET = ZERO
                      AND WS-CLE-VEN > WS-CLE-RET )
                      OR  (WS-FS-IN-VEN NOT = ZERO
                      AND  WS-FS-IN-RET = ZERO)
                PERFORM 2010-ADDITION-DEB
                   THRU 2010-ADDITION-FIN

               WHEN (WS-FS-IN-VEN = ZERO
                     AND WS-FS-IN-RET = ZERO
                     AND WS-CLE-VEN < WS-CLE-RET)
                     OR (WS-FS-IN-VEN = ZERO
                     AND WS-FS-IN-RET NOT = ZERO)
               PERFORM 2020-SOUSTRACTION-DEB
                  THRU 2020-SOUSTRACTION-FIN

                WHEN OTHER
                PERFORM 2030-ERREUR-DEB
                   THRU 2030-ERREUR-FIN

           END-EVALUATE.

           DISPLAY 'SORTIE DU 1000 OK'.

       1000-TRT-FICHIER-VEN-FIN. EXIT.

      *****************************************************************

       2000-OPERATION-DEB.
           DISPLAY 'ENTREE DANS LE 2000 OK'.
           MOVE WS-IN-VEN-IDART TO IDART.
           MOVE WS-IN-VEN-IDDEC TO IDDEC.
           ADD      WS-IN-RET-QTEMVT TO WS-OPERATION.
           SUBTRACT WS-IN-VEN-QTEMVT FROM WS-OPERATION.
           PERFORM 6050-LEC-FICHIER-VEN-DEB
              THRU 6050-LEC-FICHIER-VEN-FIN.
           PERFORM 6060-LEC-FICHIER-RET-DEB
              THRU 6060-LEC-FICHIER-RET-FIN.
           DISPLAY 'SORTIE DU 2000 OK'.
       2000-OPERATION-FIN. EXIT.

       2010-ADDITION-DEB.
           DISPLAY 'ENTREE DANS LE 2010 OK'.
           MOVE WS-IN-RET-IDART TO IDART.
           MOVE WS-IN-RET-IDDEC TO IDDEC.
           ADD      WS-IN-RET-QTEMVT TO WS-OPERATION.
           PERFORM 6240-UPDATE-SQL-DEB
              THRU 6240-UPDATE-SQL-FIN.
           MOVE ZERO TO WS-OPERATION.
           PERFORM 6060-LEC-FICHIER-RET-DEB
              THRU 6060-LEC-FICHIER-RET-FIN.
           DISPLAY 'SORTIE DU 2010 OK'.
       2010-ADDITION-FIN. EXIT.

       2020-SOUSTRACTION-DEB.
           DISPLAY 'ENTREE DANS LE 2020 OK'.
           MOVE WS-IN-VEN-IDART TO IDART.
           MOVE WS-IN-VEN-IDDEC TO IDDEC.
           SUBTRACT WS-IN-VEN-QTEMVT FROM WS-OPERATION.
           PERFORM 6240-UPDATE-SQL-DEB
              THRU 6240-UPDATE-SQL-FIN.
           MOVE ZERO TO WS-OPERATION.
           PERFORM 6050-LEC-FICHIER-VEN-DEB
              THRU 6050-LEC-FICHIER-VEN-FIN.
           DISPLAY 'SORTIE DU 2020 OK'.
       2020-SOUSTRACTION-FIN. EXIT.

       2030-ERREUR-DEB.
           DISPLAY 'ENTREE DANS LE 2030 OK'.
           DISPLAY 'MAIS QU"EST CE QUE JE FICHE ICI MOI?'.
           PERFORM 6050-LEC-FICHIER-VEN-DEB
              THRU 6050-LEC-FICHIER-VEN-FIN.
           PERFORM 6060-LEC-FICHIER-RET-DEB
              THRU 6060-LEC-FICHIER-RET-FIN.
           DISPLAY 'SORTIE DU 2030 OK'.
       2030-ERREUR-FIN. EXIT.

      *****************************************************************

       6010-OPEN-FICHIER-VEN-DEB.
           OPEN INPUT FIN-VEN.
           IF WS-FS-IN-VEN NOT = '00'
               DISPLAY 'PB OUVERTURE DU FICHIER FIN-VEN'
               DISPLAY 'CODE : ' WS-FS-IN-VEN
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                  THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
       6010-OPEN-FICHIER-VEN-FIN. EXIT.

       6020-OPEN-FICHIER-RET-DEB.
           OPEN INPUT FIN-RET.
           IF WS-FS-IN-RET NOT = '00'
               DISPLAY 'PB OUVERTURE DU FICHIER FIN-RET'
               DISPLAY 'CODE : ' WS-FS-IN-RET
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                  THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
       6020-OPEN-FICHIER-RET-FIN. EXIT.

       6030-CLOSE-FICHIER-VEN-DEB.
           CLOSE FIN-VEN.
           IF WS-FS-IN-VEN NOT = '00'
               DISPLAY 'PB FERMETURE DU FICHIER FIN-VEN'
               DISPLAY 'CODE :' WS-FS-IN-VEN
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                  THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
       6030-CLOSE-FICHIER-VEN-FIN. EXIT.

       6040-CLOSE-FICHIER-RET-DEB.
           CLOSE FIN-RET.
           IF WS-FS-IN-RET NOT = '00'
               DISPLAY 'PB FERMETURE DU FICHIER FIN-RET'
               DISPLAY 'CODE :' WS-FS-IN-RET
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                  THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
       6040-CLOSE-FICHIER-RET-FIN. EXIT.

       6050-LEC-FICHIER-VEN-DEB.
           READ FIN-VEN INTO WS-IN-VEN.
           IF WS-FS-IN-VEN NOT = ZERO AND NOT = '10'
              DISPLAY 'ERREUR LECTURE FICHIER FIN-VEN'
              DISPLAY 'CODE = ' WS-FS-IN-VEN
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
           IF WS-FS-IN-VEN = ZERO
              ADD 1 TO WS-CTR-VEN
      * DISPLAY WS-IN-VEN-IDART  ' EST L"IDENTIFIANT ARTICLE LU'
      * DISPLAY WS-IN-VEN-IDDEC  ' EST L"IDENTIFIANT DECLINAISON LU'
      * DISPLAY WS-IN-VEN-QTEMVT ' EST LE MOUVEMENT VENTES LU'
           END-IF.
       6050-LEC-FICHIER-VEN-FIN. EXIT.

       6060-LEC-FICHIER-RET-DEB.
           READ FIN-RET INTO WS-IN-RET
           IF WS-FS-IN-RET NOT = ZERO AND NOT = '10'
              DISPLAY 'ERREUR LECTURE FICHIER FIN-RET'
              DISPLAY 'CODE = ' WS-FS-IN-RET
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
           IF WS-FS-IN-RET = ZERO
              ADD 1 TO WS-CTR-RET
      *     DISPLAY WS-IN-RET-IDART  ' EST L"IDENTIFIANT ARTICLE LU'
      *     DISPLAY WS-IN-RET-IDDEC  ' EST L"IDENTIFIANT DECLINAISON LU'
      *     DISPLAY WS-IN-RET-QTEMVT ' EST LE MOUVEMENT RETOUR LU'
           END-IF.
       6060-LEC-FICHIER-RET-FIN. EXIT.

      *----------------------------------------------------------------
      * MISE A JOUR DE LA TABLE DB2 UNE FOIS LES OPERATIONS EFFECTUES
      *----------------------------------------------------------------
       6240-UPDATE-SQL-DEB.
           DISPLAY '---------------------------------------------'.
           DISPLAY 'MISE A JOUR DANS LA TABLE DE L"ARTICLE ' IDART.
           DISPLAY '---------------------------------------------'.
           MOVE WS-OPERATION TO QTES
           DISPLAY 'IDART EST AVANT UPDATE : ' IDART
           DISPLAY 'IDDEC EST AVANT UPDATE : ' IDDEC
           DISPLAY 'QTES VAUT AVANT UPDATE : ' QTES
           EXEC SQL
              UPDATE TDECL
                  SET
                      QTES = QTES + :QTES
              WHERE IDART  = :IDART
                AND IDDEC  = :IDDEC
           END-EXEC.
           MOVE SQLCODE TO WS-SQLCODE.
           DISPLAY 'LE SQL CODE EST :' WS-SQLCODE.
           IF SQLCODE = ZERO
                DISPLAY 'OK MISE A JOUR CORRECTEMENT EFFECTUE'
           ELSE
                MOVE SQLCODE TO WS-SQLCODE
                DISPLAY 'LE SQLCODE EST ' WS-SQLCODE
                DISPLAY 'IDART-IDDEC : ' IDART ' ' IDDEC
           END-IF.
       6240-UPDATE-SQL-FIN. EXIT.

      *----------------------------------------------------------------

       9990-FIN-NORMALE-DEB.
            DISPLAY '/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\'.
            DISPLAY '\      FIN NORMALE DU PROGRAMME            /'.
            DISPLAY ' \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ '.
            STOP RUN.
       9990-FIN-NORMALE-FIN. EXIT.

       9995-STATISTIQUES-DEB.
            DISPLAY '********************************************'.
            DISPLAY '*     STATISTIQUES DU PROGRAMME            *'.
            DISPLAY '* LIGNES VEN LUES : ' WS-CTR-VEN          '*'.
            DISPLAY '* LIGNES RET LUES : ' WS-CTR-RET          '*'.
            DISPLAY '*STATUS FICHIERS VEN: ' WS-FS-IN-VEN      '*'.
            DISPLAY '*STATUS FICHIERS RET: ' WS-FS-IN-RET      '*'.
            DISPLAY '********************************************'.
       9995-STATISTIQUES-FIN. EXIT.

       9999-ERREUR-PROGRAMME-DEB.
            DISPLAY '********************************************'.
            DISPLAY '*      UNE ANOMALIE A ETE DETECTEE         *'.
            DISPLAY '********************************************'.
            STOP RUN.
       9999-ERREUR-PROGRAMME-FIN. EXIT.
