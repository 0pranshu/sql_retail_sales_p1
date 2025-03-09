
# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,    
    sale_time TIME,
    customer_id INT,    
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,    
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

**The following SQL queries were developed to answer specific business questions:**

1. **How many total transactions have been recorded in the dataset?**

```sql
 SELECT  
 COUNT(*) AS total_transactions 
FROM retail_sales;

```

3. **What is the total revenue generated from all sales?**
   '''sql
  SELECT
  SUM (Total_sale) AS total_Sale   
  FROM retail_sales;
   '''
4. **What is the average quantity of items sold per transaction?**
   '''sql
  SELECT 
	  ROUND(AVG(quantiy), 2) AS avg_quantity_per_transaction  
  FROM retail_sales;
   '''
5. **What is the peak sales hour of the day based on total sales value?**
   '''sql 
SELECT 
    EXTRACT(HOUR FROM sale_time) AS sales_hour, 
    SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY sales_hour
ORDER BY total_revenue DESC
LIMIT 1;
   '''
6. **Which day of the week records the highest sales volume?**
   '''sql
SELECT 
    TO_CHAR(sale_date, 'day') AS sales_day, 
    SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY sales_day
ORDER BY total_revenue DESC
LIMIT 1;
   '''

7. **What is the monthly trend of total sales in the dataset?**
   '''sql
SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS sales_month, 
    SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY sales_month
ORDER BY sales_month;
   '''
8. **What is the gender-wise distribution of total sales?**
   '''sql
SELECT gender,
      SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY gender;
   '''
9. **What is the average age of customers making purchases?**
   '''sql
SELECT 
    ROUND( AVG( age),2) AS avg_age
FROM retail_sales
   '''  
10. **Identify the top 5 highest-spending customers based on total sales.**
   '''sql
SELECT customer_id,
      SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
   '''
11. **What are the top 3 most sold product categories by quantity?**
    '''sql
SELECT category,
      SUM(quantiy) AS total_quantiy
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
   '''

12. **Which product category generates the highest total sales revenue?**
    '''sql
SELECT category,
       SUM(total_sale) AS total_sales_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_sales_revenue DESC
LIMIT 1;
    '''

13. **Identify the category with the highest profit margin (total_sale - cogs).**
    '''sql
SELECT category,
      SUM(total_sale - cogs) AS  highest_profit_margin
FROM retail_sales
GROUP BY category
ORDER BY  highest_profit_margin DESC
LIMIT 1;
  '''
14. **What percentage of total sales comes from customers aged above 40?**
    '''sql
SELECT 
    (SUM(CASE WHEN age > 40 THEN total_sale ELSE 0 END) * 100.0) / SUM(total_sale) AS sales_percentage_above_40
FROM retail_sales;
  '''
15. **Find the total sales and average quantity per transaction for each category.**
    '''sql
SELECT 
    category, 
    SUM(total_sale) AS total_sales, 
    ROUND(AVG(quantiy), 2) AS avg_quantity_per_transaction
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;
   '''
16. **What is the trend of sales during weekends compared to weekdays?**
    '''sql
SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM sale_date) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY day_type
ORDER BY total_sales DESC;
  '''
## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

