         
      ******************************************************************
      * Author: Jean-Yves
      * Date: 26/11/2020
      * Purpose: Saisir le nombre de stagiaires par mois et l'afficher
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.

       PROGRAM-ID. COMMANDS.
       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-PROGRAM-ID PIC X(6) VALUE 'COMMANDS'.

           01  WS-CARTE.
               05 WS-CODE   PIC X(1).
               05 WS-MONTANT PIC 99v99.
               05 FILLER PIC X(75).
       
       PROCEDURE DIVISION.

       0000-TP-COMMANDES.
           MOVE 0 TO TOTAL_LIGNES.
           MOVE 0 TO TOTAL_MONTANT.
           ACCEPT WS-CARTE.
           PERFORM 1000-DEB THRU 1000-FIN UNTIL WS-CARTE = 'F'.
           DISPLAY TOTAL_LIGNES ' ' TOTAL_MONTANT.
       STOP-RUN.

       1000-DEB.
           MOVE 0 TO COMMANDE_LIGNE COMMANDE_MONTANT.
           ACCEPT WS-CARTE.
           PERFORM 2000-DEB THRU 2000-FIN 
           UNTIL WS-CARTE = 'FIN' OR CODE NOT = 'L'.
           DISPLAY TOTAL_MONTANT_COMMANDES.
           DISPLAY TOTAL_LIGNES_COMMANDES.
           DISPLAY TOTAL_COMMANDE.
           ADD MT_COMMANDE TO TOTAL_MONTANT.
       1000-FIN.
           EXIT.

       2000-DEB.
           ADD 1 TO COMMANDES_LIGNES.
           ADD MONTANT_LU TO TOTAL_MONTANT.
           ACCEPT WS-CARTE.
       2000-FIN.
           EXIT.




