USE AboutYouDb
GO

INSERT INTO Users (Username, Email, PasswordHash, FirstName, LastName, DefaultAddress) VALUES
('fashionista', 'fashionista@example.com', 'hashedpassword123a', 'Anna', 'Stefanova', '101 Trendy Street, Sofia'),
('shopperking', 'shopperking@example.com', 'hashedpassword456b', 'Borislav', 'Petrov', '25 Commerce Blvd, Plovdiv'),
('stylehunter', 'stylehunter@example.com', 'hashedpassword789c', 'Silvia', 'Georgieva', '5 Central Square, Varna'),
('trendsetter', 'trendsetter@example.com', 'hashedpassword101d', 'Dimitar', 'Kolev', '8 River Lane, Ruse'),
('bargainfind', 'bargainfind@example.com', 'hashedpassword112e', 'Elena', 'Ivanova', '3 Outlet Drive, Burgas'),
('casualguy', 'casualguy@example.com', 'hashedpassword123f', 'Kaloyan', 'Nikolov', '12 Comfort Road, Stara Zagora');

INSERT INTO Categories (Name, ParentCategoryID) VALUES
('Clothing', NULL),
('Shoes', NULL),
('Accessories', NULL),
('Women', 1),
('Men', 1),
('Sneakers', 2),
('Jeans', 4),
('T-Shirts', 5);

INSERT INTO Brands (Name, LogoURL) VALUES
('Adidas', 'url_adidas_logo'),
('Levi''s', 'url_levis_logo'),
('Vero Moda', 'url_veromoda_logo'),
('Jack & Jones', 'url_jackjones_logo'),
('Puma', 'url_puma_logo'),
('Tommy Hilfiger', 'url_tommyhilfiger_logo');

INSERT INTO Products (Name, Description, Price, StockQuantity, ImageURL, CategoryID, BrandID) VALUES
('Women''s High-Waist Jeans', 'Classic fit, 100% cotton.', 59.99, 150, 'url_jeans_w', 7, 2),
('Men''s Graphic T-Shirt', 'Soft cotton, modern print.', 24.99, 200, 'url_tshirt_m', 8, 4),
('Cloudfoam Sneakers', 'Lightweight and comfortable.', 79.95, 120, 'url_sneakers_a', 6, 1),
('Women''s Summer Dress', 'Flowy midi dress, floral print.', 49.50, 90, 'url_dress_w', 4, 3),
('Retro Basketball Shoes', 'High-top design, premium leather.', 109.99, 75, 'url_shoes_p', 6, 5),
('Men''s Logo Polo Shirt', 'Piqué cotton, classic fit.', 69.00, 110, 'url_polo_th', 5, 6);

INSERT INTO Orders (UserID, OrderDate, TotalAmount, Status) VALUES
(1, GETDATE(), 139.94, 'Completed'),
(2, DATEADD(day, -5, GETDATE()), 79.95, 'Completed'),
(3, DATEADD(day, -2, GETDATE()), 159.98, 'Processing'),
(4, DATEADD(day, -10, GETDATE()), 138.99, 'Shipped'),
(1, DATEADD(day, -1, GETDATE()), 24.99, 'Cancelled'),
(6, GETDATE(), 109.99, 'Processing');

INSERT INTO Order_Items (OrderID, ProductID, Quantity, PricePerItem) VALUES
(1, 1, 1, 59.99),
(1, 4, 1, 49.50);

INSERT INTO Order_Items (OrderID, ProductID, Quantity, PricePerItem) VALUES
(2, 3, 1, 79.95);

INSERT INTO Order_Items (OrderID, ProductID, Quantity, PricePerItem) VALUES
(3, 1, 2, 59.99);

INSERT INTO Order_Items (OrderID, ProductID, Quantity, PricePerItem) VALUES
(4, 6, 1, 69.00),
(4, 2, 2, 24.99);

INSERT INTO Order_Items (OrderID, ProductID, Quantity, PricePerItem) VALUES
(5, 2, 1, 24.99);

INSERT INTO Order_Items (OrderID, ProductID, Quantity, PricePerItem) VALUES
(6, 5, 1, 109.99);

INSERT INTO Reviews (ProductID, UserID, Rating, Comment, ReviewDate) VALUES
(1, 1, 5, 'Perfect fit, high quality denim.', DATEADD(day, -3, GETDATE())),
(3, 2, 4, 'Very comfortable, great for everyday wear.', DATEADD(day, -4, GETDATE())),
(1, 3, 4, 'Good value, but a little long.', DATEADD(day, -1, GETDATE())),
(6, 4, 5, 'Classic polo, feels very premium.', DATEADD(day, -9, GETDATE())),
(2, 1, 3, 'Decent quality, the print is nice but the material is average.', DATEADD(day, 0, GETDATE())),
(5, 6, 5, 'Awesome retro look, highly recommend!', DATEADD(day, 0, GETDATE()));