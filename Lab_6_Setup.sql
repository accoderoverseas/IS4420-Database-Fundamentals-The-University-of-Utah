
USE master;
GO
DROP DATABASE IF EXISTS Lab_6_StudentName;
GO
CREATE DATABASE Lab_6_StudentName;
GO
USE Lab_6_StudentName;
GO

-- Create the Customers table
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
( CustomerID		INT NOT NULL IDENTITY(1,1),
  FirstName			VARCHAR(25) NOT NULL,
  MiddleName		VARCHAR(25) DEFAULT NULL,
  LastName			VARCHAR(25) NOT NULL,
  PIN				CHAR(5) NOT NULL,
  StreetAddress		VARCHAR(35) NOT NULL,
  City				VARCHAR(25) NOT NULL,
  State				CHAR(2) NOT NULL,
  ZipCode			VARCHAR(10) NOT NULL,
  CONSTRAINT PK_Customers_CustomerID PRIMARY KEY ( CustomerID )
);

-- Add a column call EmailOptIn to the Customer table
ALTER TABLE Customers
ADD EmailOptIn CHAR(1) NOT NULL DEFAULT 'Y';

-- Add a CHECK constraint to the Customers table that makes sure the EmailOptIn column only allows the values of 'Y' or 'N'.
ALTER TABLE Customers
ADD CONSTRAINT CHECK_Customers_EmailOptIn CHECK ( EmailOptIn IN ( 'Y', 'N' ) );

INSERT INTO Customers ( FirstName, MiddleName, LastName, PIN, StreetAddress, City, State, ZipCode, EmailOptIn )
VALUES ( 'Edgar', 'Frank', 'Codd', '15638', '12309 Normalization Street', 'Los Angeles', 'CA', '90059', 'Y' ),
       ( 'Kim', NULL, 'Wexler', '96527', '666 Samoa Street', 'Albuquerque', 'NM', '87190', 'Y'  ),
       ( 'Ralph', NULL, 'Kimpball', '14628', '5368 Dimensional BLVD', 'Chicago', 'IL', '60659', 'Y'  ),
       ( 'Jane', 'Muriel', 'Anderson', '15387', '8519 Sego Lilly Lane', 'Devner', 'CO', '80266', 'N'  ),
       ( 'Jimmy', NULL, 'McGill', '46937', '666 Samoa Street', 'Albuquerque', 'NM', '87190', 'Y'  ),
       ( 'Sally', 'Marie', 'Johnson', '75392', '562 Ashton Street', 'Seattle', 'WA', '98178', 'Y'  ),
       ( 'Walter', 'Hartwell', 'White', '35842', '9674 Chemistry Lane', 'Albuquerque', 'NM', '87106', 'Y'  ),
       ( 'Nicole', NULL, 'McDonald', '19674', '2389 Sunflower Drive', 'Orlando', 'FL', '32827', 'Y'  ),
       ( 'Gustavo', NULL, 'Fring', '13458', '489 Affluence Road', 'Albuquerque', 'NM', '87121', 'Y'  ),
       ( 'Elaine', 'Benes', 'Odonnel', '46238', '2839 Park Street', 'New York', 'NY', '10075', 'N'  );


-- Create the CustomerEmails table
DROP TABLE IF EXISTS CustomerEmails;
CREATE TABLE CustomerEmails
( CustomerID			INT NOT NULL,
  EmailAddress			VARCHAR(254) NOT NULL,
  PrimaryEmailFlag		CHAR(1) NOT NULL DEFAULT 'Y',
  CONSTRAINT PK_CustomerEmails_CustomerID_EmailAddress PRIMARY KEY ( CustomerID, EmailAddress ),
  CONSTRAINT FK_CustomerEmails_CustomerID FOREIGN KEY ( CustomerID ) REFERENCES Customers ( CustomerID ),
  CONSTRAINT CHECK_CustomerEmails_PrimaryEmailFlag CHECK ( PrimaryEmailFlag IN ( 'Y', 'N' ) )
);

INSERT INTO CustomerEmails ( CustomerID, EmailAddress, PrimaryEmailFlag )
VALUES ( 1, 'efcodd@gmail.com', 'Y' ),
       ( 1, 'tedcodd@dbbguys.com', 'N' ),
       ( 2, 'kdrexler@yahoo.com', 'Y' ),
       ( 3, 'rkimball@hotmail.com', 'Y' ),
       ( 5, 'jmcgill@gmail.com', 'Y' ),
       ( 5, 'sgoodman@burnerphones.com', 'N' ),
       ( 6, 'smcfields@yahoo.com', 'Y' ),
       ( 7, 'whwhite@hotmail.com', 'Y' ),
       ( 7, 'whwhite@heisenburg.com', 'N' ),
       ( 8, 'nmcdomald@bing.com', 'Y' ),
       ( 9, 'gusfring@mindyourbusiness.com', 'Y' ),
       ( 10, 'ebenes@bing.com', 'Y' );
       

-- Create the Employees table
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees
( EmployeeID			SMALLINT NOT NULL IDENTITY(1,1), -- Surrogate Primary Key
  SSN					CHAR(11) NOT NULL,
  FirstName				VARCHAR(30) NOT NULL,
  MiddleName			VARCHAR(30) DEFAULT NULL,
  LastName				VARCHAR(30) NOT NULL,
  StreetAddress			VARCHAR(35) NOT NULL,
  City					VARCHAR(30) NOT NULL,
  [State]				CHAR(2) NOT NULL,
  ZipCode				VARCHAR(10) NOT NULL,
  Title					VARCHAR(25) NOT NULL,
  Salary				DECIMAL(8,2) NOT NULL,
  CONSTRAINT PK_Employees_EmployeeID PRIMARY KEY ( EmployeeID )
);

INSERT INTO Employees ( SSN, FirstName, MiddleName, LastName, StreetAddress, City, State, ZipCode, Title, Salary )
VALUES ( '123-45-6781', 'Bob', 'William', 'Christensen', '4452 Maple Drive', 'Dallas', 'TX', '46283', 'Chief Financial Officer', 135000 ),
       ( '123-45-6782', 'Janie', NULL, 'McMillan', '129 Cedar Hills Road', 'Eugene', 'OR', '89347', 'Founder & CEO', 150000 ),
       ( '123-45-6783', 'Edgar', 'Frank', 'Codd', '12309 Normalization Street', 'Los Angeles', 'CA', '90059', 'Chief Information Officer', 125000 ),
       ( '123-45-6784', 'Mike', 'Lee', 'Anderson', '89 Canyon Hill BLVD', 'Seattle', 'WA', '95731', 'Operations Manager', 115000 ),
       ( '123-45-6785', 'Madhavi', 'Jane', 'Pandey', '763 Butterfly Way', 'Albuquerque', 'NM', '79624', 'Senior Developer', 90000 ),
       ( '123-45-6786', 'Devesh', NULL, 'Singh', '582 Buffalo Grass Lane', 'Miami', 'FL', '13876', 'Project Manager', 75000 ),
       ( '123-45-6787', 'Ralph', NULL, 'Kimpball', '5368 Dimensional BLVD', 'Chicago', 'IL', '60659', 'VP of Data & Analytics', 115000 ),
       ( '123-45-6788', 'Lisa', 'Marie', 'Bartholomew', '369 Red Rock BLVD', 'Salt Lake City', 'UT', '84069', 'Database Administrator', 85000 ),
       ( '123-45-6789', 'Bryan', 'David', 'Larson', '3248 Cactus Road', 'Gilbert', 'AZ', '87121', 'Systems Administrator', 85000 ),
       ( '123-45-6799', 'Abigail', NULL, 'Williams', '429 Quakie Aspen Lane', 'Durango', 'CO', '81397', 'Office Manager', 75000 ),
       ( '123-45-6798', 'Kim', NULL, 'Drexler', '666 Samoa Street', 'Albuquerque', 'NM', '87190', 'General Council', 115000 ),
       ( '123-45-6797', 'Ronny', NULL, 'JJones', '528 Mountain Hill Drive', 'Glenwood Springs', 'CO', '81528', 'Jr. Web Developer', 45000 ),
       ( '123-45-6796', 'Abigail', NULL, 'Williams', '2674 River Road', 'Golden', 'CO', '82574', 'Jr. QA Tester', 40000 );


-- Create the Dependents table
DROP TABLE IF EXISTS Dependents;
CREATE TABLE Dependents
( EmployeeID		SMALLINT  NOT NULL,
  DependentNumber	TINYINT  NOT NULL,
  FirstName			VARCHAR(25) NOT NULL,
  LastName			VARCHAR(25) NOT NULL,
  BirthDate			DATE NOT NULL,
  SSN				CHAR(11) NOT NULL,
  CONSTRAINT PK_Dependents_EmployeeID_DependentNumber PRIMARY KEY ( EmployeeID, DependentNumber ),
  CONSTRAINT FK_Dependents_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID )
);

INSERT INTO Dependents
VALUES (1,1,'Ellis','Christensen','2005-03-07','123-45-6789'),
       (1,2,'Bethany','Christensen','2003-10-28','123-45-6789'),
       (1,3,'Kyla','Christensen','2003-07-16','123-45-6789'),
       (1,4,'Harmony','Christensen','2006-03-05','123-45-6789'),
       (2,1,'Andrew','McMillan','2005-03-26','123-45-6789'),
       (2,2,'Gloria','McMillan','2007-08-07','123-45-6789'),
       (4,1,'Kira','Anderson','2007-04-10','123-45-6789'),
       (4,2,'Edwin','Anderson','2013-07-08','123-45-6789'),
       (4,3,'Paige','Anderson','2000-10-09','123-45-6789'),
       (5,1,'Milo','Pandey','2008-03-25','123-45-6789'),
       (5,2,'Antonio','Pandey','2008-10-29','123-45-6789'),
       (5,3,'Jodie','Pandey','2004-05-29','123-45-6789'),
       (6,1,'Simon','Singh','2010-07-07','123-45-6789'),
       (6,2,'Tamara','Singh','2009-04-28','123-45-6789'),
       (7,1,'Matthew','Kimpball','2000-01-16','123-45-6789'),
       (8,1,'Miles','Bartholomew','2002-03-07','123-45-6789'),
       (8,2,'Hasan','Bartholomew','2010-09-27','123-45-6789'),
       (8,3,'Hollie','Bartholomew','2002-02-22','123-45-6789'),
       (9,1,'Chester','Larson','2008-06-10','123-45-6789'),
       (9,2,'Barbara','Larson','2005-10-06','123-45-6789'),
       (10,1,'Brandon','Williams','2003-06-17','123-45-6789'),
       (10,2,'Megan','Williams','2014-12-12','123-45-6789'),
       (11,1,'Taylor','Drexler','2004-05-11','123-45-6789'),
       (11,2,'Marie','Drexler','2006-11-24','123-45-6789'),
       (13,1,'Dewey','Williams','2006-05-20','123-45-6789'),
       (13,2,'Declan','Williams','2011-03-09','123-45-6789'),
       (13,3,'Seth','Williams','2006-10-03','123-45-6789'),
       (13,4,'Agnes','Williams','2000-03-09','123-45-6789'),
       (13,5,'Chloe','Williams','2010-08-09','123-45-6789'),
       (13,6,'Melody','Williams','2007-06-16','123-45-6789');


-- Create the Statuses table
DROP TABLE IF EXISTS Statuses;
CREATE TABLE Statuses
( StatusID				TINYINT NOT NULL IDENTITY(1,1), -- Surrogate Primary Key
  StatusName			VARCHAR(25) NOT NULL,
  StatusDescription		VARCHAR(100) NOT NULL,
  CONSTRAINT PK_Statuses_StatusID PRIMARY KEY ( StatusID )
);

INSERT INTO Statuses ( StatusName, StatusDescription )
VALUES ( 'Placed', 'Order has been placed by customer' ),
       ( 'Staged', 'Order has been staged by an order fulfillment clerk' ),
       ( 'Shipped', 'Order has been loaded on a courier' ),
       ( 'Delivered', 'Order has been delivered to the customer' ),
       ( 'Complete', 'Customer has confirmed receipt of order delivery & are satisfied' ),
       ( 'Cancelled', 'Order has been cancelled by customer' ),
       ( 'Returned', 'Order has been returned by the customer' );


-- Create the Orders table
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
( OrderID				INT NOT NULL IDENTITY(1,1), -- Surrogate Primary Key
  EmployeeID			SMALLINT NOT NULL,
  CustomerID			INT NOT NULL,
  OrderDate				DATE NOT NULL,
  OrderTime				TIME NOT NULL,
  CONSTRAINT PK_Orders_OrderID PRIMARY KEY ( OrderID ),
  CONSTRAINT FK_Orders_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID ),
  CONSTRAINT FK_Orders_CustomerID FOREIGN KEY ( CustomerID ) REFERENCES Customers ( CustomerID )
);

INSERT INTO Orders ( CustomerID, EmployeeID, OrderDate, OrderTime )
VALUES ( 1, 10, '2020-02-01', '08:22:52' ),
       ( 9, 4, '2019-11-22', '13:23:56' ),
       ( 8, 6, '2020-02-03', '23:17:59' ),
       ( 2, 2, '2020-02-06', '16:06:25' ),
       ( 3, 10, '2020-02-08', '20:13:47' ),
       ( 8, 6, '2019-09-19', '05:45:38' ),
       ( 5, 4, '2020-02-11', '06:16:38' ),
       ( 5, 10, '2020-02-12', '09:28:17' ),
       ( 2, 6, '2019-12-06', '16:06:25' ),
       ( 6, 10, '2020-02-14', '21:51:52' ),
       ( 6, 4, '2020-02-15', '18:36:47' ),
       ( 1, 2, '2019-10-28', '17:42:57' ),
       ( 7, 10, '2020-02-17', '17:08:19' ),
       ( 8, 4, '2020-02-19', '05:45:38' ),
       ( 9, 6, '2020-02-22', '13:23:56' ),
       ( 2, 2, '2020-02-25', '15:19:42' ),
       ( 5, 4, '2020-02-27', '10:36:24' ),
       ( 5, 10, '2019-11-12', '09:28:17' ),
       ( 1, 4, '2020-02-28', '17:42:57' ),
       ( 6, 10, '2020-02-29', '02:09:26' );



-- Create the OrderStatuses table
DROP TABLE IF EXISTS OrderStatuses;
CREATE TABLE OrderStatuses
( OrderID				INT NOT NULL,
  StatusID				TINYINT NOT NULL,
  StatusDate			DATE NOT NULL,
  StatusTime			TIME NOT NULL,
  CONSTRAINT PK_OrderStatuses_OrderID_StatusID PRIMARY KEY ( OrderID, StatusID ),
  CONSTRAINT FK_OrderStatuses_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
  CONSTRAINT FK_OrderStatuses_StatusID FOREIGN KEY ( StatusID ) REFERENCES Statuses ( StatusID )
);

INSERT INTO OrderStatuses
VALUES (1,1,'2020-01-04','16:41:00'),
       (1,2,'2020-01-08','18:36:00'),
       (1,3,'2020-01-17','10:38:00'),
       (1,4,'2020-01-23','22:15:00'),
       (2,1,'2020-01-02','09:18:00'),
       (2,2,'2020-01-09','04:13:00'),
       (2,3,'2020-01-15','21:09:00'),
       (2,4,'2020-01-22','16:29:00'),
       (3,1,'2020-01-06','02:38:00'),
       (3,2,'2020-01-12','12:12:00'),
       (3,3,'2020-01-19','13:15:00'),
       (3,4,'2020-01-30','21:01:00'),
       (4,1,'2020-01-08','22:24:00'),
       (4,2,'2020-01-13','11:30:00'),
       (4,3,'2020-01-20','18:13:00'),
       (4,4,'2020-01-22','01:06:00'),
       (4,5,'2020-02-02','14:19:00'),
       (5,1,'2020-01-05','05:29:00'),
       (5,2,'2020-01-10','16:34:00'),
       (5,3,'2020-01-18','17:30:00'),
       (5,4,'2020-01-26','14:09:00'),
       (6,1,'2020-01-08','02:39:00'),
       (6,2,'2020-01-08','19:30:00'),
       (6,3,'2020-01-20','16:18:00'),
       (6,4,'2020-01-22','00:45:00'),
       (7,1,'2020-01-02','05:49:00'),
       (7,2,'2020-01-12','11:08:00'),
       (7,3,'2020-01-21','18:17:00'),
       (7,4,'2020-01-29','20:59:00'),
       (7,5,'2020-02-04','07:39:00'),
       (7,6,'2020-02-14','06:57:00'),
       (8,1,'2020-01-06','14:36:00'),
       (8,2,'2020-01-12','14:37:00'),
       (8,3,'2020-01-19','10:45:00'),
       (8,4,'2020-01-31','23:05:00'),
       (8,6,'2020-02-11','21:16:00'),
       (9,1,'2020-01-06','10:51:00'),
       (9,2,'2020-01-13','21:23:00'),
       (9,3,'2020-01-20','21:08:00'),
       (9,7,'2020-02-14','14:18:00'),
       (10,1,'2020-01-03','13:40:00'),
       (10,2,'2020-01-13','16:02:00'),
       (10,3,'2020-01-19','18:17:00'),
       (11,1,'2020-01-08','17:40:00'),
       (11,2,'2020-01-11','16:09:00'),
       (11,3,'2020-01-18','17:58:00'),
       (11,5,'2020-02-06','07:00:00'),
       (12,1,'2020-01-06','00:18:00'),
       (12,2,'2020-01-09','07:46:00'),
       (12,3,'2020-01-15','15:20:00'),
       (13,1,'2020-01-05','08:02:00'),
       (13,2,'2020-01-09','13:45:00'),
       (13,5,'2020-02-05','08:29:00'),
       (14,1,'2020-01-04','23:42:00'),
       (14,2,'2020-01-11','18:25:00'),
       (15,1,'2020-01-03','03:48:00'),
       (15,2,'2020-01-10','06:08:00'),
       (16,1,'2020-01-06','00:05:00'),
       (16,2,'2020-01-08','16:12:00'),
       (17,1,'2020-01-04','17:44:00'),
       (18,1,'2020-01-02','23:56:00'),
       (18,7,'2020-02-13','09:48:00'),
       (19,1,'2020-01-04','22:18:00'),
       (19,5,'2020-02-04','08:43:00'),
       (20,1,'2020-01-08','20:46:00');


-- Creat the Products table
DROP TABLE IF EXISTS Products;
CREATE TABLE Products
( ProductID				SMALLINT  NOT NULL IDENTITY(1,1),
  ProductName			VARCHAR(50) NOT NULL,
  ProductDescription	VARCHAR(250) NOT NULL,
  SalesPrice			DECIMAL(7,2)  NOT NULL,
  InventoryOnHand		SMALLINT  NOT NULL,
  CONSTRAINT PK_Products_ProductID PRIMARY KEY ( ProductID )
);

INSERT INTO Products ( ProductName, ProductDescription, SalesPrice, InventoryOnHand )
VALUES ('Trekking Poles','Black/Silver Large Trekking Poles',99.95,23),
       ('2018 Specialized Stumpjumper','Black 2010 Specialized Stumpjumper, 29\" wheels, full suspension',1250,8),
       ('2014 Toyota 4-Runner','2014 Silver Toyota 4-Runner',14999,3),
       ('TomTom GPS Watch','Black TomTom GPS Exercise Watch, hold 2GB Music',129.99,47),
       ('Nike Vomero Running Shoes','Blue/Orange Nike Vomero Running Shoes',79.99,36),
       ('Kelty Backpack','Purple/Yellow High Capacity Kelty Backpack',195.95,16),
       ('Kelty Tent','4-Person 3-season Kelty Backpackgin Tent',249.95,10),
       ('Bear Canister','Black Cyninder Style Backpacking Bear Canister',45.99,22),
       ('Bear Repellant','8 Ounce Backcountry Bear Repellant',45.00,18),
       ('SPOT GPS Unit','SPOT GPS Backcountry Beacon, pings every 10 minutes',249.89,14);


-- Create the OrderLines table
DROP TABLE IF EXISTS OrderLines;
CREATE TABLE OrderLines
( OrderID				INT  NOT NULL,
  ProductID				SMALLINT  NOT NULL,
  Price					DECIMAL(7,2)  NOT NULL,
  Quantity				SMALLINT  NOT NULL,
  CONSTRAINT PK_OrderLines_OrderID_ProductID PRIMARY KEY ( OrderID, ProductID ),
  CONSTRAINT FK_OrderLines_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
  CONSTRAINT FK_OrderLines_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID )
);

INSERT INTO OrderLines
VALUES (1,1,101.78,12), (1,3,27.81,3), (1,4,20.62,9),(1,9,8.69,12),(1,10,45.18,9),
       (2,3,25.17,14),(2,4,20.62,4),(2,6,86.31,15),(2,7,47.14,3),(3,2,29.94,11),
       (3,4,18.66,14),(3,6,78.09,10),(3,7,47.14,11),(3,9,9.61,8),(3,10,49.94,7),
       (4,2,29.94,9),(4,10,45.18,12),(5,1,101.78,5),(5,3,25.17,5),(5,4,18.66,15),
       (5,6,86.31,9),(5,9,9.61,1),(6,2,29.94,11),(6,5,32.95,9),(6,6,78.09,5),
       (6,7,47.14,7),(6,8,2.78,6),(6,9,9.61,10),(7,3,25.17,7),(7,4,18.66,6),
       (7,8,2.78,6),(7,10,45.18,6),(8,1,101.78,12),(8,2,33.10,9),(8,4,20.62,8),
       (8,6,78.09,12),(8,7,52.10,11),(9,1,92.08,15),(9,2,29.94,1),(9,6,78.09,3),
       (9,7,52.10,15),(10,2,33.10,13),(10,3,27.81,9),(10,5,36.41,12),(10,6,78.09,12),
       (10,8,2.78,6),(10,10,45.18,3),(11,7,52.10,3),(11,9,9.61,11),(12,5,36.41,12),
       (12,9,8.69,7),(13,3,27.81,12),(13,5,36.41,3),(13,7,52.10,8),(13,9,8.69,1),
       (13,10,45.18,4),(14,3,27.81,6),(14,5,32.95,3),(14,7,52.10,7),(14,9,8.69,1),
       (15,4,20.62,12),(15,5,32.95,7),(15,6,86.31,12),(16,2,29.94,11),(16,7,52.10,1),
       (16,10,45.18,9),(17,4,18.66,3),(18,1,92.08,1),(18,5,36.41,8),(18,8,2.78,12),
       (18,9,8.69,3),(18,10,45.18,4),(19,1,101.78,13),(19,3,27.81,12),(19,5,32.95,9),
       (19,9,9.61,15),(19,10,45.18,15),(20,4,20.62,13),(20,5,36.41,15),(20,8,3.08,4);


-- Create the Vendors table
DROP TABLE IF EXISTS Vendors;
CREATE TABLE Vendors
( VendorID				SMALLINT  NOT NULL IDENTITY(1,1),
  VendorName			VARCHAR(25) NOT NULL,
  VendorDescription		VARCHAR(100) NOT NULL,
  CONSTRAINT PK_Vendors_VendorID PRIMARY KEY ( VendorID )
);

INSERT INTO Vendors ( VendorName, VendorDescription )
VALUES ( 'Jimmy''s Backcountry Gear', 'Cool guy who lives in a van down by the river in Oregon.' ),
       ( 'Totally Awesome Cyclery', 'They sell bikes & other stuff too, they might have ADD.' ),
       ( 'Moab Aventures', 'Moab adventure shop who sell everything you might want to do in Moab.' ),
       ( 'Funky Fruita Gearheads', 'Hipster Fruita reseller who seems to be able to get their hands on anything' ),
       ( 'Park City Snobs', 'Distributor located in Park City who sells ski & mountaineering gear' );
       

-- Create the ProductVendors table
DROP TABLE IF EXISTS ProductVendors;
CREATE TABLE ProductVendors
( ProductID				SMALLINT  NOT NULL,
  VendorID				SMALLINT  NOT NULL,
  UnitCost				DECIMAL(7,2) NOT NULL,
  CONSTRAINT PK_ProductVendors_ProductID_VendorID PRIMARY KEY ( ProductID, VendorID ),
  CONSTRAINT FK_ProductVendors_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID ),
  CONSTRAINT FK_ProductVendors_VendorID FOREIGN KEY ( VendorID ) REFERENCES Vendors ( VendorID )
);

INSERT INTO ProductVendors
VALUES (1,1,212.36),(1,2,478.33),(1,4,337.83),(1,5,425.45),(2,1,113.75),
       (2,2,292.41),(2,3,120.81),(2,5,271.69),(3,1,177.96),(3,2,74.72),
       (3,5,353.68),(4,2,162.15),(4,3,276.84),(5,2,14.03),(5,3,276.99),
       (5,4,342.87),(6,1,388.20),(6,2,290.91),(6,3,289.94),(6,5,15.02),
       (7,1,344.22),(7,3,347.44),(8,1,389.80),(8,2,438.62),(8,3,23.72),
       (9,1,304.37),(10,1,219.64),(10,2,490.49),(10,4,496.21),(10,5,100.43);


-- Create the ProductPriceHistory table
DROP TABLE IF EXISTS ProductPriceHistory;
CREATE TABLE ProductPriceHistory
( ProductID				SMALLINT  NOT NULL,
  PriceChangeDate		DATE NOT NULL,
  SalesPrice			DECIMAL(7,2) NOT NULL,
  CONSTRAINT PK_ProductPriceHistory_ProductID_PriceChangeDate PRIMARY KEY ( ProductID, PriceChangeDate ),
  CONSTRAINT FK_ProductPriceHistory_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID )
);

INSERT INTO ProductPriceHistory
VALUES (1,'2019-05-07',99.84),(1,'2019-08-10',100.81),(1,'2019-12-20',102.75),
       (2,'2019-01-31',33.73),(2,'2020-02-14',32.15),(3,'2019-08-10',25.43),
       (3,'2019-12-09',24.90),(3,'2020-02-20',27.02),(4,'2019-01-28',18.27),
       (4,'2019-08-12',20.43),(5,'2019-01-07',37.11),(5,'2019-05-26',35.72),
       (5,'2019-08-26',33.29),(5,'2020-02-28',35.37),(6,'2019-08-16',78.91),
       (7,'2019-01-15',53.09),(7,'2019-05-21',51.11),(7,'2019-12-10',46.64),
       (7,'2020-02-03',50.61),(8,'2019-01-10',3.14),(8,'2019-08-13',3.05),
       (8,'2019-12-23',3.11),(9,'2019-01-15',9.79),(9,'2019-05-31',8.88),
       (9,'2019-08-15',8.78),(9,'2020-02-17',8.97),(10,'2019-01-06',50.89),
       (10,'2019-05-03',46.13),(10,'2019-08-28',49.46),(10,'2019-12-25',50.41),
       (10,'2020-02-05',48.51);


