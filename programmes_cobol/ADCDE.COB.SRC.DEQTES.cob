       IDENTIFICATION DIVISION.
       PROGRAM-ID. DEQTES.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-SQLCODE PIC -(6)9.
       01 WS-PROGRAM PIC X(8) VALUE 'PDEQTES'.
       01 WS-SQLERRD PIC ZZZBZZ9.
      ************************
           EXEC SQL
              INCLUDE SQLCA
           END-EXEC.
           EXEC SQL
              INCLUDE TDECL
           END-EXEC.
           EXEC SQL
              INCLUDE TARTI
           END-EXEC.
      ************************
       PROCEDURE DIVISION.
       0000-START-DEB.
           PERFORM 1000-UPDATE-SQL-DEB
              THRU 1000-UPDATE-SQL-FIN.
           PERFORM 9990-FIN-NORMALE-DEB
              THRU 9990-FIN-NORMALE-FIN.
       0000-START-FIN. EXIT.
       1000-UPDATE-SQL-DEB.
           EXEC SQL
               UPDATE TARTI A
                  SET A.QTEART=
                  (SELECT SUM(QTES)
                   FROM TDECL D
                   WHERE A.IDART=D.IDART)
           END-EXEC.
           MOVE SQLERRD(3) TO WS-SQLERRD.
           MOVE SQLCODE    TO WS-SQLCODE.
           DISPLAY 'LE SQL CODE EST : ' WS-SQLCODE.
           IF SQLCODE = 0
              DISPLAY 'OK MISE A JOUR CORRECTEMENT EFFECTUEE.'
           ELSE
              MOVE SQLCODE TO WS-SQLCODE
              DISPLAY 'LE CODE ERR SQL EST :' WS-SQLCODE
              PERFORM 9999-ERREUR-PROGRAMME-DEB
           END-IF.

       1000-UPDATE-SQL-FIN. EXIT.
       9990-FIN-NORMALE-DEB.
            DISPLAY '****************************************'
            DISPLAY '        FIN NORMALE DU PROGRAMME       *'
            DISPLAY '****************************************'
            STOP RUN.
       9990-FIN-NORMALE-FIN. EXIT.
       9999-ERREUR-PROGRAMME-DEB.
            DISPLAY '**********************************'
            DISPLAY '*    UNE ANOMALIE A ETE DETECTEE *'
            DISPLAY '**********************************'
            STOP RUN.
       9999-ERREUR-PROGRAMME-FIN. EXIT.
