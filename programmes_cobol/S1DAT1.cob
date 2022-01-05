      *********************************************************
      *     CALCULE LE NOM DU JOUR DE LA SEMAINE
      *     EN FONCTION D'UN DELAI EN JOURS.
      *     DONNE EGALEMENT LE NOMBRE DE SEMAINES ET D'ANNEES
      *
      *     SI LE PROGRAMME APPELANT EST C1PAL2
      *     S1DAT1 EFFECTUE LE CALCUL SI LA ZONE DE LIEN "MOT"
      *     CONTIENT "STP"
      *     SI LE PROGRAMME APPELANT EST C1PAL2
      *     ET QUE LA ZONE DE LIEN "MOT" NE CONTIENT PAS "STP"
      *     SDAT1 RENVOIE UN CODE RETOUR 12 ET UN MESSAGE
      *
      *     SI LE PROGRAMME APPELANT EST C1PAL1
      *     S1DAT1 EFFECTUE LE CALCUL SYSTEMATIQUEMENT
      *********************************************************
           SELECT FIN-DELAI ASSIGN TO FDELAI
           FILE STATUS  IS WS-FS-IN-DELAI.

           SELECT FOU-JOUR ASSIGN TO FJOUR
           FILE STATUS  IS WS-FS-OU-JOUR.                   
      *********************************************************          
      *     C1PAL1 LIT UN FICHIER                                               
      *     et                                                
      *     APPEL UN  SOUS-PPROGRAMME     
      *           QUI CALCULE une semaine (nombre et jour) 
      *           et A PARTIR DE LA DATE DU JOUR                            
      *********************************************************             
   
      ***********************************************************
      *     C1PAL2 LIT UN FICHIER                                               
      *     AVEC UN DELAI
      *     APPEL UN SOUS-PPROGRAMME
      *           QUI CALCULE A PARTIR DU DELAI
      *           A PARTIR DE LA DATE DU JOUR
      *     SI LE MOT CLE N'EST PAS STP,
      *     LE SOUS-PROGRAMME REFUSE LE CALCUL
      *
      *     LE MOT DE PASSE EST PASSE EN PARAMETRE
      *     C'EST LA SEULE DIFFERENCE AVEC C1PAL1
      *     (A PART LA MISE A JOUR DE LA ZONE DE LIEN MOT
      *      ET LA ZONE DE LIEN QUI CONTIENT LE NOM DU PROGRAMME)
      ***********************************************************
      * Zone de communication
      ********************************************************
       LINKAGE SECTION.
      ********************************************************
       01 LS-LIEN.
          05 LS-LIEN-IN.
             10 LS-LIEN-IN-CODE          PIC X(8).
             10 LS-LIEN-IN-DELAI         PIC S9(7) COMP-3.
             10 LS-LIEN-IN-MOT           PIC X(03).
             10 FILLER                   PIC X(47).
          05 LS-LIEN-OU.
             10 LS-LIEN-OU-NB-SEM        PIC S9(5) COMP-3.
             10 LS-LIEN-OU-JOUR-SEMAINE  PIC X(10).
             10 LS-LIEN-OU-NB-ANNEE      PIC S9(3) COMP-3.
             10 LS-LIEN-OU-CODE-RETOUR   PIC XX .
             10 LS-LIEN-OU-MESSAGE       PIC X(100).
             10 FILLER                   PIC X(50).
