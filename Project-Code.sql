use master;
go
create database group4
USE group4
go

--Creating dbo.CustomerAccount table 
IF OBJECT_ID('dbo.Customer_Account', 'U') IS NULL
CREATE TABLE dbo.Customer_Account(
AccountID INT IDENTITY NOT NULL PRIMARY KEY ,
UserName varchar(40) NOT NULL,
HintQuestion varchar(255) NOT NULL,
Answer varchar(255) NOT NULL,
[Password] varchar(50) NOT NULL
);

--Creating dbo.Customer table 
IF OBJECT_ID('dbo.Customer','U') IS NULL
CREATE TABLE Dbo.Customer(
CustomerID INT IDENTITY NOT NULL PRIMARY KEY ,
AccountID INT NOT NULL REFERENCES Customer_Account(AccountID),
FirstName varchar(50) NOT NULL , LastName varchar(50) NOT NULL ,DOB date NOT NULL ,
ContactNumber BIGINT  NOT NULL , 
EmailId varchar(50) NOT NULL ,
Gender char(1) NOT NULL );


--Creating dbo.CreditCard table 
IF OBJECT_ID('dbo.CreditCard','U') IS NULL
CREATE TABLE dbo.CreditCard(
CreditCardNumber INT NOT NULL PRIMARY KEY, 
NameOnCard varchar(50)NOT NULL ,CardType varchar(15) NOT NULL ,
ExpiryDate date NOT NULL ,SecurityCode INT NOT NULL , BillingAddress varchar(60) NOT NULL );


--Creating dbo.Customer_CreditCard_Mapping table 
IF OBJECT_ID('dbo.Customer_CreditCard_Mapping','U') IS NULL
CREATE TABLE dbo.Customer_CreditCard_Mapping(
CustomerID INT NOT NULL REFERENCES Customer(CustomerID),
CreditCardNumber INT NOT NULL REFERENCES CreditCard(CreditCardNumber)
CONSTRAINT PKCustomer_CreditCard_Mapping PRIMARY KEY CLUSTERED(CustomerID, CreditCardNumber))


--Creating dbo.Supplier table 
IF OBJECT_ID('dbo.Supplier','U') IS NULL
CREATE TABLE dbo.Supplier(
SupplierID Int IDENTITY NOT NULL PRIMARY KEY, [Name] varchar (50) NOT NULL ,
ContactNo BIGINT NOT NULL , Email varchar(30));


--Creating dbo.Product_Promotion table 
IF OBJECT_ID('dbo.Product_Promotion','U') IS NULL
CREATE TABLE dbo.Product_Promotion(
PromotionID Int IDENTITY NOT NULL PRIMARY KEY,
DiscountPercent Decimal(5,2) NOT NULL ,
EndDate date NOT NULL,
StartDate date NOT NULL,);

--Creating dbo.Products table 
IF OBJECT_ID('dbo.Products','U') IS NULL
CREATE TABLE dbo.Products(
ProductID INT IDENTITY NOT NULL PRIMARY KEY,
SupplierID INT NOT NULL ,[Name] varchar(25) NOT NULL, 
CategoryName varchar(20),BrandName varchar (15), [Description]  varchar(255),
Rating decimal(3,2), Price money,Color varchar(10),Size  varchar(255) , [Weight] decimal(3,2),
Quantity INT NOT NULL) ;

--rating is out of 10 upto two decimal digit

ALTER TABLE dbo.Products
ADD FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID);

--Creating dbo.Product_Promotion_mapping
IF OBJECT_ID('dbo.Product_Promotion_Mapping','U') IS NULL
CREATE TABLE dbo.Product_Promotion_Mapping(
ProductID INT NOT NULL REFERENCES dbo.Products(ProductID),
PromotionID INT NOT NULL REFERENCES dbo.Product_Promotion(PromotionID)
CONSTRAINT PKProduct_Promotion_Mapping PRIMARY KEY CLUSTERED (ProductID,PromotionID));

--Creating dbo.Orders Table
IF OBJECT_ID('dbo.Orders','U') IS NULL
CREATE TABLE dbo.Orders(
OrderID INT NOT NULL PRIMARY KEY,
CustomerID INT NOT NULL,
AddressID varchar(15) NOT NULL,
PaymentID INT NOT NULL ,
ShipperID varchar(20) NOT NULL,
ShippingCost money NOT NULL,
TotalPrice money  NULL,TaxPercent decimal(5,2) NOT NULL,[Status] varchar(10) NOT NULL,
OrderDate Date NOT NULL, DeliveryDate Date NULL );

ALTER TABLE dbo.Orders
ADD FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
ALTER TABLE dbo.Orders
ADD FOREIGN KEY(AddressID) REFERENCES Shipping_Address(AddressID);
ALTER TABLE dbo.Orders
ADD FOREIGN KEY(ShipperID) REFERENCES Shippers(ShipperID);

--Creating Order_Product_Mapping Table
IF OBJECT_ID('dbo.Order_Product_Mapping', 'U')IS NULL
CREATE TABLE dbo.Order_Product_Mapping(
Quantity INT NOT NULL,
OrderID INT NOT NULL REFERENCES dbo.Orders(OrderID),
ProductID INT NOT NULL REFERENCES dbo.Products(ProductID)
CONSTRAINT PKOrder_Product_Mapping PRIMARY KEY CLUSTERED(OrderID, ProductID));

--Creating dbo.WishList Table
IF OBJECT_ID('dbo.WishList','U') IS NULL
CREATE TABLE dbo.WishList(
WishListID INT IDENTITY NOT NULL PRIMARY KEY,
CustomerID INT NOT NULL ,
[Name] varchar (20) NOT NULL , Date_Added date NOT NULL);

ALTER TABLE dbo.WishList
ADD FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID);


--Creating dbo.Product_WishList_Mapping table
IF OBJECT_ID('dbo.Product_WishList_Mapping', 'U') IS NULL 
CREATE TABLE dbo.Product_WishList_Mapping(
ProductID INT NOT NULL REFERENCES dbo.Products(ProductID),
WishListID INT NOT NULL REFERENCES dbo.WishList(WishListID)
CONSTRAINT PKProduct_WishList_Mapping PRIMARY KEY CLUSTERED (ProductID, WishListID));


-- Creating dbo.ShoppingCart Table
IF OBJECT_ID('dbo.ShoppingCart', 'U') IS NULL 
CREATE TABLE dbo.ShoppingCart(
ShoppingCartID INT  NOT NULL PRIMARY KEY,
CustomerID INT NOT NULL,
Subtotal Money );

ALTER TABLE dbo.ShoppingCart
ADD FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID);


-- Creating dbo.Product_ShoppingCart_Mapping Table
IF OBJECT_ID('dbo.Product_ShoppingCart_Mapping','U') IS NULL 
CREATE TABLE dbo.Product_ShoppingCart_Mapping(
Quantity INT NOT NULL ,
ProductID INT NOT NULL REFERENCES dbo.Products(ProductID),
ShoppingCartID INT  NOT NULL REFERENCES dbo.ShoppingCart(ShoppingCartID)
CONSTRAINT PKProduct_ShoppingCart_Mapping PRIMARY KEY CLUSTERED(ProductID, ShoppingCartID));

-- Creating dbo.Shippers Table
IF OBJECT_ID('dbo.Shippers','U') IS NULL
CREATE TABLE dbo.Shippers(
ShipperID varchar(20) NOT NULL PRIMARY KEY,
ShipperName varchar(20) NOT NULL, 
EmailId  varchar(30) NOT NULL , 
ContactNo INT NOT NULL);

-- Creating dbo.Shipping_Address Table
IF OBJECT_ID('dbo.Shipping_Address','U') IS NULL
CREATE TABLE dbo.Shipping_Address(
AddressID INT IDENTITY NOT NULL  PRIMARY KEY,
AddressLine_1 varchar(30)NOT NULL,
AddressLine_2 varchar(30)NULL,
City varchar(15) NOT NULL,
Zipcode INT NOT NULL);

--------------------------------------------------------------------------------------------------------------------
--populating data into tables using SQL INSERT scripts

--Entering data into dbo.Customer_Account Table
INSERT dbo.Customer_Account
VALUES
('Mark_P',	'In what town was your first job?',	'Seattle',	'Mark123'),
('Kevin_K',	'What was your childhood phone number?',	'9998881234',	'Kevin123'),
('Rachel_R',	'What is your dream car?',	'Honda Accord',	'Rachel123'),
('Walter_W',	'What is the name of your favorite relative not in the immediate family?',	'James',	'Walter123'),
('Eli_E',	'Where do you want to retire?',	'Seattle',	'Eli123'),
('Alfred_A',	'In what town was your first job?',	'Chicago',	'Alfred123'),
('Samuel_S',	'What was the name of the company where you had your first job?',	'Microsoft',	'Samuel123'),
('Jennie_J',	'What was the make and model of your first car?',	'Toyota Camry',	'Jennie123'),
('Richard_R',	'What was the make and model of your first car?',	'Nissan Altima',	'Richard123'),
('Charles_C',	'In what town was your first job?',	'Austin',	'Charles123');

--verifying/checking inserted values
SELECT * FROM dbo.Customer_Account;

--Filling data into dbo.customer table
INSERT dbo.Customer
VALUES
(	1,	'Mark',	'Webber',	'1990-02-18',	3608923151,	'mark.w@gmail.com',	'M' ),
(	2,	'Kevin',	'James',	'1970-03-31',	4258233433,	'kevin31@gmail.com',	'M' ),
(	3,	'Rachel',	'White',	'1986-01-29',	2391123465,	'rachel.white@gmail.com',	'F' ),
(	4,	'Walter',	'Smith',	'1962-06-12',	4629812657,	'smith_w1@outlook.com',	'M' ),
(	5,	'Eli',	'Jackson',	'1995-09-23',	7352789873,	'elijackson@yahoo.com',	'F' ),
(	6,	'Alfred',	'Romeo',	'1984-08-11',	2983054292,	'alfred0811@outlook.com',	'M' ),
(	7,	'Samuel',	'Jackson',	'1979-11-01',	7621349820,	'samjack@gmail.com',	'M' ),
(	8,	'Jennie',	'Thompson',	'1990-12-12',	8432609121,	'j.thompson@yahoo.com',	'F' ),
(	9,	'Richard',	'Clark',	'2000-12-04',	4628889101,	'rclark@gmail.com',	'M' ),
(	10,	'Charles',	'Smith',	'1965-05-26',	4901324321,	'charles.smith@gmail.com',	'M' );

--verifying/checking inserted values
SELECT * FROM dbo.Customer

--Filling data into dbo.CreditCard table
INSERT dbo.CreditCard
VALUES
(139212342,	'Mark Webber',	'VISA',	'2022-12-25',	1352,	'962 Lake Drive Rocklin, CA 95677'),
(155761453,	'Walter Smith',	'VISA',	'2024-02-10',	3332,	'7633 Kingston Street Neenah, WI 54956'),
(230444182,	'Linda James',	'MASTER CARD',	'2019-01-23',	2003,	'337 S. Lookout Lane Rockville, MD 20850'),
(342901386,	'Alfred Romeo',	'MASTER CARD',	'2025-01-21',	5217,	'16 Riverside St. Aiken, SC 29803'),
(353027686,	'Jennie Thompson',	'VISA',	'2019-06-12',	7201,	'7207 Edgewood St. Urbandale, IA 50322'),
(380905859,	'Richard Clark',	'VISA',	'2018-11-10',	4712,	'34 Lafayette Street Apt 4 Fort Lauderdale, FL 33308'),
(398209342,	'Rachel White',	'VISA',	'2019-08-14',	6219,	'612 Whitemarsh St. Quincy, MA 02169'),
(404029841,	'Eva Jackson',	'VISA',	'2023-11-13',	4623,	'23 2nd Lane Defiance, OH 43512'),
(416136998,	'Charles Smith',	'MASTER CARD',	'2024-06-18',	8132,	'26 Sheffield Dr. Vernon Hills, IL 60061'),
(808855418,	'Samuel Jackson',	'MASTER CARD',	'2021-03-21',	9421,	'361 Mulberry Lane Spartanburg, SC 29301');

--verifying/checking inserted values
SELECT * FROM dbo.CreditCard;

--Filling data into dbo.Customer_CreditCard_Mapping table

INSERT dbo.Customer_CreditCard_Mapping
VALUES
(3,139212342),
(4,155761453),
(5,398209342),
(6,155761453),
(6,416136998),
(7,404029841),
(7,808855418),
(8,342901386),
(9,808855418),
(9,404029841),
(9,139212342),
(10,353027686);

--verifying/checking inserted values
SELECT * FROM Customer_CreditCard_Mapping;

--Filling data into dbo.Supplier table
INSERT dbo.Supplier
VALUES
(	'Acme Corporation',	1416190368,	'sales@acmecorp.com'),
(	'Globex Corporation',	2890123222,	'marketing@globex.org'),
(	'Soylent Corp',	6662221111,	'enquires@soylent.org'),
(	'Initech',	8768768766,	'sales@initech.com'),
(	'Umbrella Corporation',	3546667897,	'enquires@umbcc.com'),
(	'Hooli', 	5668879876,	'marketing@hooli.org'),
(	'Vehement Capital Partners', 	9092220909,	'sales@vcp.com'),
(	'Massive Dynamic',	88809090202,	'sales@md.org'),
(	'Oscorp',	2223331111,	'sales@oscorp.com'),
(	'Nakatomi Trading Corp.',	7892439121,	'sales@ntc.org');

--verifying/checking inserted values
SELECT * FROM dbo.Supplier;

--Filling data into dbo.Products table
INSERT dbo.Products
VALUES
(1,	'Iphone 8', 'Mobiles', 'Apple', '256GB Silver', 3.96, 1000, 'Silver', '5.8 inch', 0.15,30 ),
(2,	'Iphone 7', 'Mobiles', 'Apple', '256GB Black', 4.24, 699, 'Black', '5 inch', 0.16,60),
(2,	'OnePlus5', 'Mobiles', 'OnePlus', '8GB RAM Black', 4.81, 700, 'Black', '5 inch', 0.15, 17),
(3,	'OnePlus5T', 'Mobiles', 'OnePlus', '6GB RAM Silver', 3.15, 722, 'Silver', '5 inch', 0.14,79),
(3,	'S8', 'Mobiles', 'Samsung', 'Samsung s8 256gb 6 gb ram', 0.00, 800, 'White', '5.5 inch', 0.17,34),
(4,	'S7', 'Mobiles', 'Samsung', 'Samsung s7 128gb 6 gb ram', 0.00, 710, 'Silver', '5 inch', 0.19,12),
(4,	'KD55X720E LED TV', 'TV', 'Sony', 'LED - 2160p - Smart - 4K Ultra HD TV', 3.50 ,699,'Black','55 inch',5.63,14),
(5,	'XBR-65X750D LED TV', 'TV', 'Sony', '2160p - Smart - 4K Ultra HD TV with High Dynamic Range', 3.65, 1400, 'Black', '64 inch', 3.69,15),
(5,	'UN65MU6290FXZA LED TV', 'TV', 'Samsung', '2160p - Smart - 4K Ultra HD TV', 2.90, 650, 'Black', '55 inch', 4.72,17),
(6,	'XBOX One', 'Gaming Console', 'XBOX', 'Xbox One S Assassins Creed Origins Bonus Bundle (1TB)', 4.20, 300, 'Silver', 'Large', 0.97,1),
(6,	'PlayStation 4', 'Gaming Console', 'Sony', 'PlayStation®4 1TB Console - Black', 4.50, 199, 'Black', 'Slim', 0.95,3),
(7,	'Nikon - D750 DSLR', 'Camera', 'Nikon', 'DSLR Camera with AF-S NIKKOR 24-120mm f/4G ED VR Lens', 4.90, 499, 'White','Camera Sensor Size - 13.8 mm',0.89,10),
(7,	'Canon - EOS 5D', 'Camera', 'Canon', 'EOS 5D Mark IV DSLR Camera', 4.10, 299, 'Blue', 'Camera Sensor Size - 11.4 mm', 1.25,11),
(8,	'Canon - EOS 6D', 'Camera', 'Canon', 'DSLR Camera with EF 24-105mm IS STM Lens', 4.00, 1999,'Black','Camera Sensor Size - 11.1 mm',2.31,18),
(8,	'Samsung ex100 washer', 'Washer', 'Samsung', '5.2 cu. ft. High-Efficiency Top Load Washer with Steam and Activewash',4.41,500,'White','Capacity - 160 litres',9.89,15),
(9,	'GE hhi9 washer', 'Washer', 'GE', '4.5 cu. ft. High-Efficiency Smart Top Load Washer',4.90,900,'Blue','Capacity - 240 litres',9.76,12),
(9,	'Acer Aspire E 15', 'Laptop', 'Acer', 'E5-575-33BM 15.6-Inch FHD Notebook', 4.61, 680, 'Black', 'Laptop Screen Size - 15 inch', 3.82,19 ),
(10, 'Dell Inspiron 13', 'Laptop', 'Dell', '3.3" Touch Display - 8th Gen Intel Core i5', 4.55, 900, 'Black', 'Laptop Screen Size - 13 inch', 3.09,20),
(10, 'ASUS Chromebook C202', 'Laptop', 'Asus', 'Intel Celeron 4 GB, 16GB eMMC', 4.01, 1200, 'White','Laptop Screen Size - 11 inch', 2.54,10),
(10, 'ASUS P-Series P33', 'Laptop', 'Asus', 'FHD Display, 8GB RAM, 1TB HDD, Windows 10',3.80, 1599, 'Black', 'Laptop Screen Size - 13 inch', 4.22,6);

--verifying/checking inserted values
SELECT * FROM dbo.Products;

--Filling data into dbo.Shippers table
INSERT INTO dbo.Shippers  
VALUES 
('55196d92', 'FedEx', 'shipping@fedex.com', 427984472),
('939a0296', 'USPS', 'shipping@usps.com', 435650046),
('c25dfdc2', 'Wser Company', 'enquiries@wccompany.com', 439336745),
('ddd55660', 'Packaging America', 'services@pca.com', 337347861),
('2b300610', 'DHL', 'services@dhl.com', 930257597),
('09d4c318', 'Euro Marine', 'customercare@eml.com', 309778736),
('d00276e0', 'Safmarine', 'customercare@safmarine.com', 779274753),
('21d554c8', 'Portline', 'customercare@portline.com', 452535478),
('1e71920e', 'Blue Dart', 'customercare@bluedart.com', 783532301),
('037409cf', 'V Shipping', 'customercare@vship.com', 790091849);

--verifying/checking inserted values
SELECT * FROM dbo.Shippers;

--Filling data into dbo.Shipping_Address table
INSERT INTO dbo.Shipping_Address
VALUES
('9625 10th St','156th Ave NE','Bellevue',98008),
('4520 45th St 148th Ave','Onyx Apartments','Redmond',98052),
('8573 Penn Ave.', 'Hillsborough', 'NewJersey', 08844),
('908 East Garden Street', 'Noblesville', 'Dayton' ,46060),
('169 North Ave', 'Mountain View', 'Seattle', 98901),
('7 Thatcher Dr', 'Springfield', 'Sacramento', 19064),
('3 E. Garfield Lane', 'Hollis', 'Dallas', 11423),
('156 Tailwater Dr.', 'Pleasanton Ave', 'Boston', 94566),
('22 Sulphur Springs Street', 'Bay City', 'Chicago', 48706),
('148 Chapel St.', 'Cranford', 'Denver', 07016),
('90 Hall Road','Fernandina Beach','LosAngeles', 34612),
('36 Cedar Street','Goshen', 'FortWayne', 46526),
('385 Pheasant Street', 'Gaithersburg', 'Columbus', 20877),
('41 East Tanglewood Ave.' ,'Arlington Heights', 'Arlington', 60004),
('205 Country St.', 'Minot', 'Charlotte', 58701),
('728 Gonzales Ave.' ,'Nazareth', 'Dallas',18064);

--verifying/checking inserted values
SELECT * FROM dbo.Shipping_Address;

--Filling data into dbo.Product_Promotion table
INSERT INTO dbo.Product_Promotion
VALUES
(10,'2017-12-01','2017-11-01'),
(5.09,'2017-12-31','2017-12-20 '),
(3,'2018-01-01','2017-12-29'),
(20,'2018-10-10','2018-10-01'),
(2.89,'2018-12-05','2017-12-01'),
(6,'2017-12-31','2017-10-01'),
(4.21,'2017-12-13','2017-12-12'),
(10,'2018-04-29','2018-03-15'),
(5.55,'2018-05-05','2017-05-05'),
(15,'2019-01-01','2018-12-31');

--verifying/checking inserted values
SELECT * FROM dbo.Product_Promotion;

--Filling data into dbo.Product_Promotion_Mapping table
INSERT INTO dbo.Product_Promotion_Mapping
VALUES
(18,1),
(18,4),
(19,3),
(19,4),
(5,4),
(6,10),
(9,7),
(4,9),
(7,9),
(3,5);

--verifying/checking inserted values
SELECT * FROM dbo.Product_Promotion_Mapping;

--Filling data into dbo.WishList table
INSERT INTO dbo.WishList
VALUES
(3,'MyWishlist','2017-11-20'),
(4,'MyList','2017-10-22'),
(5,'MyWishlist','2017-11-20'),
(6,'Walter list','2017-10-31'),
(7,' list of items','2017-01-11'),
(8,'list','2016-07-01'),
(9,' Wish list','2016-11-01'),
(10,'MyWishlist','2014-03-21');


--verifying/checking inserted values
SELECT * FROM dbo.WishList;

--Filling data into dbo.Product_WishList_Mapping table
INSERT INTO dbo.Product_WishList_Mapping
VALUES
(18,14),
(19,13),
(18,13),
(2,14),
(8,13),
(3,14),
(11,15),
(15,16),
(10,16),
(11,17),
(8,17),
(9,10),
(11,10);

--verifying/checking inserted values
SELECT * FROM Product_WishList_Mapping;

--Filling data into dbo.Orders table
Insert dbo.Orders
Values(1, 3, 1,1,'037409cf',10,null,10,'InProcess','12-01-2001','12-10-2001'),
(2,4,2,2,'09d4c318',10,null,10,'Delivered','12-01-2002','12-10-2002'),
(3,5,3,3,'1e71920e',10,null,10,'Shipped','12-01-2003','12-10-2003'),
(4,6,4,4,'21d554c8',10,null,10,'Delivered','12-01-2004','12-10-2004'),
(5,7,5,5,'2b300610',10,null,10,'Delivered','12-01-2005','12-10-2005'),
(6,8,6,6,'55196d92',10,null,10,'Delivered','12-01-2006','12-10-2006'),
(7,9,7,7,'939a0296',10,null,10,'Delivered','12-01-2007','12-10-2008'),
(8,10,8,8,'c25dfdc2',10,null,10,'Delivered','12-01-2009','12-10-2009'),
(9,11,9,9,'d00276e0',10,null,10,'Delivered','12-01-2010','12-10-2010'),
(10,12,10,10,'ddd55660',10,null,10,'Delivered','12-01-2011','12-10-2011');


--Creating Trigger to update Total price column of dbo.orders table for insert on dbo.Order_Product_mapping
--Here Total Price is calculated on by getting sum of price* quantity of Product added into order and adding tax percent 
---and shipping cost into it ,also if any discount rate is applicable to any product that discount percent of
--(sum of (price* quantity)) get subtracted which will give final Total price that gets stored in dbo.orders tables
--in Total Price column

Alter TRIGGER updateTotalPrice
  ON dbo.Order_Product_Mapping
  AFTER INSERT
AS
BEGIN
Declare @currentDate date
Set @currentDate= CAST(GETDATE() AS DATE)
Declare @variable decimal(5,2) 
Select @variable = (select isnull(sum(pm.DiscountPercent),0) from dbo.Product_Promotion_Mapping ppm inner join dbo.Product_Promotion pm on 
ppm.PromotionID=pm.PromotionID inner join dbo.Order_Product_Mapping p on p.ProductID=ppm.ProductID
Where pm.EndDate>=@currentDate  and pm.StartDate<=@currentDate )
  UPDATE o
  Set o.TotalPrice=
  (select sum(p.Price*m.Quantity)+((sum(p.Price*m.Quantity)*o.TaxPercent)/100)+o.ShippingCost-((sum(p.Price*m.Quantity)*@variable)/100)
from  dbo.Order_Product_Mapping m   inner join dbo.Products p on p.ProductID=m.ProductID 
inner join inserted i on i.OrderID=m.OrderID and i.ProductID=m.ProductID
group by m.OrderID)
from dbo.Orders o
inner join inserted i
on o.OrderID = i.OrderID
END

--Filling data into dbo.Order_Product_Mapping
Insert dbo.Order_Product_Mapping
Values(1,8,2)
Insert dbo.Order_Product_Mapping
Values(2,1,3)
Insert dbo.Order_Product_Mapping
Values (3,2,3)
Insert dbo.Order_Product_Mapping
Values(4,6,3)
Insert dbo.Order_Product_Mapping
Values(6,9,2)
Insert dbo.Order_Product_Mapping
Values(7,10,2)
Insert dbo.Order_Product_Mapping
Values(8,4,2)
Insert dbo.Order_Product_Mapping
Values(8,2,2)
Insert dbo.Order_Product_Mapping
Values(9,3,2)
Insert dbo.Order_Product_Mapping
Values(10,1,2)


--verifying/checking inserted values
SELECT * FROM dbo.Orders
SELECT * FROM dbo.Order_Product_Mapping


--Filling data into dbo.ShoppingCart table
INSERT INTO dbo.ShoppingCart
VALUES
(3,4,null),
(4,3,null),
(5,2,null),
(6,1,null),
(8,4,null),
(9,5,null),
(10,2,null),
(12,1,null);

--Creating Trigger to update subtotal column of dbo.ShoppingCart table for insert and update and delete on dbo.Product_ShoppingCart_Mapping
--Here SubTotal is calculated on by getting sum of price* quantity of Product added into Shopping cart 

---Insert Update Trigger

Create TRIGGER updateSubtotal
  ON dbo.Product_ShoppingCart_Mapping
AFTER INSERT, UPDATE
AS
BEGIN
UPDATE o
  Set o.Subtotal=
  (select sum(p.Price*m.Quantity)
from  dbo.Product_ShoppingCart_Mapping m   inner join dbo.Products p on p.ProductID=m.ProductID 
inner join inserted i on i.ShoppingCartID=m.ShoppingCartID 
group by m.ShoppingCartID)
from dbo.ShoppingCart o
inner join inserted i
on o.ShoppingCartID = i.ShoppingCartID
END

---Delete Trigger
Create TRIGGER updateSubtotalWhenProductisdeleted
  ON dbo.Product_ShoppingCart_Mapping
AFTER Delete
AS
BEGIN
UPDATE o
  Set o.Subtotal=
  (select sum(p.Price*m.Quantity)
from  dbo.Product_ShoppingCart_Mapping m   inner join dbo.Products p on p.ProductID=m.ProductID 
inner join deleted i on i.ShoppingCartID=m.ShoppingCartID 
group by m.ShoppingCartID)
from dbo.ShoppingCart o
inner join deleted i
on o.ShoppingCartID = i.ShoppingCartID
END


--Filling data into dbo.ShoppingCart table


INSERT INTO dbo.Product_ShoppingCart_Mapping
VALUES(25,4,12), (8,8,10)

--verifying/checking inserted values
SELECT * FROM dbo.ShoppingCart
SELECT * FROM dbo.Product_ShoppingCart_Mapping

---------------------------------------------------------------------------------------------------------
---Views


---OrderProductDetailsiew generate report consist of details of products information along with
-- promotion,supplier,and rating details added in  order 

CREATE VIEW OrderProductDetailsView
AS
SELECT DISTINCT opm.OrderID,p.ProductID,p.Name,p.CategoryName,p.BrandName,p.Color,p.Size,p.Price,p.Rating,p.SupplierID,sup.Name as [Product Supplier Name],sup.Email as SupplierEmail,sup.ContactNo as [Supplier Contact No]
FROM dbo. Order_Product_Mapping opm
INNER JOIN dbo.Products p
ON p.ProductID=opm.ProductID
Inner join dbo.Supplier sup on sup.SupplierID=p.SupplierID

SELECT *
FROM OrderProductDetailsView;


--- Product Sales reports shows the report of product sales based on total units sold of products with  
---complete product details (name,category..etc)

Create view ProductSalesReport
AS
select o.ProductID, p.Name, p.Size, p.BrandName, p.CategoryName,p.Price as UnitPrice, sum(o.quantity) as UnitsSold, sum(o.quantity)*p.Price as ProductSales
from dbo.Products p
inner join dbo.Order_Product_Mapping o
on p.ProductID = o.ProductID
group by o.ProductID, p.Name, p.Price, p.BrandName, p.CategoryName, p.Size

select * from dbo.ProductSalesReport

----------------------------------------------------------------------------------------------------------------------------
---Table-level CHECK Constraints

---Checking price is greater than zero
ALTER TABLE dbo.Products
ADD Constraint
CK_Product_Price
CHECK (Price > 0);

---Applying sceurity code check constraint
ALTER TABLE dbo.CreditCard
ADD Constraint 
CK_CreditCard_SecurityCode
CHECK (SecurityCode < 9999 and SecurityCode > 0001 );

--Computed Columns based on a function


 ---TotalSale Function
 --This Function retrives Total sale of requsted years and month 
CREATE FUNCTION TotalSale
(@beginyear int, @endyear int,@month int)
RETURNS money
AS BEGIN
Declare @totalSale money
SET @totalSale = ( select ISNULL(t.TotalSale,0) from (Select sum(s.TotalPrice)as TotalSale
From dbo.Orders as s
WHERE DATEPART(month, OrderDate)=@month and  DATEPART(year, OrderDate) Between @beginyear and @endyear) as t)
RETURN @totalSale;
END;
 
select dbo.TotalSale(2005,2006,12) as TotalSale;


---Column Data Encryption


CREATE MASTER KEY 
ENCRYPTION BY PASSWORD = 'PRAVALLIKA@neu2018';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE CertificateForGroup4
WITH SUBJECT = 'Customer Credit Card Number',
EXPIRY_DATE = '2022-10-31';
-- Create symmetric key to encrypt data
 CREATE SYMMETRIC KEY SymmetricKeyGroup4
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE CertificateForGroup4;

-- Open symmetric key
--OPEN SYMMETRIC KEY SymmetricKeyGroup4
--DECRYPTION BY CERTIFICATE CertificateForGroup4;

-- Create a column in which to store the encrypted data. 
USE group4 
ALTER TABLE dbo.Customer_CreditCard_Mapping
    ADD CreditCardNumber_Encrypted varbinary(128);
GO 

 -- Encrypting the newly created column
 -- Populating encrypted data into new column
USE "group4";
GO
-- Opens the symmetric key for use

OPEN SYMMETRIC KEY SymmetricKeyGroup4
DECRYPTION BY CERTIFICATE CertificateForGroup4;
GO
UPDATE dbo.Customer_CreditCard_Mapping
SET CreditCardNumber_Encrypted = EncryptByKey(Key_GUID('SymmetricKeyGroup4'), STR(CreditCardNumber) )
   
GO
--check the table , if column exist or not
SELECT *
FROM dbo.Customer_CreditCard_Mapping

-- Closes the symmetric key
CLOSE SYMMETRIC KEY SymmetricKeyGroup4
GO

--Reading the SQL Server Encrypted Data
USE group4;
GO
OPEN SYMMETRIC KEY SymmetricKeyGroup4
DECRYPTION BY CERTIFICATE CertificateForGroup4;
GO
-- Now list the original ID, the encrypted ID 
SELECT CustomerID, CONVERT(varchar, DecryptByKey(CreditCardNumber_Encrypted)) AS 'Decrypted Credit Card Number'
FROM dbo.Customer_CreditCard_Mapping;
 
 -- Close the symmetric key
CLOSE SYMMETRIC KEY SymmetricKeyGroup4;
GO

--drop the encrypted column 
ALTER TABLE dbo.Customer_CreditCard_Mapping
DROP COLUMN CreditCardNumber_Encrypted

-- Drop the symmetric key
DROP SYMMETRIC KEY SymmetricKeyGroup4;

-- Drop the certificate
DROP CERTIFICATE CertificateForGroup4;

--Drop the DMK
DROP MASTER KEY;



-----------------------------------------------------END------------------------------------------------------------------------