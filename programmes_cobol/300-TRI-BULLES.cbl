
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TRIABUL.
      **********************************************************
      * EXERCICE 18                                            *
      *                                                        *
      * TRI A BULLES                                           *
      * ON TRI CHAQUE NOMBRE 2 PAR 2                           *
      * AU BOUT DE N-1 FOIS LA TABLE EST TRIEE                 *
      *                                                        *
      **********************************************************
       ENVIRONMENT DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TABLE.
               05 WS-POSTE PIC X(2) OCCURS 20.

       PROCEDURE DIVISION.
       0000-INITIALISATION-DEB.
       0000-INITIALISATION-FIN.
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
