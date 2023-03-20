SELECT FORMAT_DATE('%A', ORDER_DT) AS DAY_OF_WEEK,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS RANKING,
       COUNT(*) AS ORDERS
FROM `melodic-eye-381214.cis_4400_qvc.cis_4400_qvc`
GROUP BY DAY_OF_WEEK
ORDER BY RANKING
LIMIT 1000