SELECT CUSTOMERS.CUSTOMERNAME,
       CUSTOMERS.STATE,
       ROUND(DETAILS.QUANTITYORDERED * DETAILS.PRICEEACH, 2) AS DOLLAR_AMOUNT_ORDERED
FROM `classic_motors.customers` AS CUSTOMERS
INNER JOIN `classic_motors.orders` AS ORDERS
ON CUSTOMERS.CUSTOMERNUMBER = ORDERS.CUSTOMERNUMBER
INNER JOIN `classic_motors.orderdetails` AS DETAILS
ON ORDERS.ORDERNUMBER = DETAILS.ORDERNUMBER
INNER JOIN `classic_motors.products` AS PRODUCTS
ON DETAILS.PRODUCTCODE = PRODUCTS.PRODUCTCODE
WHERE PRODUCTS.PRODUCTNAME = "1968 Ford Mustang" AND
      CUSTOMERS.CREDITLIMIT >= (
        SELECT AVG(CREDITLIMIT)
        FROM `classic_motors.customers`
      )