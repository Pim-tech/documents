      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. PGETPT-SAMPLE
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
              MINI PIC 9(3).
              MAXI PIC 9(3).
       PROCEDURE DIVISION.


      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
           IF NOMBRE > MAXI
               PERFORM 0200-GRAND-DEB
               THRU 0200-GRAND-DEB
           END IF.
            DISPLAY "Hello world"
            STOP RUN.
      ** add other procedures here
       END PROGRAM PGETPT-SAMPLE.
           0200-PETIT-DEB.
               MOVE NOMBRE TO MINI.
           0200-GRAND-DEB.
               MOVE NOMBRE TO MAXI.
