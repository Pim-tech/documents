 WITH A(IDCOLL, D)  AS (
        SELECT
            X.IDCOLL
           ,0 AS D
        FROM
            ADCDA.TCOLLABO AS X
        WHERE
            X.IDSUP IS NULL
        UNION ALL
        SELECT
            X.IDCOLL
           ,(D + 1) AS D
        FROM
            ADCDA.TCOLLABO AS X, A
        WHERE
            X.IDSUP = A.IDCOLL
    )
    SELECT
        *
    FROM
        ADCDA.TCOLLABO AS X
        JOIN
        A
        ON X.IDCOLL = A.IDCOLL
    ORDER BY
        A.D ASC
    ;