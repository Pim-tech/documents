       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID. DB2SQUEL.
      *
      *===============================================================*
      *--                INFORMATIONS GENERALES                     --*
      *---------------------------------------------------------------*
      *  NOM DU PROGRAMME : DB2SQUEL                                  *
      *  NOM DU REDACTEUR :                                           *
      *  SOCIETE          :                                           *
      *  DATE DE CREATION : 12/12/2013                                *
      *---------------------------------------------------------------*
      *--               OBJECTIFS GENERAUX DU PROGRAMME             --*
      *---------------------------------------------------------------*
      * ESSAI DB2 AVEC CURSEUR                                        *
      *---------------------------------------------------------------*
      *--               HISTORIQUE DES MODIFICATIONS                --*
      *---------------------------------------------------------------*
      * DATE  MODIF   §          NATURE DE LA MODIFICATION            *
      *---------------------------------------------------------------*
      *               §                                               *
      *               §                                               *
      *===============================================================*
      *
      *************************
      *                  ==============================               *
      *=================<    ENVIRONMENT    DIVISION   >==============*
      *                  ==============================               *
      *
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
      ***************
       DATA DIVISION.
      ***************
      *
      *========================
       WORKING-STORAGE SECTION.
      *========================
      *
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

      *
      *-------------------------------------------------------------*
      *      UTILISATION TABLE T1
      *-------------------------------------------------------------*
      *
           EXEC SQL
               INCLUDE CPTE1
           END-EXEC.
      *
      *
      *-------------------------------------------------------------*
      *       DECLARATION CURSEUR
      *-------------------------------------------------------------*
      *
           EXEC SQL
             DECLARE C1 CURSOR FOR SELECT *
             FROM ADCDC.CPTE1
           END-EXEC.

      *
       01    WS-SQLCODE PIC -999.
      *                  ==============================               *
      *=================<    PROCEDURE      DIVISION   >==============*
      *                  ==============================               *

      *===============================================================*
       PROCEDURE           DIVISION.
      *
      *===============================================================*
      *---------------------------------------------------------------*
      * DEBUT DU PROGRAMME                                            *
      *---------------------------------------------------------------*
      *
       0000-TRT-PRINCIPAL-DEB.
      *---------------------------------------------------------------*
      * APPEL PROCEDURE D'OUVERTURE DES FICHIERS                      *
      *---------------------------------------------------------------*
           EXEC SQL
                SET CURRENT SQLID='ADCDC'
           END-EXEC.

      *    EXEC SQL
      *      SELECT *  INTO :DEPTNO  FROM DEPT WHERE DEPTNO ='A00'
      *    END-EXEC.
      *    DISPLAY '1ER SELECT DEPARTEMENT ' DEPTNO.
      *
           EXEC SQL
             OPEN C1
           END-EXEC.
           MOVE  SQLCODE    TO WS-SQLCODE
           DISPLAY 'RETOUR OPEN ' WS-SQLCODE.
      *
           EXEC SQL
             FETCH C1
             INTO :CPTE-NUME, :CPTE-NOM
           END-EXEC.
           MOVE  SQLCODE    TO WS-SQLCODE
           DISPLAY 'RETOUR FETCH 1 ' WS-SQLCODE.
           DISPLAY '1ER  FETCH *** '     .
           IF SQLCODE = 0
               DISPLAY   "CPTE-NUME  : "  CPTE-NUME
                        " CPTE-NOM   : "  CPTE-NOM
           END-IF.
      *
           EXEC SQL
             FETCH C1
             INTO :CPTE-NUME, :CPTE-NOM
           END-EXEC.
           MOVE  SQLCODE    TO WS-SQLCODE
           DISPLAY 'RETOUR FETCH 2 ' WS-SQLCODE.
           DISPLAY '2EME FETCH ***   '   .
           IF SQLCODE = 0
               DISPLAY   "CPTE-NUME  : "  CPTE-NUME
                        " CPTE-NOM   : "  CPTE-NOM
           END-IF.
      *
           EXEC SQL
             CLOSE C1
           END-EXEC.
           MOVE  SQLCODE    TO WS-SQLCODE
           DISPLAY 'RETOUR CLOSE ' WS-SQLCODE.
      *
       0000-TRT-PRINCIPAL-FIN.
           STOP RUN.
      *
