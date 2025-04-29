create database deodorant_database;
use deodorant_database;

select count('Brand Name') 
from deodorant_database.deodorant_dataset;

select *from deodorant_database.`deodorant_dataset`;

-- Basic SQL Questions:

-- Que 1. Retrieve all details of deodorants priced above 500 INR.
-- Answer :

SELECT 
    *
FROM
    deodorant_database.`deodorant_dataset`
WHERE
    `Price (INR)` > 500;
    
-- Que 2. List distinct fragrance types available in the dataset.
-- Answer

SELECT DISTINCT
    (`Fragrance Type`)
FROM
    deodorant_database.`deodorant_dataset`;
    
-- Que 3. Count the number of deodorants that are alcohol-free.
-- Answer:

SELECT 
    COUNT(*)
FROM
    deodorant_database.`deodorant_dataset`
WHERE
    `Alcohol-Free` = 'yes'; 

-- Que 4. Retrieve the top 5 highest-rated deodorants.
-- Answer:

SELECT 
    *
FROM
    deodorant_database.`deodorant_dataset`
ORDER BY `Customer Rating` DESC
LIMIT 5;

-- Que 5. Show the number of deodorants available for each category (Men, Women, Unisex).

SELECT 
    `Category`, COUNT(*)
FROM
    deodorant_database.`deodorant_dataset`
GROUP BY `Category`;


-- Intermediate SQL Questions:

-- Que 1.Find the average price of deodorants for each fragrance type.
-- Answer:
SELECT 
    `Fragrance Type`, AVG(`Price (INR)`)
FROM
    deodorant_database.`deodorant_dataset`
GROUP BY `Fragrance Type`;

-- Que 2. Retrieve the top 3 retailers with the highest number of sales in the last month.
-- Answer 

SELECT 
    `Retailer Name`,
    COUNT(`Sales in Last Month (Units)`) AS 'Highest Sale'
FROM
    deodorant_database.`deodorant_dataset`
GROUP BY `Retailer Name`
ORDER BY `Highest Sale` DESC
LIMIT 3;

-- Que 3. List deodorants that have a shelf life of more than 24 months and are also alcohol-free.
-- Answer:

SELECT 
    *
FROM
    deodorant_database.`deodorant_dataset`
WHERE
    `Shelf Life (Months)` > 24
        AND `Alcohol-Free` = 'yes';
        
-- Que 4.Show the percentage of deodorants available online vs. offline.
-- Answer:

SELECT 
    `Online Availability`,
    ROUND(COUNT(*) * 100.0 / (SELECT 
                    COUNT(*)
                FROM
                    deodorant_database.`deodorant_dataset`),
            2) AS percentage
FROM
    deodorant_database.`deodorant_dataset`
GROUP BY `Online Availability`;

-- Que 5. Find the total sales in the last month for each brand.
-- Answer 

SELECT 
    `Brand Name`,
    SUM(`Sales in Last Month (Units)`) AS Total_Sales
FROM
    deodorant_database.`deodorant_dataset`
GROUP BY `Brand Name`;


-- Advanced SQL Questions :

-- 1.Identify the most popular deodorant category based on total sales in the last month.
-- Answer :

SELECT 
    `Category`,
    SUM(`Sales in Last Month (Units)`) AS Total_Sales
FROM
    deodorant_database.`deodorant_dataset`
GROUP BY `Category`
ORDER BY `Total_Sales` DESC
LIMIT 1;

-- 2. Calculate the average customer rating for each retailer.
-- Answer

SELECT 
    `Retailer Name`,
    ROUND(AVG(`Customer Rating`), 3) AS `Average Rating`
FROM
    deodorant_database.`deodorant_dataset`
GROUP BY `Retailer Name`;

-- 3. Find the deodorants with the highest discount but still have a customer rating above 4.5.
-- Answer

SELECT 
    `Discount (%)`, `Customer Rating`
FROM
    deodorant_database.`deodorant_dataset`
WHERE
    `Customer Rating` > 4.5
ORDER BY `Discount (%)` DESC;

-- Que 4. Determine the correlation between price and customer rating using SQL queries
-- Answer

SELECT 
    (SUM((`Price (INR)` - `avg_price`) * (`Customer Rating` - `avg_rating`)) / (SQRT(SUM(POWER(`Price (INR)` - `avg_price`, 2))) * SQRT(SUM(POWER(`Customer Rating` - `avg_rating`, 2))))) AS correlation
FROM
    (SELECT 
        AVG(`Price (INR)`) AS `avg_price`,
            AVG(`Customer Rating`) AS `avg_rating`
    FROM
        deodorant_database.`deodorant_dataset`) AS `avg_values`,
    deodorant_database.`deodorant_dataset`;
    
-- Que 5. List the top 5 best-selling deodorants along with their revenue generated after applying discounts.
-- Answer

SELECT 
    `Product Name`,
    `Sales in Last Month (Units)`,
    (`Price (INR)` * (1 - `Discount (%)` * 100) * `Sales in Last Month (Units)`) AS Revenue
FROM
    deodorant_database.`deodorant_dataset`
ORDER BY `Revenue` DESC
LIMIT 5;







