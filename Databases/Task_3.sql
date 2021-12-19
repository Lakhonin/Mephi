Create table Category (
  CatID integer NOT NULL,
  CatNam varchar (50) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Primary key (CatID), 
);

Create table Component (
  ComponentId integer NOT NULL,
  CatID integer NOT NULL,
  ComponentName varchar (20) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Cost integer NOT NULL DEFAULT 1 CHECK (Cost > 0),
  IncreaseCost float NOT NULL CHECK (IncreaseCost >= 0.3),
  Primary key (ComponentId, CatID),
  Foreign key (CatID) references Category on delete restrict,
);
 
Create table COrder (
  OrderID integer Identity NOT NULL,
  OrderCode varchar NOT NULL CHECK (OrderCode LIKE '[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'),
  CreateDate date NOT NULL DEFAULT GETDATE(),
  EmpName varchar (20) NOT NULL,
  CommonCost integer NOT NULL DEFAULT 0 CHECK (Cost >= 0),
  ExecuteDate date NULL, CHECK (DATEDIFF(day,CreateDate,ExecuteDate) >= 1),
  PaymentDate date NULL, CHECK (DATEDIFF(day,FromDate,ExecuteDate) >= 1),
  Primary key (RenterId),  
);

Create table OrderItem (
  CatID integer NOT NULL,
  ComponentId integer NOT NULL,
  OrderID integer Identity NOT NULL,
  Comment varchar NOT NULL,
  Primary key (CatID, ComponentId, OrderID),
  Foreign key (CatID, ComponentId) references Component on delete restrict,
  Foreign key (OrderID) references COrder on delete restrict
);
-------------------------------------------------------------------------------------------------
Create table GoodsGrp (
  GrpID  integer Identity NOT NULL,
  GrpName varchar (50) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Primary key (GrpID), 
);

Create table Goods (
  GoodsId integer NOT NULL,
  GrpID integer NOT NULL,
  GoodsName  varchar (200) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  CommonQty integer NOT NULL DEFAULT 0 CHECK (CommonQty >= 0),
  Cost float NOT NULL  CHECK (Cost >= 0.01 AND Cost =< 9999.99 ),
  Primary key (GrpID, GoodsId),
  Foreign key (GrpID) references BuildType on delete restrict,
);
 
Create table ReceiptDoc (
  ReceiptDocID integer Identity NOT NULL,
  CreateDate date NOT NULL DEFAULT GETDATE(),
  EmpName varchar (30) NOT NULL,
  PaymentDate date NOT NULL CHECK (DATEDIFF(day,EmpName,PaymentDate) >= 1),
  ReceiptCode integer NOT NULL CHECK (ReceiptCode LIKE '[A-Z][A-Z][A-Z]_[0-9][0-9][0-9][0-9]'),
  Primary key (ReceiptDocID),  
);

Create table DocItem (
  GrpID  integer Identity NOT NULL,
  GoodsId integer NOT NULL,
  ReceiptDocID integer Identity NOT NULL,
  Qty date NOT NULL,
  Primary key (GrpID, GoodsId, ReceiptDocID),
  Foreign key (GrpID, GoodsId) references Goods on delete restrict,
  Foreign key (ReceiptDocID) references ReceiptDoc on delete restrict
);
-------------------------------------------------------------------------------------------------
Create table BuildType (
  BuildTypeId integer NOT NULL,
  BuildTypeName varchar (50) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Primary key (BuildTypeId), 
);

Create table Building (
  BuildingId integer NOT NULL,
  BuildTypeId integer NOT NULL,
  Address varchar (200) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Payment integer NOT NULL DEFAULT 12500 CHECK (Payment > 0),
  Primary key (BuildingId, BuildTypeId),
  Foreign key (BuildTypeId) references BuildType on delete restrict,
);
 
Create table Renter (
  RenterId integer Identity NOT NULL,
  RegisterDate date NOT NULL DEFAULT GETDATE(),
  LastName varchar (20) NOT NULL,
  FirstName varchar (20) NOT NULL,
  MiddleName varchar (20) NULL,
  Passport integer NOT NULL CHECK (Passport LIKE '[0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9]'),
  Primary key (RenterId),  
);

Create table Contract (
  BuildingId integer NOT NULL,
  BuildTypeId integer NOT NULL,
  RenterId identity NOT NULL,
  FromDate date NOT NULL,
  ToDate date NOT NULL CHECK (DATEDIFF(month,FromDate,ToDate) > 1),
  Primary key (BuildingId, BuildTypeId, RenterId),
  Foreign key (BuildingId, BuildTypeId) references Building on delete restrict,
  Foreign key (RenterId) references Renter on delete restrict
);
-------------------------------------------------------------------------------------------------
Create table Category (
  CatID integer NOT NULL,
  CatNam varchar (50) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Primary key (CatID), 
);

Create table Component (
  ComponentId integer NOT NULL,
  CatID integer NOT NULL,
  ComponentName varchar (20) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Cost integer NOT NULL DEFAULT 1 CHECK (Cost > 0),
  IncreaseCost float NOT NULL CHECK (IncreaseCost >= 0.3),
  Primary key (ComponentId, CatID),
  Foreign key (CatID) references Category on delete restrict,
);
 
Create table COrder (
  OrderID integer Identity NOT NULL,
  OrderCode varchar NOT NULL CHECK (OrderCode LIKE '[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'),
  CreateDate date NOT NULL DEFAULT GETDATE(),
  EmpName varchar (20) NOT NULL,
  CommonCost integer NOT NULL DEFAULT 0 CHECK (Cost >= 0),
  ExecuteDate date NULL, CHECK (DATEDIFF(day,CreateDate,ExecuteDate) >= 1),
  PaymentDate date NULL, CHECK (DATEDIFF(day,FromDate,ExecuteDate) >= 1),
  Primary key (RenterId),  
);

Create table OrderItem (
  CatID integer NOT NULL,
  ComponentId integer NOT NULL,
  OrderID integer Identity NOT NULL,
  Comment varchar NOT NULL,
  Primary key (CatID, ComponentId, OrderID),
  Foreign key (CatID, ComponentId) references Component on delete restrict,
  Foreign key (OrderID) references COrder on delete restrict
);
-------------------------------------------------------------------------------------------------
Create table GoodsGrp (
  GrpID  integer Identity NOT NULL,
  GrpName varchar (50) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Primary key (GrpID), 
);

Create table Goods (
  GoodsId integer NOT NULL,
  GrpID integer NOT NULL,
  GoodsName  varchar (200) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  CommonQty integer NOT NULL DEFAULT 0 CHECK (CommonQty >= 0),
  Cost float NOT NULL  CHECK (Cost >= 0.01 AND Cost =< 9999.99 ),
  Primary key (GrpID, GoodsId),
  Foreign key (GrpID) references BuildType on delete restrict,
);
 
Create table ReceiptDoc (
  ReceiptDocID integer Identity NOT NULL,
  CreateDate date NOT NULL DEFAULT GETDATE(),
  EmpName varchar (30) NOT NULL,
  PaymentDate date NOT NULL CHECK (DATEDIFF(day,EmpName,PaymentDate) >= 1),
  ReceiptCode integer NOT NULL CHECK (ReceiptCode LIKE '[A-Z][A-Z][A-Z]_[0-9][0-9][0-9][0-9]'),
  Primary key (ReceiptDocID),  
);

Create table DocItem (
  GrpID  integer Identity NOT NULL,
  GoodsId integer NOT NULL,
  ReceiptDocID integer Identity NOT NULL,
  Qty date NOT NULL,
  Primary key (GrpID, GoodsId, ReceiptDocID),
  Foreign key (GrpID, GoodsId) references Goods on delete restrict,
  Foreign key (ReceiptDocID) references ReceiptDoc on delete restrict
);
-------------------------------------------------------------------------------------------------
Create table BuildType (
  BuildTypeId integer NOT NULL,
  BuildTypeName varchar (50) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Primary key (BuildTypeId), 
);

Create table Building (
  BuildingId integer NOT NULL,
  BuildTypeId integer NOT NULL,
  Address varchar (200) NOT NULL UNIQUE,
  Properties varchar (200) NULL,
  Payment integer NOT NULL DEFAULT 12500 CHECK (Payment > 0),
  Primary key (BuildingId, BuildTypeId),
  Foreign key (BuildTypeId) references BuildType on delete restrict,
);
 
Create table Renter (
  RenterId integer Identity NOT NULL,
  RegisterDate date NOT NULL DEFAULT GETDATE(),
  LastName varchar (20) NOT NULL,
  FirstName varchar (20) NOT NULL,
  MiddleName varchar (20) NULL,
  Passport integer NOT NULL CHECK (Passport LIKE '[0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9]'),
  Primary key (RenterId),  
);

Create table Contract (
  BuildingId integer NOT NULL,
  BuildTypeId integer NOT NULL,
  RenterId identity NOT NULL,
  FromDate date NOT NULL,
  ToDate date NOT NULL CHECK (DATEDIFF(month,FromDate,ToDate) > 1),
  Primary key (BuildingId, BuildTypeId, RenterId),
  Foreign key (BuildingId, BuildTypeId) references Building on delete restrict,
  Foreign key (RenterId) references Renter on delete restrict
);
