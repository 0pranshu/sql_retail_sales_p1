-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
SELECT * FROM retail_sales

-- Date cleaning 
SELECT *FROM retail_sales
WHERE transactions_id IS NULL
	OR	
	sale_date	IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id	IS NULL
	OR
	gender IS NULL
	OR
	age	IS NULL
	OR
	category IS NULL
	OR
	quantiy		IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

--Deleting Null value 

DELETE FROM retail_sales
WHERE transactions_id IS NULL
	OR	
	sale_date	IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id	IS NULL
	OR
	gender IS NULL
	OR
	age	IS NULL
	OR
	category IS NULL
	OR
	quantiy		IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales



SELECT DISTINCT category FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 How many total transactions have been recorded in the dataset?
-- Q.2 What is the total revenue generated from all sales?
-- Q.3 What is the average quantity of items sold per transaction?
-- Q.4 What is the peak sales hour of the day based on total sales value?
-- Q.5 Which day of the week records the highest sales volume?
-- Q.6 What is the monthly trend of total sales in the dataset?
-- Q.7 What is the gender-wise distribution of total sales?
-- Q.8 What is the average age of customers making purchases?
-- Q.9 Identify the top 5 highest-spending customers based on total sales.
-- Q.10 What are the top 3 most sold product categories by quantity?
-- Q.11 Which product category generates the highest total sales revenue?
-- Q.12 Identify the category with the highest profit margin (total_sale - cogs).
-- Q.13 What percentage of total sales comes from customers aged above 40?
-- Q.14 Find the total sales and average quantity per transaction for each category.
-- Q.15 What is the trend of sales during weekends compared to weekdays?



-- Q.1 How many total transactions have been recorded in the dataset?
  SELECT  
	COUNT(*) AS total_transactions 
  FROM retail_sales;
 
-- Q.2 What is the total revenue generated from all sales?
  SELECT
  SUM (Total_sale) AS total_Sale   
  FROM retail_sales;
    
-- Q.3 What is the average quantity of items sold per transaction?

  SELECT 
	  ROUND(AVG(quantiy), 2) AS avg_quantity_per_transaction  
  FROM retail_sales;

-- Q.4 What is the peak sales hour of the day based on total sales value?

SELECT 
    EXTRACT(HOUR FROM sale_time) AS sales_hour, 
    SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY sales_hour
ORDER BY total_revenue DESC
LIMIT 1;

-- Q.5 Which day of the week records the highest sales volume?

SELECT 
    TO_CHAR(sale_date, 'day') AS sales_day, 
    SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY sales_day
ORDER BY total_revenue DESC
LIMIT 1;


-- Q.6 What is the monthly trend of total sales in the dataset?

SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS sales_month, 
    SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY sales_month
ORDER BY sales_month;

-- Q.7 What is the gender-wise distribution of total sales?

SELECT gender,
      SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY gender;

-- Q.8 What is the average age of customers making purchases?

SELECT 
    ROUND( AVG( age),2) AS avg_age
FROM retail_sales

-- Q.9 Identify the top 5 highest-spending customers based on total sales.

SELECT customer_id,
      SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.10 What are the top 3 most sold product categories by quantity?

SELECT category,
      SUM(quantiy) AS total_quantiy
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC


-- Q.11 Which product category generates the highest total sales revenue?

SELECT category,
       SUM(total_sale) AS total_sales_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_sales_revenue DESC
LIMIT 1;


-- Q.12 Identify the category with the highest profit margin (total_sale - cogs).

SELECT category,
      SUM(total_sale - cogs) AS  highest_profit_margin
FROM retail_sales
GROUP BY category
ORDER BY  highest_profit_margin DESC
LIMIT 1;

-- Q.13 What percentage of total sales comes from customers aged above 40?

SELECT 
    (SUM(CASE WHEN age > 40 THEN total_sale ELSE 0 END) * 100.0) / SUM(total_sale) AS sales_percentage_above_40
FROM retail_sales;

-- Q.14 Find the total sales and average quantity per transaction for each category.

SELECT 
    category, 
    SUM(total_sale) AS total_sales, 
    ROUND(AVG(quantiy), 2) AS avg_quantity_per_transaction
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

-- Q.15 What is the trend of sales during weekends compared to weekdays?

SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM sale_date) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY day_type
ORDER BY total_sales DESC;


