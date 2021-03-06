       IDENTIFICATION DIVISION.
       PROGRAM-ID. C1PAL1.

      *********************************************************
      *     LIT UN FICHIER
      *     AVELAI
      *     APPEL UN C UN DESOUS-PPROGRAMME
      *           QUI CALCULE A PARTIR DU DELAI
      *           A PARTIR DE LA DATE DU JOUR
      *********************************************************
       ENVIRONMENT DIVISION.
      ********************************************************
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      ********************************************************
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT FIN-DELAI ASSIGN TO FDELAI
           FILE STATUS  IS WS-FS-IN-DELAI.

           SELECT FOU-JOUR ASSIGN TO FJOUR
           FILE STATUS  IS WS-FS-OU-JOUR.

      ********************************************************
       DATA DIVISION.
      ********************************************************
       FILE SECTION.

      *  COMME ON UTILISE LES READ INTO ET WRITE FROM
      *  ON NE DETAILLE PAS LES ENREGISTREMNTS EN FS

       FD FIN-DELAI
           RECORDING MODE IS F.
       01 FS-ENRINP-DELAI PIC   X(100).

       FD FOU-JOUR
           RECORDING MODE IS F.
       01 FS-ENROUT-JOUR  PIC   X(100).
      ********************************************************
       WORKING-STORAGE SECTION.
      ********************************************************
      * ENREGISTREMENTS
      *************************************************************
      *   DANS LE PROGRAMME C1PAL2 LE SOUS-PROGRAMME UTILISE UNE
      *   ZONE SUPPLEMENTAIRE
      *   COMME IL NE L'UTILISE PAS AVEC C1PAL1,
      *   SA DESCRITPION EST ICI FACULTATIVE
      *************************************************************
       01 WS-IN.
          05 WS-IN-SIGNE     PIC X.
          05 WS-IN-DELAI     PIC 9(7).
          05 FILLER          PIC X(92).

       01 WS-OU.
          05 WS-OU-SIGNE         PIC X.
          05 WS-OU-DELAI         PIC 9(7).
          05 WS-OU-NB-SEM        PIC S9(5).
          05 WS-OU-JOUR-SEMAINE  PIC X(10).
          05 WS-OU-NB-ANNEE      PIC 9(3).
          05 WS-OU-CODE-RETOUR   PIC XX.
          05 WS-OU-MESSAGE       PIC X(72).

      **** SI L'ENREGISTREMENT EN FS EST PLUS LONG
      ****    IL SERA TRONQUE
      **** SI L'ENREGISTREMENT EN FS EST PLUS COURT
      ****    IL SERA COMPLETE AVEC DES BLANCS

      ********************************************************
      * STATUS
      ********************************************************
       01 WS-FS-IN-DELAI     PIC   XX.
       01 WS-FS-OU-JOUR      PIC   XX.

      ********************************************************
      * ZONES DE LIEN VERS SOUS-PROGRAMME
      ********************************************************
      * LA ZONE DE LIEN DOIT ETRE DE LA MEME LONGUEUR
      * DANS LE PROGRAMME ET LE SOUS-PROGRAMME
      *
      * LES VARIABLES PEUVENT PORTER DES NOMS DIFFERENTS
      * ET LEUR ADRESSE AUSSI DOIT ETRE IDENTIQUE
      *
      * LE FORMAT DES ZONES UTILISEES DOIT ETRE IDENTIQUE
      *
      ********************************************************
       01 WS-SOUS-PROG       PIC X(8) VALUE 'S1DAT1'.
       01 WS-LIEN.
          05 WS-LIEN-IN.
             10 WS-LIEN-IN-CODE          PIC X(8).
             10 WS-LIEN-IN-DELAI         PIC S9(7) COMP-3.
             10 FILLER                   PIC X(50).
          05 WS-LIEN-OU.
             10 WS-LIEN-OU-NB-SEM        PIC S9(5) COMP-3.
             10 WS-LIEN-OU-JOUR-SEMAINE  PIC X(10).
             10 WS-LIEN-OU-NB-ANNEE      PIC S9(3) COMP-3.
             10 WS-LIEN-OU-CODE-RETOUR   PIC XX .
             10 WS-LIEN-OU-MESSAGE       PIC X(100).
             10 FILLER                   PIC X(50).
      ********************************************************
      * ZONES D'ETAT
      ********************************************************

      ********************************************************
      * ZONES DE TRAVAIL
      ********************************************************
       01 WS-FLAG-IN      PIC  XXX           VALUE SPACE.
       01 WS-CTR-IN       PIC S999   COMP-3  VALUE ZERO.
       01 WS-CTR-OU       PIC S999   COMP-3  VALUE ZERO.
       01 WS-CTRZ-IN      PIC ZZ9.
       01 WS-CTRZ-OU      PIC ZZ9.
      ********************************************************
      *LINKAGE-STORAGE SECTION.
      ********************************************************
       PROCEDURE DIVISION.
      *********************************************************
       0000-C1PAL1-DEB.

      * OUVERTURE FICHIER FINP
           PERFORM 6000-FIN-OUV-DEB
              THRU 6000-FIN-OUV-FIN.
      * OUVERTURE FICHIER FOUT
           PERFORM 6100-FOUT-OU-DEB
              THRU 6100-FOUT-OU-FIN.
      * LIRE UNE PREMIERE FOIS LE FICHIER
           PERFORM 6010-FINP-LEC-DEB
              THRU 6010-FINP-LEC-FIN.
      * GESTION DE FICHIER VIDE
           IF WS-FS-IN-DELAI = '10'
              MOVE 'FICHIER VIDE' TO WS-OU
              MOVE 'FIN'  TO WS-FLAG-IN
           END-IF.

           PERFORM 1000-CONVERSION-DEB
             THRU  1000-CONVERSION-FIN
             UNTIL WS-FLAG-IN = 'FIN'

      * FERMETURE FICHIER FINP
           PERFORM 6020-FIN-CLO-DEB
              THRU 6020-FIN-CLO-FIN.
      * FERMETURE FICHIER FOUT
           PERFORM 6120-FOUT-CLO-DEB
              THRU 6120-FOUT-CLO-FIN.

      * AFFICHAGE DES STATISTIQUES
           PERFORM 8999-STATISTIQUES-DEB
              THRU 8999-STATISTIQUES-FIN.
      * FIN NORMALE DU PROGRAMME
           PERFORM 9998-FIN-NORMALE-DEB
              THRU 9998-FIN-NORMALE-FIN.

       0000-C1PAL1-FIN. EXIT.
      ******************************************
       1000-CONVERSION-DEB.
      * INITIALISATION DE LA ZONE DE LIEN
      *  PAS D'OCCURS =>  IL SUFFIT D'UN INITIALIZE
           INITIALIZE    WS-LIEN.

      * TRAITEMENT POUR CONVERTIR LE DELAI EN FONCTION DU SIGNE
           MOVE WS-IN-DELAI TO WS-LIEN-IN-DELAI.
           IF WS-IN-SIGNE = '-'
              MULTIPLY WS-LIEN-IN-DELAI BY -1
                GIVING WS-LIEN-IN-DELAI.
           MOVE 'C1PAL1'  TO WS-LIEN-IN-CODE.


      * TRAITEMENT PRINCIPAL
           CALL WS-SOUS-PROG
                USING WS-LIEN.

      * ECRITURE DANS FICHIER FOUT
           INITIALIZE    WS-OU.

           MOVE WS-IN-SIGNE             TO WS-OU-SIGNE.
           MOVE WS-IN-DELAI             TO WS-OU-DELAI.
           MOVE WS-LIEN-OU-NB-SEM       TO WS-OU-NB-SEM
           MOVE WS-LIEN-OU-JOUR-SEMAINE TO WS-OU-JOUR-SEMAINE
           MOVE WS-LIEN-OU-NB-ANNEE     TO WS-OU-NB-ANNEE
           MOVE WS-LIEN-OU-MESSAGE      TO WS-OU-MESSAGE.
      * ECRITURE
           PERFORM 6130-FOU-ECRITURE-DEB
              THRU 6130-FOU-ECRITURE-FIN.
      * LIRE LE FICHIER
           PERFORM 6010-FINP-LEC-DEB
              THRU 6010-FINP-LEC-FIN.

       1000-CONVERSION-FIN.  EXIT.
      ******************************************
       6000-FIN-OUV-DEB.
      * OUVERTURE DE FICHIER FIN-DELAI
           OPEN INPUT FIN-DELAI.
           MOVE SPACE TO WS-FLAG-IN.
           IF WS-FS-IN-DELAI NOT = ZERO
               DISPLAY 'PB OUVERTURE DU FICHIER FIN-DELAI'
               DISPLAY 'CODE : ' WS-FS-IN-DELAI
               PERFORM 9999-ERREUR-PROGRAMME-DEB
               THRU    9999-ERREUR-PROGRAMME-FIN.
       6000-FIN-OUV-FIN. EXIT.

       6010-FINP-LEC-DEB.
      * LECTURE D'UN ENREGISTREMENT DE FIN-DELAI
           READ FIN-DELAI INTO WS-IN
               AT END
               MOVE 'FIN' TO WS-FLAG-IN.
           IF WS-FS-IN-DELAI NOT = ZERO  AND NOT = '10'
               DISPLAY 'PB LECTURE DU FICHIER NOMBRES'
               DISPLAY 'CODE : ' WS-FS-IN-DELAI
               PERFORM 9999-ERREUR-PROGRAMME-DEB
               THRU    9999-ERREUR-PROGRAMME-FIN.
           IF WS-FS-IN-DELAI = ZERO
               ADD 1 TO WS-CTR-IN.
           IF WS-FS-IN-DELAI = '10'
               MOVE 'FIN' TO WS-FLAG-IN.
       6010-FINP-LEC-FIN. EXIT.

       6020-FIN-CLO-DEB.
      * FERMETURE DE FICHIER FIN-DELAI
           CLOSE FIN-DELAI.
           IF WS-FS-IN-DELAI NOT = ZERO
               DISPLAY 'PB FERMETURE DU FICHIER FIN-DELAI'
               DISPLAY 'CODE : ' WS-FS-IN-DELAI
               PERFORM 9999-ERREUR-PROGRAMME-DEB
               THRU    9999-ERREUR-PROGRAMME-FIN.
       6020-FIN-CLO-FIN. EXIT.

      ******************

       6100-FOUT-OU-DEB.
      * OUVERTURE DE FICHIER FOU-JOUR
           OPEN OUTPUT FOU-JOUR.
           IF WS-FS-OU-JOUR NOT = ZERO
               DISPLAY 'PB OUVERTURE DU FICHIER FOU-JOUR'
               DISPLAY 'CODE : ' WS-FS-OU-JOUR
               PERFORM 9999-ERREUR-PROGRAMME-DEB
               THRU    9999-ERREUR-PROGRAMME-FIN.
       6100-FOUT-OU-FIN. EXIT.

       6120-FOUT-CLO-DEB.
      * FERMETURE DE FICHIER FOU-JOUR
           CLOSE FOU-JOUR.
           IF WS-FS-OU-JOUR NOT = ZERO
               DISPLAY 'PB FERMETURE DU FICHIER FOU-JOUR'
               DISPLAY 'CODE : ' WS-FS-OU-JOUR
               PERFORM 9999-ERREUR-PROGRAMME-DEB
               THRU    9999-ERREUR-PROGRAMME-FIN.
       6120-FOUT-CLO-FIN. EXIT.

       6130-FOU-ECRITURE-DEB.
      * ECRITURE D'UN ENREGISTREMENT DE FOU-JOUR
           WRITE FS-ENROUT-JOUR FROM WS-OU
           END-WRITE.
           IF WS-FS-OU-JOUR NOT = ZERO
               DISPLAY 'PB ECRITURE DU FICHIER FOU-JOUR'
               DISPLAY 'CODE : ' WS-FS-OU-JOUR
               PERFORM 9999-ERREUR-PROGRAMME-DEB
               THRU    9999-ERREUR-PROGRAMME-FIN.
           IF WS-FS-OU-JOUR = ZERO
               ADD 1 TO WS-CTR-OU.
       6130-FOU-ECRITURE-FIN. EXIT.

      ******************************************

      ******************************************
       8999-STATISTIQUES-DEB.
           MOVE   WS-CTR-IN    TO  WS-CTRZ-IN .
           MOVE   WS-CTR-OU    TO  WS-CTRZ-OU .
           DISPLAY ' '.
           DISPLAY '**********************************'
           DISPLAY '* STATISTIQUES DU PROGRAMME C1PAL1'
           DISPLAY '**********************************'
           DISPLAY '                                  '
           DISPLAY 'ENREGISTREMENTS LUS    : ' WS-CTRZ-IN.
           DISPLAY 'ENREGISTREMENTS ECRITS : ' WS-CTRZ-OU.
           DISPLAY ' '.
       8999-STATISTIQUES-FIN. EXIT.
      ******************************************
       9998-FIN-NORMALE-DEB.
           DISPLAY '**********************************'
           DISPLAY '* FIN NORMALE DU PROGRAMME C1PAL1*'
           DISPLAY '**********************************'
           STOP RUN.
       9998-FIN-NORMALE-FIN. EXIT.

       9999-ERREUR-PROGRAMME-DEB.
           MOVE   WS-CTR-IN    TO  WS-CTRZ-IN .
           MOVE   WS-CTR-OU    TO  WS-CTRZ-OU .
           DISPLAY '**********************************'
           DISPLAY '* UNE ANOMALIE A ETE DETECTEE *'
           DISPLAY '* ERREUR DANS LES ENREGISTREMENTS*'
           DISPLAY '**********************************'.
           DISPLAY 'ENREGISTREMENTS LUS    : ' WS-CTRZ-IN.
           DISPLAY 'ENREGISTREMENTS ECRITS : ' WS-CTRZ-OU.
           DISPLAY 'STATUS LECTURE         : ' WS-FS-IN-DELAI
           DISPLAY 'STATUS ECRITURE        : ' WS-FS-OU-JOUR.
           STOP RUN.
       9999-ERREUR-PROGRAMME-FIN. EXIT.
