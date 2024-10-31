-- Drop existing tables if they exist

DROP TABLE IF EXISTS Fact_Sales CASCADE;
DROP TABLE IF EXISTS Dim_Date CASCADE;
DROP TABLE IF EXISTS Dim_Product CASCADE;
DROP TABLE IF EXISTS Dim_Country CASCADE;
DROP TABLE IF EXISTS Dim_Segments CASCADE;

-- Create the dimension tables

CREATE TABLE Dim_Segments (
    SegmentKey SERIAL PRIMARY KEY,
    Segment VARCHAR(50) NOT NULL
);

CREATE TABLE Dim_Country (
    CountryKey SERIAL PRIMARY KEY,
    Country VARCHAR(50) NOT NULL
);

CREATE TABLE Dim_Product (
    ProductKey SERIAL PRIMARY KEY,
    Product VARCHAR(50) NOT NULL,
    Manufacturing_Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Dim_Date (
    DateKey SERIAL PRIMARY KEY,
    Date DATE NOT NULL,
    Month_Number INTEGER NOT NULL,
    Month_Name VARCHAR(20) NOT NULL,
    Year INTEGER NOT NULL,
    Quarter VARCHAR(2) NOT NULL
);

-- Create the fact table

CREATE TABLE Fact_Sales (
    Sales_ID SERIAL PRIMARY KEY,
    Segment VARCHAR(50),
    Country VARCHAR(50),
    Product VARCHAR(50),
    Discount_Band VARCHAR(50),
    Units_Sold INTEGER,
    Manufacturing_Price DECIMAL(10, 2),
    Sale_Price DECIMAL(10, 2),
    Gross_Sales DECIMAL(10, 2),
    Discounts DECIMAL(10, 2),
    Sales DECIMAL(10, 2),
    COGS DECIMAL(10, 2),
    Profit DECIMAL(10, 2),
    Date DATE,
    Month_Number INTEGER,
    Month_Name VARCHAR(20),
    Year INTEGER
);

-- Insert data into Dim_Segments

INSERT INTO Dim_Segments (Segment) VALUES
('Channel Partners'),
('Enterprise'),
('Government'),
('Midmarket'),
('Small Business');

-- Insert data into Dim_Country

INSERT INTO Dim_Country (Country) VALUES
('Canada'),
('France'),
('Germany'),
('United States of America');

-- Insert data into Dim_Product

INSERT INTO Dim_Product (Product, Manufacturing_Price) VALUES
('Amarilla', 260.00),
('Carretera', 3.00),
('Montana', 5.00),
('Paseo', 10.00),
('Velo', 120.00),
('VTT', 250.00);

-- Insert data into Dim_Date

INSERT INTO Dim_Date (Date, Month_Number, Month_Name, Year, Quarter) VALUES
('2013-01-01', 1, 'January', 2013, 'Q1'),
('2013-02-01', 2, 'February', 2013, 'Q1'),
('2013-03-01', 3, 'March', 2013, 'Q1'),
('2013-04-01', 4, 'April', 2013, 'Q2'),
('2013-05-01', 5, 'May', 2013, 'Q2'),
('2013-06-01', 6, 'June', 2013, 'Q2'),
('2013-07-01', 7, 'July', 2013, 'Q3'),
('2013-08-01', 8, 'August', 2013, 'Q3'),
('2013-09-01', 9, 'September', 2013, 'Q3'),
('2013-10-01', 10, 'October', 2013, 'Q4'),
('2013-11-01', 11, 'November', 2013, 'Q4'),
('2013-12-01', 12, 'December', 2013, 'Q4'),
('2014-01-01', 1, 'January', 2014, 'Q1'),
('2014-02-01', 2, 'February', 2014, 'Q1'),
('2014-03-01', 3, 'March', 2014, 'Q1'),
('2014-04-01', 4, 'April', 2014, 'Q2'),
('2014-05-01', 5, 'May', 2014, 'Q2'),
('2014-06-01', 6, 'June', 2014, 'Q2'),
('2014-07-01', 7, 'July', 2014, 'Q3'),
('2014-08-01', 8, 'August', 2014, 'Q3'),
('2014-09-01', 9, 'September', 2014, 'Q3'),
('2014-10-01', 10, 'October', 2014, 'Q4'),
('2014-11-01', 11, 'November', 2014, 'Q4'),
('2014-12-01', 12, 'December', 2014, 'Q4');