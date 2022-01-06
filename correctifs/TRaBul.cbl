      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. TRABULLE.
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
       01  TVAR PIC 9(4).
       01  POSITION1 PIC 9(1) VALUE 1.
       01  POSITION2 PIC 9(1) VALUE 1.
       01  POSITION3 PIC 9(1).
       01  TAB.
           05 ELEMENT-TABLEAU PIC 9(4) OCCURS 5 TIMES.


       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
             DISPLAY "Entrer 5 nombres: ".
             PERFORM PREMIER-ELEMENT VARYING POSITION1 FROM 1 BY 1
                 UNTIL POSITION1 > 5.

             DISPLAY "Tableau avant Tri: ".
             PERFORM AFFICHER VARYING POSITION1 FROM 1 BY 1
                 UNTIL POSITION1 > 5.

             PERFORM BBLSORT.

             DISPLAY "Tableau trié: ".
             PERFORM AFFICHER VARYING POSITION1 FROM 1 BY 1
                 UNTIL POSITION1 > 5.

       STOP RUN.

           PREMIER-ELEMENT.
            ACCEPT ELEMENT-TABLEAU(POSITION1).

           AFFICHER.
            DISPLAY "Elément du tableau: "ELEMENT-TABLEAU(POSITION1).

           BBLSORT.
             PERFORM VARYING POSITION1 FROM 1 BY 1 UNTIL POSITION1 > 4
               PERFORM VARYING POSITION2 FROM 1 BY 1 UNTIL
                   POSITION2 + POSITION1 > 5

                 COMPUTE POSITION3 = POSITION2 + 1
                 END-COMPUTE

                IF (ELEMENT-TABLEAU((POSITION2)) >
                    ELEMENT-TABLEAU((POSITION3)))

                 MOVE ELEMENT-TABLEAU(POSITION3) TO TVAR
                 MOVE ELEMENT-TABLEAU(POSITION2) TO
                 ELEMENT-TABLEAU(POSITION3)
                 MOVE TVAR TO ELEMENT-TABLEAU(POSITION2)

                END-IF
               END-PERFORM
             END-PERFORM.

       END PROGRAM TRABULLE.
