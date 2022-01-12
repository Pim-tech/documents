       IDENTIFICATION DIVISION.
       PROGRAM-ID. DFUNION.

      ********************************************************
       ENVIRONMENT DIVISION.
      ********************************************************
       CONFIGURATION SECTION.
      ********************************************************
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT FUNION  ASSIGN TO FUNION
              ORGANIZATION IS SEQUENTIAL
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS WS-FS-IN-UNI.
      ********************************************************
       DATA DIVISION.
      ********************************************************
        FILE SECTION.

        FD FUNION
            RECORDING MODE IS F.
        01 FS-IN-UNI                    .
           05 FS-TABLE          PIC X(5).
           05 FS-IDART          PIC 9(5).
           05 FS-IDDEC          PIC 99.
           05 FS-TYPE           PIC X(24).
           05 FS-QTE            PIC 9(5).
           05 FILLER            PIC X(59).
       WORKING-STORAGE SECTION.
      ********************************************************
      *             ENREGISTREMENTS                          *
      ********************************************************
       01 WS-IN-UNI.
          05 WS-TABLEC         PIC X(5).
          05 WS-IDARTC         PIC S9(5) COMP-3  .
          05 WS-IDDECC         PIC S9(2) COMP-3  .
          05 WS-TYPEC          PIC X(24).
          05 WS-QTEC           PIC S9(5) COMP-3  .
          05 FILLER            PIC X(59).
      ********************************************************
      *             SQL                                      *
      ********************************************************
           EXEC SQL
              INCLUDE SQLCA
           END-EXEC.

           EXEC SQL
              INCLUDE TDECL
           END-EXEC.

           EXEC SQL
              INCLUDE TARTI
           END-EXEC.

           EXEC SQL
            DECLARE CURS CURSOR FOR
             SELECT  'TARTI' AS TABLE
                 , IDART
                 ,  0 AS IDDEC
                 ,   LIBART AS  TYPE
                 ,  VALUE(QTEART,0) AS QTE
                 FROM  TARTI
                 UNION
               SELECT  'TDECL' AS TABLE
               , IDART
               , IDDEC AS IDDEC
               , COLORIS AS  TYPE
               , QTES AS QTE
                 FROM  TDECL
                 UNION
               SELECT  'SEUL ' AS TABLE
               , IDART
               ,  0 AS IDDEC
               , '-----' AS  TYPE
               ,  VALUE(QTEART,0) AS QTE
                 FROM  TARTI
                 WHERE IDART NOT IN
                  ( SELECT D.IDART
                      FROM  TDECL D
                  )
                  UNION
                   SELECT  'SOMME' AS TABLE
                   ,  A.IDART
                   , 0 AS IDDEC
                   , LIBART AS  TYPE
                   , SUM(QTES) AS QTE
                     FROM  TDECL D , TARTI  A
                     WHERE  D.IDART  = A.IDART
                     GROUP BY A.IDART, LIBART
                     ORDER BY 2,  1 , 3
                END-EXEC.
      ********************************************************
      *    ZONES DE TRAVAIL
      ********************************************************
       01 WS-SQLCODE            PIC -(6)9               .
       01 WS-PROGRAM            PIC X(8)  VALUE 'DFUNION'.
       01 WS-NB-FETCH          PIC 9(3) .
      ********************************************************
      *    STATUS
      ********************************************************
       01 WS-FS-IN-UNI          PIC XX.
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
           DISPLAY "\ DEBUT DU PROGRAMME: " WS-PROGRAM " /".
           DISPLAY " \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ ".

           DISPLAY ' ENTREE 0000 OK'.

           PERFORM 6000-OPEN-CURS-DEB
              THRU 6000-OPEN-CURS-FIN.

           PERFORM 6100-OPEN-UNI-DEB
              THRU 6100-OPEN-UNI-FIN.

           PERFORM 6020-FETCH-SQL-DEB
              THRU 6020-FETCH-SQL-FIN

           PERFORM 1000-ALIM-FIC-DEB
              THRU 1000-ALIM-FIC-FIN
              UNTIL SQLCODE NOT = ZERO.

           PERFORM 6010-CLOSE-CURS-DEB
              THRU 6010-CLOSE-CURS-FIN.

           PERFORM 6110-CLOSE-UNI-DEB
              THRU 6110-CLOSE-UNI-FIN.

           PERFORM 9995-STATISTIQUES-DEB
              THRU 9995-STATISTIQUES-FIN.

           PERFORM 9990-FIN-NORMALE-DEB
              THRU 9990-FIN-NORMALE-FIN.

       0000-START-FIN. EXIT.

       1000-ALIM-FIC-DEB.
           DISPLAY 'ENTREE 1000 OK'.
           MOVE WS-TABLEC         TO FS-TABLE.
           MOVE IDART OF DCLTARTI TO FS-IDART.
           MOVE WS-IDDECC         TO FS-IDDEC.
           MOVE WS-TYPEC          TO FS-TYPE.
           MOVE WS-QTEC           TO FS-QTE.

           PERFORM 6120-WRITE-UNI-DEB
              THRU 6120-WRITE-UNI-FIN.

           PERFORM 6020-FETCH-SQL-DEB
              THRU 6020-FETCH-SQL-FIN.

       1000-ALIM-FIC-FIN.  EXIT.
      ************************************************************
      *          CURS LE CURSEUR                                 *
      ************************************************************
       6000-OPEN-CURS-DEB.
           DISPLAY 'ENTREE OPEN CURS OK'.
           EXEC SQL
              OPEN CURS
           END-EXEC.

           MOVE SQLCODE TO WS-SQLCODE.

           IF SQLCODE NOT = ZERO
                DISPLAY 'ANOMALIE OUVERTURE CURSEUR' WS-SQLCODE
                PERFORM 9999-ERREUR-PROGRAMME-DEB
                   THRU 9999-ERREUR-PROGRAMME-FIN.
       6000-OPEN-CURS-FIN.  EXIT.
       6010-CLOSE-CURS-DEB.
           DISPLAY 'ENTREE CLOS CURS OK'.
           EXEC SQL
              CLOSE CURS
           END-EXEC.

           MOVE SQLCODE TO WS-SQLCODE.

           IF SQLCODE NOT = ZERO
                DISPLAY 'ANOMALIE FERMETURE CURSEUR' WS-SQLCODE
                PERFORM 9999-ERREUR-PROGRAMME-DEB
                   THRU 9999-ERREUR-PROGRAMME-FIN.
       6010-CLOSE-CURS-FIN.  EXIT.
      *****************************************************************
      *----------------------------------------------------------------
      * SELECT DE LA TABLE DB2 UNE FOIS LES OPERATIONS EFFECTUES
      *----------------------------------------------------------------
       6020-FETCH-SQL-DEB.
           DISPLAY 'ENTREE FETCH CURS OK'.
           DISPLAY '---------------------------------------------'.
           DISPLAY 'UNION DE LA TABLE TARTI ET TDECL             '.
           DISPLAY '---------------------------------------------'.
           EXEC SQL
            FETCH CURS INTO :WS-TABLEC, :DCLTARTI.IDART, : WS-IDDECC,
               :WS-TYPEC, :WS-QTEC
           END-EXEC.
           IF SQLCODE = ZERO
                ADD 1 TO WS-NB-FETCH.
           IF SQLCODE NOT = ZERO AND NOT = 100
           MOVE SQLCODE TO WS-SQLCODE
           DISPLAY 'LE SQL CODE EST :' WS-SQLCODE
                PERFORM 9999-ERREUR-PROGRAMME-DEB
                THRU 9999-ERREUR-PROGRAMME-FIN.

       6020-FETCH-SQL-FIN. EXIT.

      ************************************************************
      *          UNION LE FICHIER                                *
      ************************************************************
       6100-OPEN-UNI-DEB.
           DISPLAY 'ENTREE OUVERTURE FICHIER UNION OK'.
           DISPLAY '++++++++++++++++++++++++++++++++++++++++++++'.
           DISPLAY '+         OUVERTURE FICHIER UNION          +'.
           DISPLAY '++++++++++++++++++++++++++++++++++++++++++++'.
           OPEN OUTPUT FUNION.
           IF WS-FS-IN-UNI NOT = '00'
               DISPLAY 'PB OUVERTURE DU FICHIER UNION'
               DISPLAY 'CODE : ' WS-FS-IN-UNI
               PERFORM 9999-ERREUR-PROGRAMME-DEB
                  THRU 9999-ERREUR-PROGRAMME-FIN
           END-IF.
       6100-OPEN-UNI-FIN. EXIT.

       6110-CLOSE-UNI-DEB.
            DISPLAY 'ENTREE FERMETURE FICHIER UNION OK'.
            DISPLAY '############################################'.
            DISPLAY '#         FERMETURE FICHIER UNION          #'.
            DISPLAY '############################################'.
            CLOSE FUNION.
            IF WS-FS-IN-UNI NOT = '00'
                DISPLAY 'PB FERMETURE DU FICHIER UNION'
                DISPLAY 'CODE :' WS-FS-IN-UNI
                PERFORM 9999-ERREUR-PROGRAMME-DEB
                   THRU 9999-ERREUR-PROGRAMME-FIN
            END-IF.
       6110-CLOSE-UNI-FIN. EXIT.

       6120-WRITE-UNI-DEB.
            DISPLAY 'ENTREE ECRITURE FICHIER UNION OK'.
            WRITE FS-IN-UNI.
       6120-WRITE-UNI-FIN. EXIT.
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
            DISPLAY '********************************************'.
       9995-STATISTIQUES-FIN. EXIT.

       9999-ERREUR-PROGRAMME-DEB.
            DISPLAY '********************************************'.
            DISPLAY '*      UNE ANOMALIE A ETE DETECTEE         *'.
            DISPLAY '********************************************'.
            STOP RUN.
       9999-ERREUR-PROGRAMME-FIN. EXIT.
