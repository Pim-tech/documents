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
           01 FS-ENRART PIC X(21).
       FD FIC-MVT RECORDING MODE IS F.
           01 FS-ENRMVT PIC X(12).
       FD FIC-OUTPUT RECORDING MODE IS F.
           01 FS-ENROUT PIC X(13).
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
          05 FILLER PIC X(2).
          05 WS-SENSM PIC X(1).
          05 WS-VALEURM PIC 9(3).
       
       01 WS-STATUS-OUTPUT PIC XX.
        
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
           OPEN INPUT FIC-ART.
               PERFORM UNTIL WS-STATUS-ART NOT = ZERO
                   READ FIC-ART INTO WS-ENR-ART
                       DISPLAY  'code article:' WS-CODEA 
                       ',sens:' WS-SENS ',valeur:' WS-VALEUR '|'

               END-PERFORM.
           CLOSE FIC-ART.
         OPEN INPUT FIC-MVT.
            PERFORM UNTIL WS-STATUS-MVT NOT = ZERO
                READ FIC-MVT INTO WS-ENR-MVT
                    DISPLAY 'code mouvement:' WS-CODEM
                            ',sens:' WS-SENSM
                            ',valeur:' WS-VALEURM '|'
           END-PERFORM.
        CLOSE FIC-MVT.
                    
           STOP RUN.

       END PROGRAM INOUTPUT.
