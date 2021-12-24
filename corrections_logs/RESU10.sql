---------+
   SELECT  (QTES  * PRXART) AS VALEUR, QTES, PRXART
     , A.IDART, LIBART ,IDDEC
      FROM TDECL D
       ,   TARTI A
    WHERE D.IDART = A.IDART
      ORDER BY 1, 2
      ;
---------+
      VALEUR   QTES     PRXART    IDART  LIBART                IDDEC
---------+
       10.40     2.       5.20       6.  CASQUETTE               72.
       26.00     5.       5.20       6.  CASQUETTE               70.
       41.40    12.       3.45       2.  T-SHIRT                 80.
       46.80     9.       5.20       6.  CASQUETTE               73.
       65.55    19.       3.45       2.  T-SHIRT                 84.
       83.20    16.       5.20       6.  CASQUETTE               71.
       86.25    25.       3.45       2.  T-SHIRT                 81.
      158.70    46.       3.45       2.  T-SHIRT                 83.
      179.40    52.       3.45       2.  T-SHIRT                 82.
      208.00    40.       5.20       6.  CASQUETTE               74.
      967.60     8.     120.95       1.  BASKETS                 93.
     2298.05    19.     120.95       1.  BASKETS                 91.
     4596.10    38.     120.95       1.  BASKETS                 92.
     8708.40    72.     120.95       1.  BASKETS                 90.
    11127.40    92.     120.95       1.  BASKETS                 94.
DSNE610I NUMBER OF ROWS DISPLAYED IS 15
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
-------------------
   SELECT        MAX(QTES  * PRXART) AS VALEUR
      FROM TDECL D
       ,   TARTI A
    WHERE D.IDART = A.IDART
      ;
---------+
      VALEUR
---------+
    11127.40
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
-------------------
   SELECT A.IDART, IDDEC, LIBART, COLORIS
        , (QTES  * PRXART)
      FROM TDECL D
       ,   TARTI A
      WHERE  (QTES  * PRXART)  IN
      ( SELECT        MAX(QTES  * PRXART) AS VALEUR
           FROM TDECL D
            ,   TARTI A
         WHERE D.IDART = A.IDART
      )
      ;
---------+
  IDART  IDDEC  LIBART                COLORIS
---------+
     1.    94.  BASKETS               BLEU                      11127.40
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
-------------------
   SELECT  SUM((QTES  * PRXART)) AS VALEUR
     , A.IDART, LIBART
      FROM TDECL D
       ,   TARTI A
    WHERE D.IDART = A.IDART
    GROUP BY A.IDART, LIBART
      ORDER BY 1, 2
      ;
---------
           VALEUR    IDART  LIBART
---------
           374.40       6.  CASQUETTE
           531.30       2.  T-SHIRT
         27697.55       1.  BASKETS
DSNE610I NUMBER OF ROWS DISPLAYED IS 3
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
-------------------
   SELECT  (QTES  * PRXART) AS VALEUR
     , A.IDART, LIBART ,IDDEC
      FROM TDECL D
       ,   TARTI A
    WHERE D.IDART = A.IDART
    GROUP BY  A.IDART, LIBART ,IDDEC
    HAVING
            (QTES  * PRXART) >=  ALL
      (SELECT MAX(QTES  * PRXART)
        FROM TDECL DD
         ,   TARTI AA
         WHERE DD.IDART = AA.IDART
      )
      ORDER BY 1, 2
      ;
---------
DSNT408I SQLCODE = -104, ERROR:  ILLEGAL SYMBOL "**". SOME SYMBOLS THAT MIGHT
         BE LEGAL ARE: <ERR_STMT> <WNG_STMT> GET SQL SAVEPOINT HOLD FREE
         ASSOCIATE CALL
DSNT418I SQLSTATE   = 42601 SQLSTATE RETURN CODE
DSNT415I SQLERRP    = DSNHLEX SQL PROCEDURE DETECTING ERROR
DSNT416I SQLERRD    = 17 0  0  -1  1  502 SQL DIAGNOSTIC INFORMATION
DSNT416I SQLERRD    = X'00000011'  X'00000000'  X'00000000'  X'FFFFFFFF'
         X'00000001'  X'000001F6' SQL DIAGNOSTIC INFORMATION
---------+
DSNE618I ROLLBACK PERFORMED, SQLCODE IS 0
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 0
---------+
DSNE601I SQL STATEMENTS ASSUMED TO BE BETWEEN COLUMNS 1 AND 72
DSNE620I NUMBER OF SQL STATEMENTS PROCESSED IS 5
DSNE621I NUMBER OF INPUT RECORDS READ IS 65
DSNE622I NUMBER OF OUTPUT RECORDS WRITTEN IS 127
---------+
---A10  ------------
---  VALORISATION DES ARTICLES ET DES DéCLINAISONS
---------+
   SELECT  (QTES  * PRXART) AS VALEUR, QTES, PRXART
     , A.IDART, LIBART ,IDDEC
      FROM TDECL D
       ,   TARTI A
    WHERE D.IDART = A.IDART
      ORDER BY 1, 2
      ;
---------+
      VALEUR   QTES     PRXART    IDART  LIBART                IDDEC
---------+
       10.40     2.       5.20       6.  CASQUETTE               72.
       26.00     5.       5.20       6.  CASQUETTE               70.
       41.40    12.       3.45       2.  T-SHIRT                 80.
       46.80     9.       5.20       6.  CASQUETTE               73.
       65.55    19.       3.45       2.  T-SHIRT                 84.
       83.20    16.       5.20       6.  CASQUETTE               71.
       86.25    25.       3.45       2.  T-SHIRT                 81.
      158.70    46.       3.45       2.  T-SHIRT                 83.
      179.40    52.       3.45       2.  T-SHIRT                 82.
      208.00    40.       5.20       6.  CASQUETTE               74.
      967.60     8.     120.95       1.  BASKETS                 93.
     2298.05    19.     120.95       1.  BASKETS                 91.
     4596.10    38.     120.95       1.  BASKETS                 92.
     8708.40    72.     120.95       1.  BASKETS                 90.
    11127.40    92.     120.95       1.  BASKETS                 94.
DSNE610I NUMBER OF ROWS DISPLAYED IS 15
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A10B ------------
---  AFFICHAGE DE L'ARTICLE LE PLUS VALORISE
-------------------
   SELECT        MAX(QTES  * PRXART) AS VALEUR
      FROM TDECL D
       ,   TARTI A
    WHERE D.IDART = A.IDART
      ;
---------+
      VALEUR
---------+
    11127.40
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
-------------------
---A10C ------------
---  AFFICHAGE DE LA DECLINAISON LA PLUS VALORISEE
-------------------
   SELECT A.IDART, IDDEC, LIBART, COLORIS
        , (QTES  * PRXART)
      FROM TDECL D
       ,   TARTI A
      WHERE  (QTES  * PRXART)  IN
      ( SELECT        MAX(QTES  * PRXART) AS VALEUR
           FROM TDECL D
            ,   TARTI A
         WHERE D.IDART = A.IDART
      )
      ;
---------+
  IDART  IDDEC  LIBART                COLORIS
---------+
     1.    94.  BASKETS               BLEU                      11127.40
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A10C ------------
---  AFFICHAGE DE LA VALORISATION DES ARTICLES
---  TOUTES DECLINAISONS CONFONDUES
-------------------
   SELECT  SUM((QTES  * PRXART)) AS VALEUR
     , A.IDART, LIBART
      FROM TDECL D
       ,   TARTI A
    WHERE D.IDART = A.IDART
    GROUP BY A.IDART, LIBART
      ORDER BY 1, 2
      ;
---------+
           VALEUR    IDART  LIBART
---------+
           374.40       6.  CASQUETTE
           531.30       2.  T-SHIRT
         27697.55       1.  BASKETS
DSNE610I NUMBER OF ROWS DISPLAYED IS 3
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
-------------------
