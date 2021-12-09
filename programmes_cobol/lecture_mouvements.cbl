      ******************************************************************
      * Author: Jean-Yves
      * Date: 29 11 2021
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. INOUTPUT.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       FILE-CONTROL.
          SELECT FIC-ART 
             ASSIGN TO "./files/articles.txt"
             FILE STATUS IS WS-STATUS-ART.
          SELECT FIC-MVT
             ASSIGN TO "./files/mouvements.txt"
             FILE STATUS IS WS-STATUS-MVT.
          SELECT FIC-OUTPUT
             ASSIGN TO "/files/output.txt"
             FILE STATUS IS WS-STATUS-OUTPUT.

       DATA DIVISION.
       FILE SECTION.
       FD FIC-ART RECORDING MODE IS F.
           01 FS-ENRART PIC X(10).
       FD FIC-MVT RECORDING MODE IS F.
           01 FS-ENRMVT PIC X(10).
       FD FIC-OUTPUT RECORDING MODE IS F.
           01 FS-ENROUT PIC X(10).
      *****************************************************
      *   STATUTS                                         *
      *****************************************************
       WORKING-STORAGE SECTION.
       01 WS-STATUS-ART   PIC XX.
       01 WS-ENR-ART.
           05 WS-CODEA PIC X(3).
           05 FILLER PIC X VALUE SPACE.
           05 WS-SENS   PIC  X(1). 
           05 WS-VALEUR  PIC 9(3).    

       01 WS-STATUS-MVT PIC XX. 
       01 WS-ENR-MVT.
          05 WS-CODEM PIC X(3).
          05 FILLER PIC X(1).
          05 WS-SENSM PIC X(1).
          05 WS-VALEURM PIC 9(3).
       
       01 WS-STATUS-OUTPUT PIC XX.
       01 WS-ENR-OUTPUT.
           05 WS-CODEOUT PIC X(3).
           05 FILLER PIC X.
           05 WS-SENSOUT PIC X(1).
           05 WS-VALEUR-OUT PIC 9(3).
 
       01 WS-CUMUL   PIC 9(3).
        
       PROCEDURE DIVISION.
       0000-STOCK-DEB.
         OPEN INPUT FIC-ART.
         OPEN INPUT FIC-MVT.
         OPEN OUTPUT FIC-OUTPUT.
         PERFORM 1000-ARTICLES-DEB THRU 1000-ARTICLES-FIN
         UNTIL WS-STATUS-ART NOT = ZERO.
         CLOSE FIC-ART.
         CLOSE FIC-MVT.
         STOP RUN.

       1000-ARTICLES-DEB.
           READ FIC-ART INTO WS-ENR-ART.
           DISPLAY  'code article:' WS-CODEA 
           ',sens:' WS-SENS ',valeur:' WS-VALEUR '|'.
           MOVE 0 TO WS-CUMUL.
           READ FIC-MVT INTO WS-ENR-MVT.
           PERFORM 2000-MOUVEMENTS-DEB THRU 2000-MOUVEMENTS-FIN
           UNTIL WS-STATUS-MVT NOT = ZERO OR WS-CODEM NOT = WS-CODEA.
           PERFORM 3000-ECRIRE-DEB THRU 3000-ECRIRE-FIN.
       1000-ARTICLES-FIN.
          EXIT.
       
       2000-MOUVEMENTS-DEB.
          DISPLAY '   Code article' WS-CODEM
          ',sens:' WS-SENSM ',valeur:' WS-VALEURM 'X'.
          IF WS-SENSM = '+'
              ADD WS-VALEURM TO WS-CUMUL
          ELSE IF WS-SENSM = '-'
             SUBTRACT WS-VALEURM FROM WS-CUMUL
               
          READ FIC-MVT INTO WS-ENR-MVT.
        
       2000-MOUVEMENTS-FIN.
          EXIT.
       3000-ECRIRE-DEB.
          MOVE WS-CODEM TO WS-CODEOUT.
          IF WS-CUMUL > 0
             MOVE '+' TO WS-SENSOUT
          END-IF
          IF WS-CUMUL < 0
             MOVE '-' TO WS-SENSOUT
          END-IF
          IF WS-CUMUL = 0
             MOVE ' ' TO WS-SENSOUT
          END-IF
          MOVE WS-VALEURM TO WS-VALEUR-OUT.
          
          WRITE FS-ENROUT FROM WS-ENR-OUTPUT.
             
       3000-ECRIRE-FIN.
          EXIT.

       END PROGRAM INOUTPUT.
