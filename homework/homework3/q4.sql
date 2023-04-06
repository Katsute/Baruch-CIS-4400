SELECT CUSTOMERS.COUNTRY,
       FORMAT_DATE("%Y-%m", ORDERS.SHIPPEDDATE) AS YEARMONTH,
       ROUND(SUM(DETAILS.QUANTITYORDERED * DETAILS.PRICEEACH), 2) AS SALES,
       RANK() OVER (ORDER BY (
         SUM(DETAILS.QUANTITYORDERED * DETAILS.PRICEEACH)
       ) DESC) AS RANKING
FROM `classic_motors.orders` AS ORDERS
INNER JOIN `classic_motors.orderdetails` AS DETAILS
ON ORDERS.ORDERNUMBER = DETAILS.ORDERNUMBER
INNER JOIN `classic_motors.customers` AS CUSTOMERS
ON ORDERS.CUSTOMERNUMBER = CUSTOMERS.CUSTOMERNUMBER
WHERE ORDERS.STATUS = "Shipped"
GROUP BY CUSTOMERS.COUNTRY, YEARMONTH
ORDER BY RANKING