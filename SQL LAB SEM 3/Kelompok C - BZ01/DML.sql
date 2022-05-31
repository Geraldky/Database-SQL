USE beEJibun
GO

-- Query 1
SELECT  itemName, itemPrice, SUM(purchaseQty) as [Item Total]
FROM MsItem it JOIN PurchaseDetails pd ON it.itemID = pd.itemID
JOIN Purchase p ON p.purchaseID = pd.purchaseID
WHERE arrivalDate is NULL
GROUP BY itemName, itemPrice
HAVING SUM(purchaseQty) > 100
ORDER BY [Item Total] DESC

-- Query 2
SELECT vendorName, SUBSTRING(vendorEmail, CHARINDEX('@',vendorEmail)+1, LEN(vendorEmail)) as [Domain Name], AVG(purchaseQty) as [Average Purchased Item]
FROM MsVendor mv JOIN purchase pc on pc.vendorID = mv.vendorID
JOIN PurchaseDetails pcd on pcd.purchaseID = pc.purchaseID
WHERE vendorAddress = 'Food Street' AND SUBSTRING(vendorEmail, CHARINDEX('@',vendorEmail)+1, LEN(vendorEmail)) NOT LIKE 'gmail.com'
GROUP BY vendorName, vendorEmail

-- Query 3
SELECT DISTINCT DATENAME(M, salesDate) as [Month], MIN(std.salesQty) as [Minimum Quantity Sold], MAX(std.salesQty) as [Maximum Quantity Sold]
FROM SalesTransaction st JOIN SalesTransactionDetails std ON st.salesID = std.salesID
JOIN MsItem as it ON it.itemID = std.itemID 
JOIN MsItemType itp ON it.itemTypeID = itp.itemTypeID
WHERE YEAR(salesDate) = '2019' AND itemTypeName not in ('Food', 'Drink')
GROUP BY DATENAME(M, salesDate)

-- Query 4
SELECT REPLACE(sf.staffID, 'ST', 'Staff ') as [Staff Number], staffName, CONCAT('Rp. ', staffSalary) as  [Salary], COUNT(st.salesID) as [Sales Count], AVG(salesQty) as [Average Sales Quantity]
FROM MsStaff sf JOIN SalesTransaction st ON st.staffID = sf.staffID
JOIN SalesTransactionDetails std ON std.salesID = st.salesID 
JOIN MsCustomer cs ON cs.customerID = st.customerID
WHERE ((cs.customerGender like 'Male' AND sf.staffGender like 'Female') OR (cs.customerGender like 'Female' AND sf.staffGender like 'Male')) AND (MONTH(st.salesDate) = 2)
GROUP BY sf.staffID, sf.staffName, sf.staffSalary

-- Query 5
SELECT (LEFT(customerName, 1) + RIGHT(customerName, 1)) as [Customer Initial], FORMAT(salesDate,'MM dd,yyyy') as [Transaction Date], salesQty as [Quantity]
from MsCustomer mc JOIN SalesTransaction st on mc.customerID = st.customerID
JOIN SalesTransactionDetails std on st.salesID = std.salesID,(
	select AVG (salesQty) as Quantity
	from SalesTransactionDetails
)x
WHERE customerGender = 'Female' and salesQty > x.Quantity

-- Query 6
SELECT LOWER(mv.vendorID) as VendorID, vendorName, STUFF(vendorPhone,1,1,'+62') as [Phone Number]
FROM MsVendor mv JOIN Purchase p on p.vendorID = mv.vendorID
JOIN PurchaseDetails pd on p.purchaseID = pd.purchaseID, (
	SELECT MIN(purchaseQty) as qty FROM PurchaseDetails pd
)minQty
WHERE (CAST(RIGHT(itemID,3) AS int)%2) <> 0 AND minQty.qty < pd.purchaseQty

-- Query 7
SELECT DISTINCT staffName as [StaffName] , vendorName as [VendorName], pd.purchaseID as [PurchaseID], SUM(purchaseQty) AS [Total Purchased Quantity], CONCAT(DATEDIFF(DAY,p.purchaseDate,GETDATE()),' Days ago')  as [Order Date]
FROM MsStaff ms JOIN Purchase p on ms.staffID = p.staffID
JOIN MsVendor mv on MV.vendorID = P.vendorID
JOIN PurchaseDetails pd on pd.purchaseID = p.purchaseID, (
	SELECT MAX(purchaseQty) as Maximum, SUM(purchaseQty) as Total FROM PurchaseDetails
) x
WHERE ((DATEDIFF(DAY,purchaseDate,arrivalDate)<7)) AND x.Total > x.Maximum
GROUP BY staffName, vendorName, pd.purchaseID, p.purchaseDate

--Query 8
SELECT TOP(2) DATENAME(WEEKDAY, st.salesDate) as [Day], COUNT(std.salesQty) as [Item Sales Amount]
FROM SalesTransaction st JOIN SalesTransactionDetails std ON st.salesID = std.salesID
JOIN MsItem it ON std.itemID = it.itemID
JOIN MsItemType itp ON itp.itemTypeID = it.itemTypeID, (
	Select AVG(itemPrice) as Average, itemTypeName from MsItem it JOIN MsItemType itp ON itp.itemTypeID = it.itemTypeID
	WHERE itemTypeName like 'Electronic' OR itemTypeName like 'Gadgets'
	GROUP BY itemTypeName
) x
WHERE it.itemPrice < x.Average
GROUP BY st.salesDate
ORDER BY COUNT(std.salesQty) ASC

-- Query 9
GO
CREATE VIEW [Customer Statistic by Gender]
AS
SELECT customerGender as [CustomerGender], MAX(salesQty) as [Maximum Sales], MIN(salesQty) as [Minimum Sales]
FROM MsCustomer mc JOIN SalesTransaction st on mc.customerID = st.customerID
JOIN SalesTransactionDetails std on st.salesID = std.salesID
WHERE (std.salesQty BETWEEN 10 AND 50) AND (YEAR(mc.customerDOB) BETWEEN  '1998' AND '1999')
GROUP BY mc.customerGender
GO

-- Query 10
GO
CREATE VIEW [Item Type Statistic]
AS
SELECT UPPER(itemTypeName) as [Item Type], AVG(itemPrice) as [Average Price], COUNT(itemID) as [Number of Item Variety]
FROM MsItem mi JOIN MsItemType mit on mi.itemTypeID = mit.itemTypeID
WHERE itemTypeName LIKE 'F%' AND itemMinQty > 5
GROUP BY mit.itemTypeName
GO


SELECT * from [Item Type Statistic], [Customer Statistic by Gender]
