      ******************************************************************
      * Author: Moi Gauthier
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
             SELECT MONFICHIER
             ASSIGN TO "./files/listeEleve.txt"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
       FD MONFICHIER.
       01 NOM-ELEVE PICTURE X(40).
      *-----------------------
       WORKING-STORAGE SECTION.
      *> la ligne complète dans le fichier      
       01  WS-NOM-ELEVE    PIC X(40).
      *> simule la fin de fichier
       01  WS-EOF          PIC X(1).
      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
           OPEN INPUT MONFICHIER.

               PERFORM UNTIL WS-EOF = "Y"
                   READ MONFICHIER INTO WS-NOM-ELEVE
                       AT END MOVE "Y" TO WS-EOF
                       NOT AT END DISPLAY NOM-ELEVE
                   END-READ
               END-PERFORM.

           CLOSE MONFICHIER.

           STOP RUN.

       END PROGRAM INOUTPUT.
