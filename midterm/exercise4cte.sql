WITH SDAT AS
       (SELECT SHIP_TO_STATE AS STATE,
               SUM(TOTAL_LINE_AMT) AS SALES
        FROM `melodic-eye-381214.cis_4400_qvc.cis_4400_qvc`
        GROUP BY STATE)

SELECT STATE, SALES,
       ROUND(SALES / SUM(SALES) OVER () * 100, 2) AS PERCENT
FROM SDAT
ORDER BY STATE
LIMIT 1000