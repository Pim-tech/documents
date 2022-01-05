       IDENTIFICATION DIVISION.                                         00010001
       PROGRAM-ID. C1PAL2.                                              00020001
                                                                        00021001
      ***********************************************************       00022005
      *     LIT UN FICHIER                                              00023001
      *     AVEC UN DELAI                                               00023101
      *     APPEL UN SOUS-PPROGRAMME                                    00023201
      *           QUI CALCULE A PARTIR DU DELAI                         00023301
      *           A PARTIR DE LA DATE DU JOUR                           00023401
      *     SI LE MOT CLE N'EST PAS STP,                                00023505
      *     LE SOUS-PROGRAMME REFUSE LE CALCUL                          00023605
      *                                                                 00023705
      *     LE MOT DE PASSE EST PASSE EN PARAMETRE                      00023805
      *     C'EST LA SEULE DIFFERENCE AVEC C1PAL1                       00023905
      *     (A PART LA MISE A JOUR DE LA ZONE DE LIEN MOT               00024005
      *      ET LA ZONE DE LIEN QUI CONTIENT LE NOM DU PROGRAMME)       00024105
      ***********************************************************       00024205
       ENVIRONMENT DIVISION.                                            00024305
      ********************************************************          00024405
       CONFIGURATION SECTION.                                           00024505
       SPECIAL-NAMES.                                                   00024605
           DECIMAL-POINT IS COMMA.                                      00024705
      ********************************************************          00024805
       INPUT-OUTPUT SECTION.                                            00024905
       FILE-CONTROL.                                                    00025005
                                                                        00025105
           SELECT FIN-DELAI ASSIGN TO FDELAI                            00025205
           FILE STATUS  IS WS-FS-IN-DELAI.                              00025305
                                                                        00025405
           SELECT FOU-JOUR ASSIGN TO FJOUR                              00025505
           FILE STATUS  IS WS-FS-OU-JOUR.                               00025605
                                                                        00025705
      ********************************************************          00025805
       DATA DIVISION.                                                   00025905
      ********************************************************          00026005
       FILE SECTION.                                                    00026105
                                                                        00026205
       FD FIN-DELAI                                                     00026305
           RECORDING MODE IS F.                                         00026405
       01 FS-ENRINP-DELAI PIC   X(100).                                 00026505
                                                                        00026605
       FD FOU-JOUR                                                      00026705
           RECORDING MODE IS F.                                         00026805
       01 FS-ENROUT-JOUR  PIC   X(100).                                 00026905
      ********************************************************          00027005
       WORKING-STORAGE SECTION.                                         00027105
      ********************************************************          00027205
      * ENREGISTREMENTS                                                 00027305
      ********************************************************          00027405
       01 WS-IN.                                                        00027505
          05 WS-IN-SIGNE     PIC X.                                     00027605
          05 WS-IN-DELAI     PIC 9(7).                                  00027705
          05 FILLER          PIC X(92).                                 00028001
                                                                        00028201
       01 WS-OU.                                                        00028301
          05 WS-OU-SIGNE         PIC X.                                 00028401
          05 WS-OU-DELAI         PIC 9(7).                              00028501
          05 WS-OU-NB-SEM        PIC S9(5).                             00028601
          05 WS-OU-JOUR-SEMAINE  PIC X(10).                             00028701
          05 WS-OU-NB-ANNEE      PIC 9(3).                              00028801
          05 WS-OU-CODE-RETOUR   PIC XX.                                00028901
          05 WS-OU-MESSAGE       PIC X(72).                             00029001
     **** 05 FILLER              PIC X(100).                            00029101
       01 WS-ACCEPT.                                                    00029204
          05 WS-ACCEPT-MOT   PIC XXX.                                   00029304
          05 FILLER          PIC X(77).                                 00029504
                                                                        00029604
                                                                        00029701
      ********************************************************          00029801
      * STATUS                                                          00029901
      ********************************************************          00030001
       01 WS-FS-IN-DELAI     PIC   XX.                                  00030101
       01 WS-FS-OU-JOUR      PIC   XX.                                  00030201
                                                                        00030301
      ********************************************************          00030401
      * ZONES DE LIEN VERS SOUS-PROGRAMME                               00030501
      ********************************************************          00030601
       01 WS-SOUS-PROG       PIC X(8) VALUE 'S1DAT1'.                   00030701
       01 WS-LIEN.                                                      00030801
          05 WS-LIEN-IN.                                                00030901
             10 WS-LIEN-IN-CODE          PIC X(8).                      00031001
             10 WS-LIEN-IN-DELAI         PIC S9(7) COMP-3.              00031101
             10 WS-LIEN-IN-MOT           PIC X(3).                      00031203
             10 FILLER                   PIC X(47).                     00031302
          05 WS-LIEN-OU.                                                00031402
             10 WS-LIEN-OU-NB-SEM        PIC S9(5) COMP-3.              00031502
             10 WS-LIEN-OU-JOUR-SEMAINE  PIC X(10).                     00031602
             10 WS-LIEN-OU-NB-ANNEE      PIC S9(3) COMP-3.              00031702
             10 WS-LIEN-OU-CODE-RETOUR   PIC XX .                       00031802
             10 WS-LIEN-OU-MESSAGE       PIC X(100).                    00031902
             10 FILLER                   PIC X(50).                     00032002
      ********************************************************          00032102
      * ZONES D'ETAT                                                    00032202
      ********************************************************          00032302
                                                                        00032402
      ********************************************************          00032502
      * ZONES DE TRAVAIL                                                00032602
      ********************************************************          00032702
       01 WS-FLAG-IN      PIC  XXX           VALUE SPACE.               00033001
       01 WS-CTR-IN       PIC S999   COMP-3  VALUE ZERO.                00034001
       01 WS-CTR-OU       PIC S999   COMP-3  VALUE ZERO.                00034101
       01 WS-CTRZ-IN      PIC ZZ9.                                      00034201
       01 WS-CTRZ-OU      PIC ZZ9.                                      00034301
      ********************************************************          00034401
      *LINKAGE-STORAGE SECTION.                                         00034501
      ********************************************************          00034601
       PROCEDURE DIVISION.                                              00034701
      *********************************************************         00034801
       0000-C1PAL2-DEB.                                                 00034901
                                                                        00035001
           ACCEPT WS-ACCEPT.                                            00035104
      * OUVERTURE FICHIER FINP                                          00036001
           PERFORM 6000-FIN-OUV-DEB                                     00036101
              THRU 6000-FIN-OUV-FIN.                                    00036201
      * OUVERTURE FICHIER FOUT                                          00036301
           PERFORM 6100-FOUT-OU-DEB                                     00036401
              THRU 6100-FOUT-OU-FIN.                                    00036501
      * LIRE UNE PREMIERE FOIS LE FICHIER                               00036601
           PERFORM 6010-FINP-LEC-DEB                                    00036701
              THRU 6010-FINP-LEC-FIN.                                   00036801
      * GESTION DE FICHIER VIDE                                         00036901
           IF WS-FS-IN-DELAI = '10'                                     00037001
              MOVE 'FICHIER VIDE' TO WS-OU                              00037101
              MOVE 'FIN'  TO WS-FLAG-IN                                 00037201
           END-IF.                                                      00037301
                                                                        00037401
           PERFORM 1000-CONVERSION-DEB                                  00037501
             THRU  1000-CONVERSION-FIN                                  00037601
             UNTIL WS-FLAG-IN = 'FIN'                                   00037701
                                                                        00037801
      * FERMETURE FICHIER FINP                                          00037901
           PERFORM 6020-FIN-CLO-DEB                                     00038001
              THRU 6020-FIN-CLO-FIN.                                    00039001
      * FERMETURE FICHIER FOUT                                          00040001
           PERFORM 6120-FOUT-CLO-DEB                                    00041001
              THRU 6120-FOUT-CLO-FIN.                                   00042001
                                                                        00043001
      * AFFICHAGE DES STATISTIQUES                                      00043101
           PERFORM 8999-STATISTIQUES-DEB                                00043201
              THRU 8999-STATISTIQUES-FIN.                               00043301
      * FIN NORMALE DU PROGRAMME                                        00043401
           PERFORM 9998-FIN-NORMALE-DEB                                 00043501
              THRU 9998-FIN-NORMALE-FIN.                                00043601
                                                                        00043701
       0000-C1PAL2-FIN. EXIT.                                           00043801
      ******************************************                        00043901
       1000-CONVERSION-DEB.                                             00044001
      * INITIALISATION DE LA ZONE DE LIEN                               00044101
      *  PAS D'OCCURS =>  IL SUFFIT D'UN INITIALIZE                     00044201
           INITIALIZE    WS-LIEN.                                       00044301
                                                                        00044401
      * TRAITEMENT POUR CONVERTIR LE DELAI EN FONCTION DU SIGNE         00044501
           MOVE WS-IN-DELAI TO WS-LIEN-IN-DELAI.                        00044601
           IF WS-IN-SIGNE = '-'                                         00044701
              MULTIPLY WS-LIEN-IN-DELAI BY -1                           00044801
                GIVING WS-LIEN-IN-DELAI.                                00044901
           MOVE 'C1PAL2'      TO WS-LIEN-IN-CODE.                       00045004
           MOVE WS-ACCEPT-MOT TO  WS-LIEN-IN-MOT  .                     00045104
                                                                        00045301
      * TRAITEMENT PRINCIPAL                                            00045401
           CALL WS-SOUS-PROG                                            00045501
                USING WS-LIEN.                                          00045601
                                                                        00045701
      * ECRITURE DANS FICHIER FOUT                                      00045801
           INITIALIZE    WS-OU.                                         00045901
                                                                        00046001
           MOVE WS-IN-SIGNE             TO WS-OU-SIGNE.                 00046101
           MOVE WS-IN-DELAI             TO WS-OU-DELAI.                 00046201
           MOVE WS-LIEN-OU-NB-SEM       TO WS-OU-NB-SEM                 00046301
           MOVE WS-LIEN-OU-JOUR-SEMAINE TO WS-OU-JOUR-SEMAINE           00046401
           MOVE WS-LIEN-OU-NB-ANNEE     TO WS-OU-NB-ANNEE               00046501
           MOVE WS-LIEN-OU-MESSAGE      TO WS-OU-MESSAGE.               00046601
      * ECRITURE                                                        00046701
           PERFORM 6130-FOU-ECRITURE-DEB                                00046801
              THRU 6130-FOU-ECRITURE-FIN.                               00046901
      * LIRE LE FICHIER                                                 00047001
           PERFORM 6010-FINP-LEC-DEB                                    00047101
              THRU 6010-FINP-LEC-FIN.                                   00048001
                                                                        00049001
       1000-CONVERSION-FIN.  EXIT.                                      00049101
      ******************************************                        00049201
       6000-FIN-OUV-DEB.                                                00049301
      * OUVERTURE DE FICHIER FIN-DELAI                                  00049401
           OPEN INPUT FIN-DELAI.                                        00049501
           MOVE SPACE TO WS-FLAG-IN.                                    00049601
           IF WS-FS-IN-DELAI NOT = ZERO                                 00049701
               DISPLAY 'PB OUVERTURE DU FICHIER FIN-DELAI'              00049801
               DISPLAY 'CODE : ' WS-FS-IN-DELAI                         00049901
               PERFORM 9999-ERREUR-PROGRAMME-DEB                        00050001
               THRU    9999-ERREUR-PROGRAMME-FIN.                       00050101
       6000-FIN-OUV-FIN. EXIT.                                          00050201
                                                                        00050301
       6010-FINP-LEC-DEB.                                               00050401
      * LECTURE D'UN ENREGISTREMENT DE FIN-DELAI                        00050501
           READ FIN-DELAI INTO WS-IN                                    00050601
               AT END                                                   00050701
               MOVE 'FIN' TO WS-FLAG-IN.                                00050801
           IF WS-FS-IN-DELAI NOT = ZERO  AND NOT = '10'                 00050901
               DISPLAY 'PB LECTURE DU FICHIER NOMBRES'                  00051001
               DISPLAY 'CODE : ' WS-FS-IN-DELAI                         00051101
               PERFORM 9999-ERREUR-PROGRAMME-DEB                        00051201
               THRU    9999-ERREUR-PROGRAMME-FIN.                       00051301
           IF WS-FS-IN-DELAI = ZERO                                     00051401
               ADD 1 TO WS-CTR-IN.                                      00051501
           IF WS-FS-IN-DELAI = '10'                                     00051601
               MOVE 'FIN' TO WS-FLAG-IN.                                00051701
       6010-FINP-LEC-FIN. EXIT.                                         00051801
                                                                        00051901
       6020-FIN-CLO-DEB.                                                00052001
      * FERMETURE DE FICHIER FIN-DELAI                                  00053001
           CLOSE FIN-DELAI.                                             00054001
           IF WS-FS-IN-DELAI NOT = ZERO                                 00055001
               DISPLAY 'PB FERMETURE DU FICHIER FIN-DELAI'              00056001
               DISPLAY 'CODE : ' WS-FS-IN-DELAI                         00057001
               PERFORM 9999-ERREUR-PROGRAMME-DEB                        00058001
               THRU    9999-ERREUR-PROGRAMME-FIN.                       00059001
       6020-FIN-CLO-FIN. EXIT.                                          00060001
                                                                        00070001
      ******************                                                00080001
                                                                        00090001
       6100-FOUT-OU-DEB.                                                00100001
      * OUVERTURE DE FICHIER FOU-JOUR                                   00100101
           OPEN OUTPUT FOU-JOUR.                                        00100201
           IF WS-FS-OU-JOUR NOT = ZERO                                  00100301
               DISPLAY 'PB OUVERTURE DU FICHIER FOU-JOUR'               00100401
               DISPLAY 'CODE : ' WS-FS-OU-JOUR                          00100501
               PERFORM 9999-ERREUR-PROGRAMME-DEB                        00100601
               THRU    9999-ERREUR-PROGRAMME-FIN.                       00100701
       6100-FOUT-OU-FIN. EXIT.                                          00100801
                                                                        00100901
       6120-FOUT-CLO-DEB.                                               00101001
      * FERMETURE DE FICHIER FOU-JOUR                                   00101101
           CLOSE FOU-JOUR.                                              00101201
           IF WS-FS-OU-JOUR NOT = ZERO                                  00101301
               DISPLAY 'PB FERMETURE DU FICHIER FOU-JOUR'               00101401
               DISPLAY 'CODE : ' WS-FS-OU-JOUR                          00101501
               PERFORM 9999-ERREUR-PROGRAMME-DEB                        00101601
               THRU    9999-ERREUR-PROGRAMME-FIN.                       00101701
       6120-FOUT-CLO-FIN. EXIT.                                         00101801
                                                                        00101901
       6130-FOU-ECRITURE-DEB.                                           00102001
      * ECRITURE D'UN ENREGISTREMENT DE FOU-JOUR                        00103001
           WRITE FS-ENROUT-JOUR FROM WS-OU                              00104001
           END-WRITE.                                                   00105001
           IF WS-FS-OU-JOUR NOT = ZERO                                  00106001
               DISPLAY 'PB ECRITURE DU FICHIER FOU-JOUR'                00107001
               DISPLAY 'CODE : ' WS-FS-OU-JOUR                          00108001
               PERFORM 9999-ERREUR-PROGRAMME-DEB                        00109001
               THRU    9999-ERREUR-PROGRAMME-FIN.                       00110001
           IF WS-FS-OU-JOUR = ZERO                                      00110101
               ADD 1 TO WS-CTR-OU.                                      00110201
       6130-FOU-ECRITURE-FIN. EXIT.                                     00110301
                                                                        00110401
      ******************************************                        00110501
                                                                        00110601
      ******************************************                        00110701
       8999-STATISTIQUES-DEB.                                           00110801
           MOVE   WS-CTR-IN    TO  WS-CTRZ-IN .                         00110901
           MOVE   WS-CTR-OU    TO  WS-CTRZ-OU .                         00111001
           DISPLAY ' '.                                                 00112001
           DISPLAY '**********************************'                 00113001
           DISPLAY '* STATISTIQUES DU PROGRAMME C1PAL2'                 00114001
           DISPLAY '**********************************'                 00114101
           DISPLAY '                                  '                 00114201
           DISPLAY 'ENREGISTREMENTS LUS    : ' WS-CTRZ-IN.              00114301
           DISPLAY 'ENREGISTREMENTS ECRITS : ' WS-CTRZ-OU.              00114401
           DISPLAY ' '.                                                 00114501
       8999-STATISTIQUES-FIN. EXIT.                                     00114601
      ******************************************                        00114701
       9998-FIN-NORMALE-DEB.                                            00114801
           DISPLAY '**********************************'                 00114901
           DISPLAY '* FIN NORMALE DU PROGRAMME C1PAL2*'                 00115001
           DISPLAY '**********************************'                 00116001
           STOP RUN.                                                    00116101
       9998-FIN-NORMALE-FIN. EXIT.                                      00116201
                                                                        00116301
       9999-ERREUR-PROGRAMME-DEB.                                       00116401
           MOVE   WS-CTR-IN    TO  WS-CTRZ-IN .                         00116501
           MOVE   WS-CTR-OU    TO  WS-CTRZ-OU .                         00116601
           DISPLAY '**********************************'                 00116701
           DISPLAY '* UNE ANOMALIE A ETE DETECTEE *'                    00116801
           DISPLAY '* ERREUR DANS LES ENREGISTREMENTS*'                 00116901
           DISPLAY '**********************************'.                00117001
           DISPLAY 'ENREGISTREMENTS LUS    : ' WS-CTRZ-IN.              00117101
           DISPLAY 'ENREGISTREMENTS ECRITS : ' WS-CTRZ-OU.              00117201
           DISPLAY 'STATUS LECTURE         : ' WS-FS-IN-DELAI           00117301
           DISPLAY 'STATUS ECRITURE        : ' WS-FS-OU-JOUR.           00117401
           STOP RUN.                                                    00117501
       9999-ERREUR-PROGRAMME-FIN. EXIT.                                 00117601
