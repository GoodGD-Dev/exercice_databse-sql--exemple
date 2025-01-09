# Tabelas e Dados

# Tabela Customer
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    DateOfBirth DATE
);

# Inserindo dados na tabela Customer
INSERT INTO Customer (FirstName, LastName, Email, Phone, Address, DateOfBirth) 
VALUES 
('Alice', 'Johnson', 'alice.johnson@example.com', '555123456', '789 Pine St', '1985-05-15'),
('Bob', 'Brown', 'bob.brown@example.com', '555987654', '321 Oak St', '1992-11-30');

# Tabela Product
CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

# Inserindo dados na tabela Product
INSERT INTO Product (ProductName, Description, Price, Stock) 
VALUES 
('Smartphone', 'Latest model smartphone', 999.99, 25),
('Tablet', '10-inch display tablet', 399.99, 40),
('Smartwatch', 'Fitness tracking smartwatch', 199.99, 35),
('Headphones', 'Noise-cancelling headphones', 149.99, 50),
('Charger', 'Fast charging adapter', 29.99, 100);

# Tabela Order
CREATE TABLE "Order" (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

# Inserindo dados na tabela Order
INSERT INTO "Order" (CustomerID, OrderDate, Total) 
VALUES 
(1, '2024-01-01', 1249.98),
(2, '2024-01-05', 29.99);

# Tabela OrderItem
CREATE TABLE OrderItem (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES "Order"(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

# Inserindo dados na tabela OrderItem
INSERT INTO OrderItem (OrderID, ProductID, Quantity, UnitPrice) 
VALUES 
(1, 1, 1, 999.99),
(1, 2, 1, 399.99),
(2, 5, 1, 29.99);