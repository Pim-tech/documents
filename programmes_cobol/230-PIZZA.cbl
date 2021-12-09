       IDENTIFICATION DIVISION.
       PROGRAM-ID. B30103.
      **********************************************************
      * EXERCICE 6                                             *
      *                                                        *
      * CHACUN MANGE 1,1 PIZZA                                 *
      * ON COMMANDE DES PIZZA ENTIERES                         *
      * COMBIEN FAUT-IL EN COMMANDER POUR 11, 12, 20 CONVIVES ?*
      *                                                        *
      **********************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROGRAM-ID  PIC X(8) VALUE 'B30103'.
       01 WS-INDIVIDUS         PIC 99.
       01 WS-PIZZAMANGEE       PIC 9V9   VALUE 1.1.
       01 WS-RESULTAT          PIC 99V9.
       01 WS-DECIM             PIC V9.
       01 WS-COMMANDE          PIC 99.

       PROCEDURE DIVISION.
       0000-INITIALISATION-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.
      *
           ACCEPT  WS-INDIVIDUS.
           PERFORM 1000-PIZZA-DEB
              THRU 1000-PIZZA-FIN
                 UNTIL WS-INDIVIDUS = 99.
      *
           PERFORM 8990-FIN-STATISTIQUES-DEB
              THRU 8990-FIN-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.
       0000-INITIALISATION-FIN.
           EXIT.
       1000-PIZZA-DEB.
           MULTIPLY WS-INDIVIDUS BY 1.1
                 GIVING  WS-RESULTAT
           ADD 0.9  TO WS-RESULTAT
                 GIVING WS-COMMANDE
           DISPLAY 'IL FAUT COMMANDER ' WS-COMMANDE  ' PIZZAS '
                   ' POUR ' WS-INDIVIDUS  ' CONVIVES'.
           ACCEPT WS-INDIVIDUS.
       1000-PIZZA-FIN.
           EXIT.
      *****************************************************
      *       STATISTIQUES                                *
      *****************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '***********************************'.
           DISPLAY 'DEBUT DU PROGRAMME '   WS-PROGRAM-ID.
           DISPLAY '***********************************'.
           DISPLAY 'CHACUN MANGE 1,1 PIZZA             '.
           DISPLAY 'ON COMMANDE DES PIZZA ENTIERES     '.
           DISPLAY 'COMBIEN FAUT-IL EN COMMANDER       '.
           DISPLAY 'POUR 11, 12, 20 CONVIVES ?         '.
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
