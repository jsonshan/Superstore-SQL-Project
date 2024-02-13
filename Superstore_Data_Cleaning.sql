

--Superstore Dataset-------------------------------------------------------------------------------------------------

-- Objective: Cleaning process for superstore dataset

-- Observe data
-- Removing duplicate rows
-- Correctly formatting columns for SQL analysis

-----------------------------------------------------------------------------------------------------------------------------

-- Taking an overview of our Superstore dataset

SELECT TOP 100 *
FROM PortfolioProject..Superstore

-----------------------------------------------------------------------------------------------------------------------------

-- Standardize Data Format

SELECT *
FROM PortfolioProject..Superstore

SELECT [Order Date], CONVERT(Date,[Order Date]) as [Order Date Fixed]
FROM PortfolioProject..Superstore

Update PortfolioProject..Superstore
SET [Order Date] = CONVERT(Date,[Order Date])

-- This did not update properly, so trying additional method

ALTER TABLE Superstore
ADD [Order Date Fixed] Date;

UPDATE Superstore
SET [Order Date Fixed] = CONVERT(Date,[Order Date])


ALTER TABLE Superstore
ADD [Ship Date Fixed] Date;

UPDATE Superstore
SET [Ship Date Fixed] = CONVERT(Date,[Ship Date])

Select *
FROM PortfolioProject..Superstore

-----------------------------------------------------------------------------------------------------------------------------

-- Checking for duplicates

SELECT *
FROM PortfolioProject..Superstore

SELECT [ROW ID], [ORDER ID], [Product ID], [Product Name], COUNT(*) as Duplicate_Count
FROM PortfolioProject..Superstore
GROUP BY [ROW ID], [ORDER ID], [Product ID], [Product Name]
HAVING COUNT(*) > 1;

-----------------------------------------------------------------------------------------------------------------------------

-- Checking for inconsistencies in length for ORDER ID and Postal Code

SELECT *
FROM PortfolioProject..Superstore

SELECT [Order ID],
	CASE
		WHEN LEN([Order ID]) > 14 THEN 'Too long'
		WHEN LEN([ORDER ID]) < 14 THEN 'Too short'
		ELSE 'Just right'
	END AS length_checker
FROM PortfolioProject..Superstore
ORDER BY length_checker




SELECT [Postal Code]
FROM PortfolioProject..Superstore
WHERE LEN([Postal Code]) != 5 and LEN([Postal Code]) != 4;

-----------------------------------------------------------------------------------------------------------------------------

-- Round Sales column to 2 floats to deal with dollar value only

SELECT *
FROM PortfolioProject..Superstore

SELECT Sales, ROUND(Sales, 2) AS Rounded_Sales
FROM PortfolioProject..Superstore;

ALTER TABLE Superstore
ADD Rounded_Sales float;

UPDATE Superstore
SET Rounded_Sales = ROUND(Sales, 2)


-----------------------------------------------------------------------------------------------------------------------------

-- Delete unused Columns

SELECT *
FROM PortfolioProject..Superstore


ALTER TABLE PortfolioProject..Superstore
DROP COLUMN [Order Date], [Ship Date]

ALTER TABLE PortfolioProject..Superstore
DROP COLUMN Sales


-----------------------------------------------------------------------------------------------------------------------------

-- Rename columns back to original to start data analysis 

SELECT *
FROM PortfolioProject..Superstore

--EXEC sp_rename 'Superstore.[Order Date Fixed]', [Order Date], 'COLUMN';

--EXEC sp_rename 'Superstore.[Ship Date Fixed]', [Ship Date], 'COLUMN';

--EXEC sp_rename 'Superstore.[Rounded_Sales]', [Sales], 'COLUMN';


