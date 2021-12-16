      ******************************************************************
      * Author: Adrien FOULON
      * Date: 06 Decembre 2021
      * Purpose: lit 2 fichiers et synchronise sur 3eme
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. SYNCHRO.
      ************************************************************
      *                                                          *
      *    Le programme fait la synchronisation d'une liste      *
      *    d'article et l'inventaire des ventes et des achats.   *
      *                                                          *
      *     La synchronisation des deux se fait dans un fichier  *
      *     resultat.                                            *
      *                                                          *
      ************************************************************
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.
      * localisation des fichiers a traiter*

      *          INPUT                     *

           SELECT article
             ASSIGN TO "C:\Users\Apprenant\Documents\TEST\article.txt"
             ORGANISATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL
             FILE STATUS IS WS-STATUS-ARTICLE.
           SELECT mouvement
             ASSIGN TO "C:\Users\Apprenant\Documents\TEST\mouvement.txt"
             ORGANISATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL
             FILE STATUS IS WS-STATUS-MOUVEMENT.

      *           OUTPUT                   *
           SELECT resultat
             ASSIGN TO "C:\Users\Apprenant\Documents\TEST\resultat.txt"
             ORGANISATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL
             FILE STATUS IS WS-STATUS-RESULTAT.
      *-----------------------
       DATA DIVISION.


      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
           FD article.
           01 FS-ARTICLE    PIC X(20).


           FD mouvement.
           01 FS-MOUVEMENT       PIC X(20).

           FD resultat.
           01 FS-RESULTAT       PIC X(20).
      *-----------------------
       WORKING-STORAGE SECTION.

        01 WS-PROGRAM-ID  PIC X(8) VALUE 'SYNCHRO'.
       01 WS-ARTICLE.
            05 WS-CODEARTICLE     PIC X(3).
            05 WS-QTEARTICLE     PIC 99.
            05 FILLER             PIC X(15).

       01 WS-MOUVEMENT.
            05 WS-CODEMOUVEMENT   PIC X(3).
            05 WS-QTEMOUVEMENT    PIC 99.
            05 WS-SENSMOUVEMENT   PIC X.
            05 FILLER             PIC X(14).


       01 WS-STATUS-ARTICLE       PIC XX.

       01 WS-STATUS-MOUVEMENT     PIC XX.

       01 WS-STATUS-RESULTAT      PIC XX.
      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
       0000-STOCK-DEB.

      *     STATISTIQUES OUVERTURE DU PROGRAMME

           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.


      *    OUVERTURE DES FICHIERS, INSTRUCTIONS SE TROUVENT DANS
      *     LES COMPOSANTS 6000 ET PLUS, OREILLETTE GAUCHE

          PERFORM 6000-OPEN-ARTICLE-DEB
             THRU 6000-OPEN-ARTICLE-FIN.
          PERFORM 6100-OPEN-MOUVEMENT-DEB
             THRU 6100-OPEN-MOUVEMENT-FIN.
          PERFORM 6200-OPEN-RESULTAT-DEB
             THRU 6200-OPEN-RESULTAT-FIN.



      *   LECTURE DES FICHIERS DANS UNE ZONE DE TRAVAIL DEFINIE EN
      *     WORKING STATION

          PERFORM 6020-READ-ARTICLE-DEB
             THRU 6020-READ-ARTICLE-FIN.
          PERFORM 6120-READ-MOUVEMENT-DEB
             THRU 6120-READ-MOUVEMENT-FIN.

      *    PREMIERE ITERATION DU DIAGRAMME

           PERFORM 1000-ARTICLE-DEB
              THRU 1000-ARTICLE-FIN
              UNTIL WS-STATUS-ARTICLE NOT = ZERO.

      *    FERMETURE DES FICHIERS INPUT OUTPUT, OREILLETTE DROITE

          PERFORM 6010-CLOSE-ARTICLE-DEB
             THRU 6010-CLOSE-ARTICLE-FIN.
          PERFORM 6110-CLOSE-MOUVEMENT-DEB
             THRU 6110-CLOSE-MOUVEMENT-FIN.
          PERFORM 6210-CLOSE-RESULTAT-DEB
             THRU 6210-CLOSE-RESULTAT-FIN.


      *     STATISTIQUES DE FIN DE PROGRAMME ET FIN DU PROGRAMME

          PERFORM 8990-FIN-STATISTIQUES-DEB
              THRU 8990-FIN-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.

       0000-STOCK-FIN.
           EXIT.

       1000-ARTICLE-DEB.

      *    DEUXIEME ITERATION DU DIAGRAMME
          PERFORM 2000-MOUVEMENT-DEB
              THRU 2000-MOUVEMENT-FIN
              UNTIL WS-STATUS-MOUVEMENT  NOT = ZERO
              OR WS-CODEARTICLE NOT = WS-CODEMOUVEMENT.

      *    OREILLETTE DROITE DU DIAGRAMME

          MOVE WS-ARTICLE TO FS-RESULTAT.
          WRITE FS-RESULTAT.
          READ ARTICLE INTO WS-ARTICLE.
       1000-ARTICLE-FIN.
           EXIT.

       2000-MOUVEMENT-DEB.

      *    ALTERNATIVE SIMPLE, AVEC SENS DU MOUVEMENT, ICI MENE
      *          A 3000-ENTREE CAR ARRIVAGE

          IF WS-SENSMOUVEMENT = 'A'
               PERFORM 3000-ENTREE-DEB
                  THRU 3000-ENTREE-FIN
      *    SENS DU MOUVEMENT MENANT A 3010-SORTIE CAR VENDU

          ELSE PERFORM 3010-SORTIE-DEB
                  THRU 3010-SORTIE-FIN.

      *   OREILLETTE DROITE DU DIAGRAMME

          READ MOUVEMENT INTO WS-MOUVEMENT.

       2000-MOUVEMENT-FIN.
           EXIT.

       3000-ENTREE-DEB.

      *    CONDITION ACHAT, RAJOUTE LES ARTICLES EN PLUS

           ADD WS-QTEMOUVEMENT TO WS-QTEARTICLE.

       3000-ENTREE-FIN.
           EXIT.

       3010-SORTIE-DEB.

      *     CONDITION VENTE, SOUSTRAIT LES ARTICLES DE LA COMMANDE

          SUBTRACT WS-QTEMOUVEMENT FROM WS-QTEARTICLE.

       3010-SORTIE-FIN.
           EXIT.

      *****************************************************
      *  6... ACCES AUX FICHIERS                          *
      *****************************************************

      *****************************************************
      *        FICHIER ARTICLE                            *
      *****************************************************
       6000-OPEN-ARTICLE-DEB.

          OPEN INPUT  ARTICLE.
          IF WS-STATUS-ARTICLE NOT = ZERO
              DISPLAY "PROBLEME OPEN ARTICLE: " WS-STATUS-ARTICLE
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6000-OPEN-ARTICLE-FIN.
          EXIT.

       6010-CLOSE-ARTICLE-DEB.

          CLOSE ARTICLE.
          IF WS-STATUS-ARTICLE NOT = ZERO
              DISPLAY "PROBLEME CLOSE ARTICLE: " WS-STATUS-ARTICLE
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6010-CLOSE-ARTICLE-FIN.
          EXIT.

       6020-READ-ARTICLE-DEB.

          READ ARTICLE INTO WS-ARTICLE.
          IF WS-STATUS-ARTICLE NOT = ZERO
              DISPLAY "PROBLEME READ ARTICLE: " WS-STATUS-ARTICLE
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6020-READ-ARTICLE-FIN.
          EXIT.

      *****************************************************
      *        FICHIER MOUVEMENT                          *
      *****************************************************


       6100-OPEN-MOUVEMENT-DEB.
          OPEN INPUT MOUVEMENT.
          IF WS-STATUS-MOUVEMENT NOT = ZERO
              DISPLAY "PROBLEME OPEN MOUVEMENT: " WS-STATUS-MOUVEMENT
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6100-OPEN-MOUVEMENT-FIN.
          EXIT.

       6110-CLOSE-MOUVEMENT-DEB.

          CLOSE MOUVEMENT.
          IF WS-STATUS-MOUVEMENT NOT = ZERO
              DISPLAY "PROBLEME CLOSE MOUVEMENT: " WS-STATUS-MOUVEMENT
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6110-CLOSE-MOUVEMENT-FIN.
          EXIT.

       6120-READ-MOUVEMENT-DEB.

          READ MOUVEMENT INTO WS-MOUVEMENT.
          IF WS-STATUS-MOUVEMENT NOT = ZERO
              DISPLAY "PROBLEME READ MOUVEMENT: " WS-STATUS-MOUVEMENT
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6120-READ-MOUVEMENT-FIN.
          EXIT.

      *****************************************************
      *        FICHIER RESULTAT                           *
      *****************************************************

       6200-OPEN-RESULTAT-DEB.

          OPEN OUTPUT RESULTAT.
          IF WS-STATUS-RESULTAT NOT = ZERO
              DISPLAY "PROBLEME OPEN RESULTAT: " WS-STATUS-RESULTAT
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6200-OPEN-RESULTAT-FIN.
          EXIT.

       6210-CLOSE-RESULTAT-DEB.

          CLOSE RESULTAT.
          IF WS-STATUS-RESULTAT NOT = ZERO
              DISPLAY "PROBLEME CLOSE RESULTAT: " WS-STATUS-RESULTAT
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6210-CLOSE-RESULTAT-FIN.
          EXIT.

       6220-READ-RESULTAT-DEB.

          IF WS-STATUS-RESULTAT NOT = ZERO
              DISPLAY "PROBLEME READ RESULTAT: " WS-STATUS-RESULTAT
              PERFORM 9990-FIN-ANORMALE-DEB
                 THRU 9990-FIN-ANORMALE-FIN
          END-IF.
       6220-READ-RESULTAT-FIN.
          EXIT.

      *****************************************************
      *       STATISTIQUES                                *
      *****************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'DEBUT DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           DISPLAY 'ON DOIT GERER UN STOCK             '.
           DISPLAY 'ON OUVRE UN FICHIER ARTICLE ET UN  '.
           DISPLAY 'FICHIER MOUVEMENT                  '.
           DISPLAY 'ON SYNCHRONISE DANS UN FICHIER     '.
           DISPLAY 'RESULTAT LES NOUVEAUX STOCKS       '.
           DISPLAY '***********************************'.
       8910-DEB-STATISTIQUES-FIN.
           EXIT.
       8990-FIN-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'STATISTIQUES DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
       8990-FIN-STATISTIQUES-FIN.
           EXIT.
      *****************************************************
      *       FIN ANORMALE                                *
      *****************************************************
       9990-FIN-ANORMALE-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'FIN ANORMALE DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           STOP RUN.
       9990-FIN-ANORMALE-FIN.
           EXIT.
      *****************************************************
      *       FIN NORMALE                                 *
      *****************************************************
       9999-FIN-NORMALE-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'FIN NORMALE DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           STOP RUN.
       9999-FIN-NORMALE-FIN.
           EXIT.


       END PROGRAM SYNCHRO.
