CREATE DATABASE AboutYouDb
GO
USE AboutYouDb
GO

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(256) NOT NULL,
    FirstName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NULL,
    DefaultAddress NVARCHAR(200) NULL
);
GO

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    ParentCategoryID INT NULL,
    CONSTRAINT FK_Categories_Parent FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
);
GO

CREATE TABLE Brands (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    LogoURL NVARCHAR(255) NULL
);
GO

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL,
    ImageURL NVARCHAR(255) NULL,
    CategoryID INT NULL,
    BrandID INT NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT FK_Products_Brands FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)
);
GO

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT NOT NULL,
    Comment NVARCHAR(500) NULL,
    ReviewDate DATETIME NOT NULL,
    CONSTRAINT FK_Reviews_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_Reviews_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE TABLE Order_Items (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    PricePerItem DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO