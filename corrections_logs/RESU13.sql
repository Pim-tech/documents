---------+
---A1  COLORIS   ---
     SELECT   *

     FROM TDECL -----
    ORDER BY 1
      ;
---------+
  IDART  IDDEC  TAILLE  COLORIS                QTES   QTEA   QUOT
---------+
     1.    90.  38      NOIR                    72.    25.     5.
     1.    94.  44      BLEU                    92.    40.    10.
     1.    93.  42      NOIR                     8.    10.    20.
     1.    92.  40      BLANC                   38.    15.    10.
     1.    91.  38      BLEU                    19.    25.     5.
     2.    83.  XS      BLEU                    46.    10.     3.
     2.    82.  M       NOIR                    52.    27.    32.
     2.    81.  L       BLEU                    25.    25.     5.
     2.    80.  L       NOIR                    12.    25.    10.
     2.    84.  XL      VERT                    19.    20.    12.
     6.    70.  48      VERT                     5.     3.     5.
     6.    72.  48      KAKI                     2.     1.    10.
     6.    71.  48      BLEU                    16.    20.     3.
     6.    74.  52      BLEU                    40.    27.    18.
     6.    73.  50      NOIR                     9.    10.    20.
DSNE610I NUMBER OF ROWS DISPLAYED IS 15
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A2 COLORIS
     SELECT
         LENGTH(COLORIS)
     FROM TDECL
    ORDER BY 1
      ;
---------+

---------+
          4
          4
          4
          4
          4
          4
          4
          4
          4
          4
          4
          4
          4
          4
          5
DSNE610I NUMBER OF ROWS DISPLAYED IS 15
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A3 COLORIS
     SELECT
              MAX(LENGTH(COLORIS))
     FROM TDECL
      ;
---------+

---------+
          5
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A4 COLORIS
     SELECT
              MAX(LENGTH(COLORIS)) , COLORIS
     FROM TDECL
     GROUP BY COLORIS
      ;
---------+
             COLORIS
---------+
          5  BLANC
          4  BLEU
          4  KAKI
          4  NOIR
          4  VERT
DSNE610I NUMBER OF ROWS DISPLAYED IS 5
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A5 COLORIS
     SELECT   LENGTH(COLORIS) , IDART, IDDEC
     FROM TDECL
     WHERE LENGTH(COLORIS) IN
        (
        SELECT
                 MAX(LENGTH(COLORIS))
        FROM TDECL
        )
      ;
---------+
               IDART  IDDEC
---------+
          5       1.    92.
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A6 COLORIS
     SELECT   LENGTH(COLORIS)  AS  LONGUEUR
     ,  IDART, IDDEC, COLORIS
     FROM TDECL
     WHERE LENGTH(COLORIS) IN
        (
        SELECT
                 MAX(LENGTH(COLORIS))
        FROM TDECL
        )
        GROUP BY LENGTH(COLORIS),  IDART, IDDEC, COLORIS
      ;
---------+
   LONGUEUR    IDART  IDDEC  COLORIS
---------+
          5       1.    92.  BLANC
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
---A7 QTES
     SELECT  IDART, IDDEC, COLORIS  , QTES
     FROM TDECL
     WHERE QTES            IN
        (
        SELECT
                 MAX(QTES)
        FROM TDECL
        )
  --    GROUP BY  IDART, IDDEC, COLORIS, QTES
      ;
---------+
  IDART  IDDEC  COLORIS                QTES
---------+
     1.    94.  BLEU                    92.
DSNE610I NUMBER OF ROWS DISPLAYED IS 1
DSNE616I STATEMENT EXECUTION WAS SUCCESSFUL, SQLCODE IS 100
---------+
