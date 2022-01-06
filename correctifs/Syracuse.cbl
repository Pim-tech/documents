      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. SYRACUSE.
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
           77 NOMBRE-SAISIE PIC 9(3).
           77 TEMPO  PIC 9(3).
           77 RESTE PIC 9(1).
      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
            DISPLAY "Entrez votre nombre".
            ACCEPT NOMBRE-SAISIE.

            PERFORM 0100-TEST-DEB
            THRU 0100-TEST-FIN
            UNTIL NOMBRE-SAISIE = 1.
             STOP RUN.

            0100-TEST-DEB.
            DIVIDE NOMBRE-SAISIE BY 2 GIVING TEMPO REMAINDER RESTE

               IF RESTE > 0
                     COMPUTE NOMBRE-SAISIE = (NOMBRE-SAISIE * 3) + 1
               ELSE
                     MOVE TEMPO TO NOMBRE-SAISIE
               END-IF

            DISPLAY NOMBRE-SAISIE.
            0100-TEST-FIN.
            EXIT.

      ** add other procedures here
       END PROGRAM SYRACUSE.
