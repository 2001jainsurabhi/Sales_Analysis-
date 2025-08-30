create database northwind;
use northwind;

-- 1. What is the average number of orders per customer? Are there high-value repeat customers?
with NoOfCustomer as (
 select CustomerID , count(*) as CustomerCount
 from orders 
 group by CustomerID
 )
 select CustomerID, avg(CustomerCount) from NoOfCustomer
 group by CustomerID
order by 2;

select o.CustomerID , c.CompanyName , 
count(o.orderID) as TotalOrders ,
sum(od.UnitPrice * od.Quantity * (1-od.Discount)) as TotalSpend
from orders o 
join `order details` od on o.OrderID = od.OrderID
join customers c on o.CustomerID = c.CustomerID
group by o.CustomerID , c.CompanyName
having TotalOrders > 1 
order by TotalSpend desc ;


-- 2. How do customer order patterns vary by city or country?
select c.Country , c.City,
count(o.OrderID) as TotalOrders,
sum(od.UnitPrice * od.Quantity * (1-od.Discount)) as TotalSpend
from orders o 
join `order details` od on o.OrderID = od.OrderID
join customers c on o.CustomerID = c.CustomerID
group by c.Country , c.City 
order by c.Country, TotalSpend desc;


-- 3. Can we cluster customers based on total spend, order count, and preferred categories?
SELECT o.CustomerID, c.CompanyName,
COUNT(o.OrderID) AS OrderCount,
SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSpend,
cat.CategoryName AS PreferredCategory
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
join `order details` od on o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY o.CustomerID, c.CompanyName, cat.CategoryName
ORDER BY TotalSpend DESC;


-- 4. Which product categories or products contribute most to order revenue?
-- By Category
SELECT cat.CategoryName,
SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue
FROM `Order Details` od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY Revenue DESC;

-- By Product
SELECT p.ProductName,
SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue
FROM `Order Details` od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Revenue DESC
LIMIT 10;


-- 5. Are there correlations between orders and customer location or product category?
SELECT c.Country, cat.CategoryName,
COUNT(o.OrderID) AS OrderCount,
SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN `Order Details` od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY c.Country, cat.CategoryName
ORDER BY c.Country, Revenue DESC;


-- 6. How frequently do different customer segments place orders?
select c.ContactTitle, 
count(o.OrderID) as TotalOrders,
ROUND(AVG(DATEDIFF(o.ShippedDate, o.OrderDate)), 1) AS AvgOrderGap
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.ContactTitle
ORDER BY TotalOrders DESC;


-- 7. What is the geographic and title-wise distribution of employees?
SELECT Country, Title,
COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Country, Title
ORDER BY EmployeeCount DESC;


-- 8. What trends can we observe in hire dates across employee titles?
SELECT Title, YEAR(HireDate) AS HireYear, COUNT(*) AS Hires
FROM Employees
GROUP BY Title, YEAR(HireDate)
ORDER BY HireYear;


-- 9. What patterns exist in employee title and courtesy title distributions?
SELECT TitleOfCourtesy, Title,
COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY TitleOfCourtesy, Title
ORDER BY EmployeeCount DESC;


-- 10. Are there correlations between product pricing, stock levels, and sales performance?
SELECT p.ProductName, p.UnitPrice, p.UnitsInStock,
SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Sales
FROM Products p
JOIN `Order Details` od ON p.ProductID = od.ProductID
GROUP BY p.ProductName, p.UnitPrice, p.UnitsInStock
ORDER BY p.ProductName, Sales DESC;


-- 11. How does product demand change over months or seasons?
-- months
SELECT YEAR(o.OrderDate) AS Year, MONTH(o.OrderDate) AS Month,
SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY Year, Month;

-- seasons
SELECT YEAR(o.OrderDate) AS Year, 
MONTH(o.OrderDate) AS Month,
CASE 
        WHEN MONTH(OrderDate) IN (12,1,2) THEN 'Winter'
        WHEN MONTH(OrderDate) IN (3,4,5) THEN 'Spring'
        WHEN MONTH(OrderDate) IN (6,7,8) THEN 'Summer'
        WHEN MONTH(OrderDate) IN (9,10,11) THEN 'Fall'
    END AS Season,
SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate), Season
ORDER BY Year, Month, Season;


-- 12. Can we identify anomalies in product sales or revenue performance?
SELECT p.ProductName,
YEAR(o.OrderDate) AS Year,
MONTH(o.OrderDate) AS Month,
SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS MonthlyRevenue
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName, YEAR(o.OrderDate), MONTH(o.OrderDate)
HAVING MonthlyRevenue < 0 OR MonthlyRevenue > 100000; -- threshold for anomaly


-- 13. Are there any regional trends in supplier distribution and pricing?
SELECT s.Country,
COUNT(DISTINCT s.SupplierID) AS SupplierCount,
AVG(p.UnitPrice) AS AvgPrice
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.Country
ORDER BY SupplierCount DESC;


-- 14. How are suppliers distributed across different product categories?
SELECT cat.CategoryName,
s.CompanyName AS Supplier,
COUNT(p.ProductID) AS SuppliedProducts
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY cat.CategoryName, s.CompanyName
ORDER BY SuppliedProducts DESC;


-- 15. How do supplier pricing and categories relate across different regions?
SELECT s.Country,
cat.CategoryName,
AVG(p.UnitPrice) AS AvgPrice,
COUNT(p.ProductID) AS ProductCount
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY s.Country, cat.CategoryName
ORDER BY AvgPrice DESC;

commit
















