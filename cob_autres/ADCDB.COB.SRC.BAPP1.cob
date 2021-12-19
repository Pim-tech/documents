       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID.      BAPP1.
      *===============================================================*
      *--                INFORMATIONS GENERALES                     --*
      *---------------------------------------------------------------*
      *  NOM DU PROGRAMME : SQUEL                                     *
      *  NOM DU REDACTEUR : ARNAUD                                    *
      *  SOCIETE          : AENG                                      *
      *  DATE DE CREATION : JJ/MM/SSAA                                *
      *---------------------------------------------------------------*
      *--               OBJECTIFS GENERAUX DU PROGRAMME             --*
      *---------------------------------------------------------------*
      *                                                               *
      *                                                               *
      *---------------------------------------------------------------*
      *--               HISTORIQUE DES MODIFICATIONS                --*
      *---------------------------------------------------------------*
      * DATE  MODIF   !          NATURE DE LA MODIFICATION            *
      *---------------------------------------------------------------*
      * JJ/MM/SSAA    !                                               *
      *               !                                               *
      *===============================================================*
      *
      *************************
      *
      *                  ==============================               *
      *=================<  ENVIRONMENT      DIVISION   >==============*
      *                  ==============================               *
      *                                                               *
      *===============================================================*
      *
      **********************
       ENVIRONMENT DIVISION.
      **********************
      *
      *======================
       CONFIGURATION SECTION.
      *======================
      *
      *--------------
       SPECIAL-NAMES.
      *--------------
           DECIMAL-POINT IS COMMA.
      *
      *=====================
       INPUT-OUTPUT SECTION.
      *=====================
      *
      *-------------
       FILE-CONTROL.
      *-------------
      *
      *                      -------------------------------------------
      *                      XXXXXXX : FICHIER DES XXXXX
      *                      -------------------------------------------
          SELECT  CLIENT            ASSIGN  TO 'ADCDB.FIC.CLIENT'
                  FILE STATUS         IS WS-FS-CLIENT.
      *
          SELECT  COMMANDE          ASSIGN  TO 'ADCDB.FIC.COMMANDE'
                  FILE STATUS         IS WS-FS-COMMANDE.
      *
          SELECT  ENRICHIE          ASSIGN  TO 'ADCDB.FIC.ENRICHIE'
                  FILE STATUS         IS WS-FS-ENRICHIE.
      *
      *                  ==============================               *
      *=================<       DATA        DIVISION   >==============*
      *                  ==============================               *
      *                                                               *
      *===============================================================*
      *
      ***************
       DATA DIVISION.
      ***************
      *
      *=============
       FILE SECTION.
      *=============
       FD CLIENT
       01 FS-CLIENT     PIC X(100).
      *
       FD COMMANDE
       01 FS-COMMANDE   PIC X(110).
      *
       FD ENRICHIE
       01 FS-ENRICHIE   PIC X(110).
      *
      *========================
       WORKING-STORAGE SECTION.
      *========================
      *77  WS-FS-XXXXXXX    PIC X(2).
       01  WS-CLIENT.
           05 IDCLIENT      PIC 9(5) .
           05 NOMCLIENT     PIC X(30).
           05 FILLER        PIC X(65).
      *
       01  WS-COMMANDE.
           05 IDCOMMANDE    PIC 9(5).
           05 CODESTR       PIC X   .
           05 NUMLIGNE      PIC 99  .
           05 IDCLIENT      PIC 9(5).
           05 FILLER        PIC X(97).
      *
       01  WS-ENRICHIE.
           05 IDCOMMANDE    PIC 9(5).
           05 CODESTR       PIC X   .
           05 NUMLIGNE      PIC 99  .
           05 IDCLIENT      PIC 9(5).
           05 NOMCLIENT     PIC X(30).
           05 FILLER        PIC X(67).
      *
       01  WS-STATUS-CLIENT    PIC(100).
       01  WS-STATUS-COMMANDE  PIC(110).
       01  WS-STATUS-ENRICHIE  PIC(100).
      *
      *
      *                 ==============================               *
      *=================<   PROCEDURE       DIVISION   >==============*
      *                  ==============================               *
      *                                                               *
      *===============================================================*
      *
       PROCEDURE           DIVISION.
      *
      *===============================================================*
      *    STRUCTURATION DE LA PARTIE ALGORITHMIQUE DU PROGRAMME      *
      *---------------------------------------------------------------*
      *                                                               *
      *    1 : LES COMPOSANTS DU DIAGRAMME SONT CODES A L'AIDE DE     *
      *        DEUX PARAGRAPHES  XXXX-COMPOSANT-DEB                   *
      *                          XXYY-COMPOSANR-FIN                   *
      *                                                               *
      *    2 : XX REPRESENTE LE NIVEAU HIERARCHIQUE                   *
      *        YY DIFFERENCIE LES COMPOSANTS DE MEME NIVEAU           *
      *                                                               *
      *    3 : TOUT COMPOSANT EST PRECEDE D'UN CARTOUCHE DE           *
      *        COMMENTAIRE QUI EXPLICITE LE ROLE DU COMPOSANT         *
      *                                                               *
      *                                                               *
      *===============================================================*
      *===============================================================*
      *
      *
      *---------------------------------------------------------------*
      *               DESCRIPTION DU COMPOSANT PROGRAMME              *
      *               ==================================              *
      *---------------------------------------------------------------*
      *
       0000-PROGRAMME-DEB.
      *
      *
           PERFORM 6000-OPEN-CLIENT-DEB
              THRU 6000-OPEN-CLIENT-FIN.
      *
           PERFORM 6100-OPEN-COMMANDE-DEB
              THRU 6100-OPEN-COMMANDE-FIN.
      *
           PERFORM 6200-OPEN-ENRICHIE-DEB
              THRU 6200-OPEN-ENRICHIE-FIN.
      *
           PERFORM 6020-READ-CLIENT-DEB
              THRU 6020-READ-CLIENT-FIN.
      *
           PERFORM 6120-READ-COMMANDE-DEB
              THRU 6120-READ-COMMANDE-FIN.
      *
           PERFORM  1000-CLIENT-DEB
              THRU  1000-CLIENT-FIN
             UNTIL  WS-STATUS-CLIENT      NOT=ZERO
                OR  WS-STATUS-COMMANDE    NOT=ZERO.
      *
           PERFORM 6010-CLOSE-CLIENT-DEB
              THRU 6010-CLOSE-CLIENT-FIN.
      *
           PERFORM 6110-CLOSE-COMMANDE-DEB
              THRU 6110-CLOSE-COMMANDE-FIN.
      *
           PERFORM 6210-CLOSE-ENRICHIE-DEB
              THRU 6210-CLOSE-ENRICHIE-FIN.
      *
           PERFORM  8999-STATISTIQUES-DEB
              THRU  8999-STATISTIQUES-FIN.
      *
           PERFORM  9999-FIN-PROGRAMME-DEB
              THRU  9999-FIN-PROGRAMME-FIN.
      *
       0000-PROGRAMME-FIN.
            EXIT.
      *
       1000-CLIENT-DEB.
            PERFORM 2000-COMMANDE-DEB
               THRU 2000-COMMANDE-FIN
              UNTIL WS-STATUS-COMMANDE  NOT = ZERO
                 OR WS-CLIENT-IDCLIENT  NOT = WS-COMMANDE-IDCLIENT.

           PERFORM 6020-READ-CLIENT-DEB
              THRU 6020-READ-CLIENT-FIN.

       1000-CLIENT-FIN.
            EXIT.
      *
       2000-COMMANDE-DEB.
            MOVE WS-COMMANDE             TO FS-ENRICHIE
      *     MOVE WS-COMMANDE-IDCOMMANDE  TO FS-ENRICHIE-IDCOMMANDE
      *     MOVE WS-COMMANDE-IDCLIENT    TO FS-ENRICHIE-IDCLIENT
            MOVE WS-CLIENT-NOM           TO FS-ENRICHIE-NOM
      *
            PERFORM 6120-WRIT-ENRICHIE-DEB
               THRU 6120-WRIT-ENRICHIE-FIN.
      *
            PERFORM 6120-READ-COMMANDE-DEB
               THRU 6120-READ-COMMANDE-FIN.
      *
       2000-COMMANDE-FIN.
            EXIT.
      *
      *
      *
       6000-OPEN-CLIENT-DEB.
            OPEN INPUT CLIENT.
            IF WS-STATUS-CLIENT  NOT = ZERO
               DISPLAY 'ERREUR OPEN CLIENT'
                       WS-STATUS-CLIENT
               PERFORM  9999-ERREUR-PROGRAMME-DEB
                  THRU  9999-ERREUR-PROGRAMME-FIN
               END-PERFORM
            END-IF.
      *
       6000-OPEN-CLIENT-FIN.
            EXIT.
      *
       6020-READ-CLIENT-DEB.
            READ       CLIENT INTO WS-CLIENT.
            EVALUATE WS-STATUS-CLIENT
               WHEN                  = '00'
                       ADD 1 TO WS-CTR-CLIENT
               WHEN                  = '10'
                       CONTINUE
      ****     WHEN NOT = ZERO AND = '10'
               WHEN OTHER
                    DISPLAY 'ERREUR READ CLIENT'
                            WS-STATUS-CLIENT
                    PERFORM  9999-ERREUR-PROGRAMME-DEB
                       THRU  9999-ERREUR-PROGRAMME-FIN
               END-PERFORM
            END-EVALUATE.
      *
       6020-READ-CLIENT-FIN.
            EXIT.
      *
       6100-OPEN-COMMANDE-DEB.
            OPEN INPUT COMMANDE.
            IF WS-STATUS-COMMANDE  NOT = ZERO
               DISPLAY 'ERREUR OPEN COMMANDE'
                       WS-STATUS-COMMANDE
               PERFORM  9999-ERREUR-PROGRAMME-DEB
                  THRU  9999-ERREUR-PROGRAMME-FIN
               END-PERFORM
            END-IF.
      *
       6100-OPEN-COMMANDE-FIN.
            EXIT.
      *
       6020-READ-COMMANDE-DEB.
            READ   COMMANDE  INTO WS-COMMANDE.
            EVALUATE WS-STATUS-COMMANDE
               WHEN                  = '00'
                       ADD 1 TO WS-CTR-COMMANDE
               WHEN                  = '10'
                       CONTINUE
      ****     WHEN NOT = ZERO AND = '10'
               WHEN OTHER
                    DISPLAY 'ERREUR READ COMMANDE'
                            WS-STATUS-COMMANDE
                    PERFORM  9999-ERREUR-PROGRAMME-DEB
                       THRU  9999-ERREUR-PROGRAMME-FIN
               END-PERFORM
            END-EVALUATE.
      *
       6020-READ-COMMANDE-FIN.
            EXIT.
      *
       6200-OPEN-ENRICHIE-DEB.
            OPEN OUTPUT ENRICHIE.
            IF WS-STATUS-ENRICHIE  NOT = ZERO
               DISPLAY 'ERREUR OPEN ENRICHIE'
                       WS-STATUS-ENRICHIE
               PERFORM  9999-ERREUR-PROGRAMME-DEB
                  THRU  9999-ERREUR-PROGRAMME-FIN
               END-PERFORM
            END-IF.
      *
       6200-OPEN-ENRICHIE-FIN.
            EXIT.
      *
       6220-WRIT-ENRICHIE-DEB.
           WRITE                  FS-ENRICHIE.
           IF        WS-STATUS-ENRICHIE
                       ADD 1 TO WS-CTR-ENRICHIE
           ELSE
                    DISPLAY 'ERREUR WRITE ENRICHIE'
                            WS-STATUS-ENRICHIE
                    PERFORM  9999-ERREUR-PROGRAMME-DEB
                       THRU  9999-ERREUR-PROGRAMME-FIN
               END-PERFORM
            END-EVALUATE.
      *
       6220-WRIT-ENRICHIE-FIN.
            EXIT.
      *
      *===============================================================*
      *===============================================================*
      *    STRUCTURATION DE LA PARTIE INDEPENDANTE DU PROGRAMME       *
      *---------------------------------------------------------------*
      *                                                               *
      *   6XXX-  : ORDRES DE MANIPULATION DES FICHIERS                *
      *   7XXX-  : TRANSFERTS ET CALCULS COMPLEXES                    *
      *   8XXX-  : ORDRES DE MANIPULATION DES EDITIONS                *
      *   9XXX-  : ORDRES DE MANIPULATION DES SOUS-PROGRAMMES         *
      *   9999-  : PROTECTION FIN DE PROGRAMME                        *
      *                                                               *
      *===============================================================*
      *===============================================================*
      *
      *---------------------------------------------------------------*
      *   6XXX-  : ORDRES DE MANIPULATION DES FICHIERS                *
      *---------------------------------------------------------------*
      *                                                               *
      *6000-ORDRE-FICHIER-DEB.
      *
      *6000-ORDRE-FICHIER-FIN.
      *    EXIT.
      *
      *---------------------------------------------------------------*
      *   7XXX-  : TRANSFERTS ET CALCULS COMPLEXES                    *
      *---------------------------------------------------------------*
      *
      *7000-ORDRE-CALCUL-DEB.
      *
      *7000-ORDRE-CALCUL-FIN.
      *    EXIT.
      *
      *---------------------------------------------------------------*
      *   8XXX-  : ORDRES DE MANIPULATION DES EDITIONS                *
      *---------------------------------------------------------------*
      *
      *8000-ORDRE-EDITION-DEB.
      *
      *8000-ORDRE-EDITION-FIN.
      *    EXIT.
      *
       8999-STATISTIQUES-DEB.
      *
            DISPLAY '************************************************'
            DISPLAY '*     STATISTIQUES DU PROGRAMME XXXXXXXX       *'
            DISPLAY '*     ==================================       *'
            DISPLAY '************************************************'.
      *
       8999-STATISTIQUES-FIN.
            EXIT.
      *
      *---------------------------------------------------------------*
      *   9XXX-  : ORDRES DE MANIPULATION DES SOUS-PROGRAMMES         *
      *---------------------------------------------------------------*
      *
      *9000-APPEL-SP-DEB.
      *
      *9000-APPEL-SP-FIN.
      *    EXIT.
      *
      *---------------------------------------------------------------*
      *   9999-  : PROTECTION FIN DE PROGRAMME                        *
      *---------------------------------------------------------------*
      *
       9999-FIN-PROGRAMME-DEB.
      *
            DISPLAY '*==============================================*'
            DISPLAY '*     FIN NORMALE DU PROGRAMME XXXXXXXX        *'
            DISPLAY '*==============================================*'.
      *
       9999-FIN-PROGRAMME-FIN.
            STOP RUN.
      *
       9999-ERREUR-PROGRAMME-DEB.
      *
            DISPLAY '*==============================================*'
            DISPLAY '*        UNE ANOMALIE A ETE DETECTEE           *'
            DISPLAY '*     FIN ANORMALE DU PROGRAMME XXXXXXXX       *'
            DISPLAY '*==============================================*'.
      *
       9999-ERREUR-PROGRAME-FIN.
            STOP RUN.
