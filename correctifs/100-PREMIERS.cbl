      ************************************************************
      * Auteur    : Gauthier GILES
      * Date      : 24/11/2021
      * Nom       : NBRPREMI
      * Langage   : COBOL
      * Objet     : affiche les nombres premiers d'un intervalle
      *             donnée de nombres.
      ******************************************************************
        IDENTIFICATION DIVISION.
        PROGRAM-ID. NBRPREMI.
        ENVIRONMENT DIVISION.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 NOMBRE-MAX          PIC 9(4).
        01 NOMBRE              PIC 9(4).
        01 DIVISEUR            PIC 9(4).
        01 BOOLEEN-PREMIER     PIC 9(1).
           88 NON-PREMIER      VALUE 0.
           88 EST-PREMIER      VALUE 1.

        PROCEDURE DIVISION.
           DISPLAY "Veuillez entrer le premier intervalle de borne".
           DISPLAY "de 2 chiffres (max 99)".
           ACCEPT NOMBRE.
           DISPLAY "Veuillez entrer le dernier intervalle de borne".
           DISPLAY "de 2 chiffres (max 99)".
           ACCEPT NOMBRE-MAX.

      *    Vérification de tous les nombres jusqu'à la borne maximale
           PERFORM VARYING NOMBRE FROM NOMBRE BY 1 UNTIL NOMBRE
               = NOMBRE-MAX
              SET EST-PREMIER TO TRUE
              DISPLAY NOMBRE " divisible par : " NO ADVANCING

      *       Balayage de tous les diviseurs potentiels du nombre
      *       examiné
              PERFORM VARYING DIVISEUR FROM NOMBRE BY 1
              UNTIL DIVISEUR = NOMBRE
      *          Test sur le modulo pour voir si le nombre est premier.
      *          Si le reste est égal à 0, le nombre n'est pas premier,
      *          et l'on l'affiche en sortie
                 IF FUNCTION MOD(NOMBRE DIVISEUR) = 0
                    SET NON-PREMIER TO TRUE
                    DISPLAY '{' DIVISEUR '}' NO ADVANCING
                 END-IF
              END-PERFORM

      *       Affichage d'un message spécifique en cas de nombre premier
              IF EST-PREMIER
                 DISPLAY 'lui-même (nombre premier)' NO ADVANCING
              END-IF

      *       Ajout d'un DISPLAY pour faire le saut de ligne en vue
      *       du prochain nombre
              DISPLAY ' '
           END-PERFORM

      *    Appelle le paragraphe de fin de programme
           GOBACK
       .

       END PROGRAM NBRPREMI.

