SELECT DISTINCT * FROM supermarket.sales
ORDER by Order_Line ASC;

SELECT * FROM Customer;

SELECT * FROM Product;

#Get the list of all cities where the region is South or east without any duplicates using IN statement
SELECT DISTINCT City FROM Customer
WHERE Region IN ('South', 'East');

#Get the list of all orders where the ‘sales’ value is between 100 and 500 using the BETWEEN operator
SELECT Order_ID FROM Sales
WHERE Sales_$ BETWEEN 100 AND 500;

#Get the list of customers whose last name contains only 4 characters using LIKE
SELECT * FROM Customer
WHERE Customer_Name LIKE '% ____';

#Retrieve all orders where ‘discount’ value is greater than zero ordered in descending order basis ‘discount’ value
SELECT * FROM Sales
WHERE Discount > 0
ORDER BY Discount DESC
LIMIT 10;

#Find the sum of all ‘sales’ values
SELECT SUM(Sales_$) FROM Sales;

#Find count of the number of customers in north region with age between 20 and 30
SELECT COUNT(Customer_ID) FROM Customer
WHERE Region = 'North' AND (Age BETWEEN 20 AND 30);

#Find the average age of East region customers
SELECT AVG(Age) FROM Customer
WHERE Region = 'East';

#Find the Minimum and Maximum aged customer from Philadelphia
SELECT MIN(Age) AS Min_Age, Max(AGE) AS Max_Age FROM Customer
WHERE City = 'Philadelphia';

SELECT SUM(Sales_$) AS Total_Sales, SUM(Quantity) AS Total_Quantity,
COUNT(Order_ID) AS No_of_Orders, MAX(Sales_$) AS Max_Sales, MIN(Sales_$) AS Min_Sales,
AVG(Sales_$) AS AVG_Sales
FROM Sales
GROUP BY Product_ID
ORDER BY Total_Sales;

SELECT SUM(Sales_$) AS Total_Sales, SUM(Quantity) AS Total_Quantity,
COUNT(Order_ID) AS No_of_Orders, MAX(Sales_$) AS Max_Sales, MIN(Sales_$) AS Min_Sales,
AVG(Sales_$) AS AVG_Sales
FROM Sales
GROUP BY Product_ID
HAVING No_of_Orders > 10
ORDER BY Total_Sales DESC;

#Find the total sales done in every state for customer_20_60 and sales_2015 table
SELECT Customer.State, SUM(Sales.Sales_$)
FROM Sales
LEFT JOIN Customer
ON Customer.Customer_ID = Sales.Customer_ID
GROUP BY Customer.State;

#Get data containing Product_id , product name, category, total sales value of that product and total quantity sold
SELECT Product.Product_ID, Product.Product_Name, Product.Category, SUM(Sales.Sales_$), SUM(Sales.Quantity)
FROM Product
LEFT JOIN Sales
ON Product.Product_ID = Sales.Product_ID
GROUP BY Product.Product_ID;

#Get data with all columns of sales table, and customer name, customer age, product name and category are in the same result set
SELECT Customer.Customer_Name, Customer.Age, Sales_Product.*
FROM Customer
RIGHT JOIN (SELECT Sales.*, Product.Product_Name, Product.Category
FROM Sales
LEFT JOIN Product
ON Sales.Product_ID = Product.Product_ID) AS Sales_Product
ON Customer.Customer_ID = Sales_Product.Customer_ID;

#create view Daily_Billing as select order_line , product_id , sales, discount
#from sales where order_date in (select max( order_date ) from
CREATE VIEW Daily_Billing AS
SELECT Order_Line, Product_ID, Sales_$, Discount
FROM Sales
WHERE Order_Date IN (SELECT MAX(Order_Date));