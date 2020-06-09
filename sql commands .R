library(RSQLite)
library(sqldf)
cars
my_sql_db=sqldf('select * from cars where speed<10')
my_sql_db
###################################################################################################
customer
cust_db=sqldf('select * from customer')
cust_db
#
cust_db=sqldf('select distinct CustomerName,City,Country
              from customer')
cust_db
#
cust_db=sqldf('select * from customer
              where Country="USA" ')
cust_db
#
cust_db=sqldf('select * from customer where Country="Germany" AND City="Berlin"')
cust_db
#
cust_db=sqldf('select*from customer where City="Berlin" OR City="Aachen"')
cust_db
#
cust_db=sqldf('select * from customer where NOT Country="Germany"')
cust_db
#
cust_db=sqldf('select * from customer ORDER BY CustomerName,Country')
cust_db
#
cust_db=sqldf('INSERT INTO customer (CustomerID,CustomerName,ContactName,Address,City,PostalCode,Country)
              VALUES ("92","VIKRAM","VIK","SAIBABA COLONY","COIMBATORE","641038","INDIA")')
cust_db
#
cust_db=sqldf('select CustomerName,City,Country
              from customer where City IS NULL ')
cust_db
#
cust_db=sqldf('select CustomerName,City,Country
              from customer Where City IS NOT NULL')
cust_db
#
cust_db=sqldf('UPDATE customer 
              SET ContactName="TOMMY"
              WHERE CustomerID="4"')
cust_db
#
cust_db=sqldf('select * FROM customer ORDER BY CustomerID DESC
              LIMIT 10 ')
cust_db
##################################################################################################
Products
prod_db=sqldf('select*from Products')
prod_db
#
prod_db=sqldf('select MIN(Price) AS SmallestPrice
              from Products')
prod_db
#
prod_db=sqldf('select MAX(Price) AS LargestPrice
              FROM Products')
prod_db
#
prod_db=sqldf('select SUM(Price) AS Total_Price
              FROM Products')
prod_db
#
cust_db=sqldf('select* from customer
              where CustomerName LIKE "s%"')
cust_db
#
cust_db=sqldf('select * from customer 
where City NOT LIKE "[bsp%]"')
cust_db
#





