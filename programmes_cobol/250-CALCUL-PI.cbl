       IDENTIFICATION DIVISION.
       PROGRAM-ID. B30501.
      ******************************************************
      * EXERCICE SUR LES OPERATIONS ARITHMETIQUES          *
      *                                                    *
      *   CALCULER PI/2 EN APPLICANT LA SUITE              *
      *   MULTIPLICATIONS SUIVANTES :                      *
      *   (2/1) * (2/3) * (4/3) * (4/5) * ( 6/5) ETC       *
      *                                                    *
      *   PARAMETRER LE NOMBRE D'ITERATIONS                *
      *                                                    *
      *   ATTENTION AUX FORMATS DES VARIABLES              *
      *                                                    *
      ******************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROGRAM-ID     PIC X(8) VALUE 'B30501'.
       01 WS-RESULTAT       PIC 9V9(17).
       01 WS-NUMERATEUR     PIC 9(4).
       01 WS-DENOMINATEUR   PIC 9(4).
       01 WS-NUMERATEUR-MAX PIC 9(4).
       01 WS-INTERMED       PIC 9(4)V9(14).
      ******************************************************
       PROCEDURE DIVISION.
       0000-PI-DEB.
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.
      *
           ACCEPT WS-NUMERATEUR-MAX.
           MOVE   0 TO WS-NUMERATEUR.
           MOVE   2 TO WS-RESULTAT.
           PERFORM 1000-CALCUL-DEB
              THRU 1000-CALCUL-FIN
             UNTIL WS-NUMERATEUR > WS-NUMERATEUR-MAX.
      *
           PERFORM 8910-DEB-STATISTIQUES-DEB
              THRU 8910-DEB-STATISTIQUES-FIN.
           PERFORM 9999-FIN-NORMALE-DEB
              THRU 9999-FIN-NORMALE-FIN.
       0000-PI-FIN.
           EXIT.
      *
       1000-CALCUL-DEB.
           ADD  2                TO WS-NUMERATEUR

           MOVE WS-NUMERATEUR    TO WS-INTERMED.
           SUBTRACT 1 FROM WS-NUMERATEUR
            GIVING WS-DENOMINATEUR
           DIVIDE  WS-DENOMINATEUR
             INTO WS-INTERMED.
           MULTIPLY WS-INTERMED
             BY     WS-RESULTAT.

           MOVE WS-NUMERATEUR    TO WS-INTERMED.
           ADD 1 TO WS-NUMERATEUR GIVING WS-DENOMINATEUR.
           DIVIDE WS-DENOMINATEUR
             INTO WS-INTERMED.
           MULTIPLY WS-INTERMED
             BY     WS-RESULTAT.
      *
           DISPLAY  WS-RESULTAT
                   ' POUR NUMERATEUR : ' WS-NUMERATEUR.
       1000-CALCUL-FIN.
           EXIT.
      ******************************************************
      *       STATISTIQUES                                 *
      ******************************************************
       8910-DEB-STATISTIQUES-DEB.
           DISPLAY '**************************************'.
           DISPLAY 'DEBUT DU PROGRAMME'   WS-PROGRAM-ID.
           DISPLAY '**************************************'.
           DISPLAY '                                      '.
           DISPLAY 'CALCULER PI EN APPLICANT LA SUITE     '.
           DISPLAY 'MULTIPLICATIONS SUIVANTES :           '.
           DISPLAY '2 * (/1) * (2/3) * (4/3) * (4/5) ETC  '.
           DISPLAY '                                      '.
           DISPLAY 'PARAMETRER LE NOMBRE D''ITERATIONS     '.
           DISPLAY '                                      '.
           DISPLAY 'ATTENTION AUX FORMATS DES VARIABLES   '.
           DISPLAY '**************************************'.
       8910-DEB-STATISTIQUES-FIN.
           EXIT.
       8990-FIN-STATISTIQUES-DEB.
           DISPLAY '**************************************'
           DISPLAY 'STATISTIQUES DU PROGRAMME ' WS-PROGRAM-ID.
           DISPLAY '**************************************'
           DISPLAY '**************************************'.
       8990-FIN-STATISTIQUES-FIN.
           EXIT.
      ********************************************************
      *      FIN ANORMALE                                    *
      ********************************************************
       9990-FIN-ANORMALE-DEB.
           DISPLAY '*****************************************'
           DISPLAY 'FIN ANORMALE DU PROGRAMME' WS-PROGRAM-ID.
           DISPLAY '*****************************************'
           STOP RUN.
       9990-FIN-ANORMALE-FIN.
           EXIT.
      ******************************************************
      *      FIN NORMALE                                   *
      ******************************************************
       9999-FIN-NORMALE-DEB.
           DISPLAY '****************************************'
           DISPLAY 'FIN NORMALE DU PROGRAMME ' WS-PROGRAM-ID.
           DISPLAY '****************************************'
           STOP RUN.
       9999-FIN-NORMALE-FIN.
           EXIT.
