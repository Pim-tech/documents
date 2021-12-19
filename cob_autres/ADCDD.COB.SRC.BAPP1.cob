      *************************
       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID.      BAPP1.
      *
      *                  ==============================               *
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
           SELECT  CLIENT             ASSIGN TO 'ADCDD.FIC.CLIENT'
                  FILE STATUS         IS WS-STATUS-CLIENT
      *                      -------------------------------------------
           SELECT  COMMANDE           ASSIGN TO 'ADCDD.FIC.COMMANDE'
                  FILE STATUS         IS WS-STATUS-COMMANDE
      *                      -------------------------------------------
           SELECT  ENRICHI            ASSIGN TO 'ADCDD.FIC.ENRICHI'
                  FILE STATUS         IS WS-STATUS-ENRICHI
      *                      -------------------------------------------
      *
      *
      *                  ==============================               *
      *=================<       DATA        DIVISION   >==============*
      *                  ==============================               *
      *                                                               *
      *===============================================================*

       DATA DIVISION.
      ***************
      *
      *=============
       FILE SECTION.
      *=============
      *
       FD  CLIENT
      *    DATA RECORD IS XXXXXXXX.
       01 FS-CLIENT        PIC X(100).
      *
       FD  COMMANDE
      *    DATA RECORD IS XXXXXXXX.
       01 FS-COMMANDE      PIC X(110).
      *
       FD  ENRICHI
      *    DATA RECORD IS XXXXXXXX.
       01 FS-ENRICHI       PIC X(110).
      *
      *========================
       WORKING-STORAGE SECTION.
      *========================
      *77  WS-FS-XXXXXXX    PIC X(2).
       01  FS-CLIENT     PIC X(100).
       01  WS-CLIENT.
          05 IDCLIENT PIC 9(5).
          05 NOM      PIC X(30).
          05 FILLER   PIC X(65).
      *
       01  FS-COMMANDE   PIC X(110).
       01  WS-COMMANDE.
          05 IDCOMMANDE PIC 9(5).
          05 CODE-STR   PIC X.
          05 NUM-LG     PIC 99.
          05 IDCLIENT   PIC 9(5).
          05 FILLER     PIC X(97).
      *
       01  WS-ENRICHI.
          05 IDCOMMANDE PIC 9(5).
          05 IDCLIENT   PIC 9(5).
          05 CODE-STR   PIC X.
          05 NUM-LG     PIC 99.
          05 NOM        PIC 99.
          05 FILLER     PIC X(67).
      *
      *
      *                  ==============================               *
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
       0000-APPAREILLAGE-DEB
      *
           PERFORM  6000-OPEN-CLIENT-DEB
              THRU  6000-OPEN-CLIENT-FIN.
           END-PERFORM
      *
           PERFORM  6100-OPEN-COMMANDE-DEB
              THRU  6100-OPEN-COMMANDE-FIN.
           END-PERFORM
      *
           PERFORM  6200-OPEN-ENRICHI-DEB
              THRU  6200-OPEN-ENRICHI-FIN.
           END-PERFORM
      *
           PERFORM  6010-READ-CLIENT-DEB
              THRU  6010-READ-CLIENT-FIN.
           END-PERFORM
      *
           PERFORM  6110-READ-COMMANDE-DEB
              THRU  6110-READ-COMMAND-DEB.
           END-PERFORM
      *
           PERFORM  1000-CLIENT-DEB
              THRU  1000-CLIENT-DEB.
              UNTIL WS-STATUS-CLIENT   NOT = ZERO
                 OR WS-STATUS-COMMANDE NOT = ZERO
           END-PERFORM
      *
           PERFORM  6010-CLOSE-CLIENT-DEB
              THRU  6010-CLOSE-CLIENT-FIN.
           END-PERFORM
      *
           PERFORM  6110-CLOSE-COMMANDE-DEB
              THRU  6110-CLOSE-COMMANDE-FIN.
           END-PERFORM
      *
           PERFORM  6210-CLOSE-ENRICHI-DEB
              THRU  6210-CLOSE-ENRICHI-FIN.
           END-PERFORM
      *
           PERFORM  6010-CLOSE-CLIENT-DEB
              THRU  6010-CLOSE-CLIENT-FIN.
           END-PERFORM
      *
           PERFORM  6110-CLOSE-COMMANDE-DEB
              THRU  6110-CLOSE-COMMANDE-FIN.
           END-PERFORM
      *
           PERFORM  6210-CLOSE-ENRICHI-DEB
              THRU  6210-CLOSE-ENRICHI-FIN.
           END-PERFORM
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
      *************************************************
      *************************************************
       1000-CLIENT-DEB.
            PERFORM 2000-COMMANDE-DEB
               THRU 2000-COMMANDE-FIN
               UNTIL WS-CLIENT-IDCLIENT NOT = WS-COMMANDE-IDCLIENT
                  OR WS-STATUS-COMMANDE NOT = ZERO
            END-PERFORM.
      *
            PERFORM 6020-READ-CLIENT-DEB
               THRU 6020-READ-CLIENT-FIN
            END-PERFORM.
       1000-CLIENT-FIN.
            EXIT.
      *
      *************************************************
      *************************************************
       2000-COMMANDE-DEB.
            MOVE WS-COMMANDE            TO FS-ENRICHI
            MOVE WS-CLIENT-NOM          TO FS-ENRICHI-NOM
      *
            PERFORM 6230-WRITE-ENRICHI-DEB
               THRU 6230-WRITE-ENRICHI-FIN
            END-PERFORM.
      *
            PERFORM 6120-READ-COMMANDE-DEB
               THRU 6120-READ-COMMANDE-FIN
            END-PERFORM.
      *
       2000-COMMANDE-FIN.
            EXIT.
      *
      *************************************************
      *************************************************
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
       6000-OPEN-CLIENT-DEB.
           OPEN INPUT CLIENT.
           IF WS-STATUS-CLIENT NOT = ZERO
              DISPLAY 'ERREUR OUVERTURE FICHIER CLIENT'
                       WS-STATUS-CLIENT
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6000-OPEN-CLIENT-FIN.
           EXIT.
      *
       6010-CLOSE-CLIENT-DEB.
           CLOSE CLIENT.
           IF WS-STATUS-CLIENT NOT = ZERO
              DISPLAY 'ERREUR FERMETURE FICHIER CLIENT'
                       WS-STATUS-CLIENT
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6010-CLOSE-CLIENT-FIN.
           EXIT.
      *
       6020-READ-CLIENT-DEB.
           READ CLIENT INTO    WS-CLIENT
           EVALUATE WS-STATUS-CLIENT
              WHEN            = '00'
                  ADD 1 TO WS-CTR-CLIENT
              WHEN            = '10'
                  CONTINUE
              WHEN OTHER
                  DISPLAY 'ERREUR LECTURE FICHIER CLIENT'
                       WS-STATUS-CLIENT
      *
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6020-READ-CLIENT-FIN.
           EXIT.
      *
      *
       6100-OPEN-COMMADE-DEB.
           OPEN INPUT COMMANDE.
           IF WS-STATUS-COMMANDE NOT = ZERO
              DISPLAY 'ERREUR OUVERTURE FICHIER COMMANDE'
                       WS-STATUS-COMMANDE
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6100-OPEN-COMMANDE-FIN.
           EXIT.
      *
       6110-CLOSE-COMMANDE-DEB.
           CLOSE COMMANDE.
           IF WS-STATUS-COMMANDE NOT = ZERO
              DISPLAY 'ERREUR FERMETURE FICHIER COMMANDE'
                       WS-STATUS-COMMANDE
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6110-CLOSE-COMMANDE-FIN.
           EXIT.
      *
       6120-READ-COMMANDE-DEB.
           READ COMMANDE INTO    WS-COMMANDE
           EVALUATE WS-STATUS-COMMANDE
              WHEN            = '00'
                  ADD 1 TO WS-CTR-COMMANDE
              WHEN            = '10'
                  CONTINUE
              WHEN OTHER
                  DISPLAY 'ERREUR LECTURE FICHIER COMMANDE'
                       WS-STATUS-COMMANDE
      *
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6120-READ-COMMANDE-FIN.
           EXIT.
      *
       6200-OPEN-ENRICHI-DEB.
           OPEN OUTPUT ENRICHI.
           IF WS-STATUS-ENRICHI NOT = ZERO
              DISPLAY 'ERREUR OUVERTURE FICHIER ENRICHI'
                       WS-STATUS-ENRICHI
      *
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6200-OPEN-ENRICHI-FIN.
           EXIT.
      *
       6210-CLOSE-ENRICHI-DEB.
           CLOSE ENRICHI.
           IF WS-STATUS-ENRICHI NOT = ZERO
              DISPLAY 'ERREUR OUVERTURE FICHIER ENRICHI'
                       WS-STATUS-ENRICHI
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6210-CLOSE-ENRICHI-FIN.
           EXIT.
      *
       6230-WRITE-ENRICHI-DEB.
           WRITE  FS-ENRICHI.
           IF  WS-STATUS-ENRICHI = ZERO
                  ADD 1 TO WS-CTR-ENRICHI
               DISPLAY 'ERREUR ECRITURE DANS FICHIER ENRICHI'
                  WS-STATUS-ENRICHI
      *
              PERFORM 9999-ERREUR-PROGRAMME-DEB
                 THRU 9999-ERREUR-PROGRAMME-FIN
              END-PERFORM
           END-IF.
       6230-WRITE-ENRICHI-FIN.
           EXIT.
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
