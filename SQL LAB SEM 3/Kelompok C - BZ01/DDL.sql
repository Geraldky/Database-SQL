/*
2440013765	Geraldy Kumara
2440016760	Michael Pratama Budiman
2440013374	Sherly Phangestu
2440017706	Ronaldus Priambudi Sebleku
*/


CREATE DATABASE beEJibun
GO
USE beEJibun
GO

CREATE TABLE MsCustomer(
	customerID char(5) PRIMARY KEY check(customerID like 'CU[0-9][0-9][0-9]') not null,
	customerName varchar(255) not null,
	customerGender varchar(255) not null,
	customerPhone varchar(255) not null,
	customerDOB date not null,
	CONSTRAINT checkCustomerGender check(customerGender like 'Male' OR customerGender like 'Female'),
	CONSTRAINT checkCustomerDOB check(customerDOB BETWEEN '1990-01-01' AND getdate())
)

CREATE TABLE MsItemType(
	itemTypeID char(5) PRIMARY KEY check(itemTypeID like 'IP[0-9][0-9][0-9]') not null,
	itemTypeName varchar(255) not null,
	CONSTRAINT checkItemTypeName check(len(itemTypeName) >= 4)
)

CREATE TABLE MsItem(
	itemID char(5) PRIMARY KEY check(itemID like 'IT[0-9][0-9][0-9]') not null,
	itemTypeID char(5) REFERENCES MsItemType(itemTypeID) on update cascade on delete cascade not null,
	itemName varchar(255) not null,
	itemPrice int  not null,
	itemMinQty int not null,
	CONSTRAINT checkItemPrice check(itemPrice > 0)
)
 
 CREATE TABLE MsStaff(
	staffID char(5) PRIMARY KEY check(staffID like 'ST[0-9][0-9][0-9]') not null,
	staffName varchar(255) not null,
	staffGender varchar(255) not null,
	staffPhone varchar(255) not null,
	staffSalary int not null,
	CONSTRAINT checkStaffGender check(staffGender like 'Male' OR staffGender like 'Female'),
	CONSTRAINT checkStaffSalary check(staffSalary > 0) 
 )

 CREATE TABLE MsVendor(
	vendorID char(5) PRIMARY KEY check(vendorID like 'VE[0-9][0-9][0-9]') not null,
	vendorName varchar(255) not null,
	vendorPhone varchar(255) not null,
	vendorAddress varchar(255) not null,
	vendorEmail varchar(255) not null,
	CONSTRAINT checkVendorAddress check(vendorAddress like '% Street'),
	CONSTRAINT checkVendorEmail check(vendorEmail like '%@%.com' AND vendorEmail not like '@%' AND vendorEmail not like '%@.com%')
 )

 CREATE TABLE Purchase(
	purchaseID char(5) PRIMARY KEY check(purchaseID like 'PH[0-9][0-9][0-9]') not null,
	staffID char(5) REFERENCES MsStaff(staffID) on delete cascade on update cascade not null,
	vendorID char(5) REFERENCES MsVendor(vendorID) on delete cascade on update cascade not null,
	purchaseDate date not null,
	arrivalDate date
)

CREATE TABLE PurchaseDetails(
	purchaseID char(5) REFERENCES Purchase(purchaseID) on delete cascade on update cascade not null,
	itemID char(5) REFERENCES MsItem(itemID) on delete cascade on update cascade not null,
	purchaseQty int not null,
	CONSTRAINT checkPurchaseID check(purchaseID like 'PH[0-9][0-9][0-9]'),
	PRIMARY KEY(purchaseID, itemID)
)

CREATE TABLE SalesTransaction(
	salesID char(5) PRIMARY KEY check(salesID like 'SA[0-9][0-9][0-9]') not null,
	customerID char(5) REFERENCES MsCustomer(CustomerID) on delete cascade on update cascade not null,
	staffID char(5) REFERENCES MsStaff(staffID) on delete cascade on update cascade not null,
	salesDate date not null,
)

CREATE TABLE SalesTransactionDetails(
	salesID char(5) REFERENCES SalesTransaction(salesID)  on delete cascade on update cascade not null,
	itemID char(5) REFERENCES MsItem(itemID) on delete cascade on update cascade not null,
	salesQty int not null,
	CONSTRAINT checkSalesID check(salesID like 'SA[0-9][0-9][0-9]'),
	PRIMARY KEY(salesID, itemID)
)

