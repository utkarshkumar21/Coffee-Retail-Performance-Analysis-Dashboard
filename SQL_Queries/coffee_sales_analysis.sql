--A. KPI’s
️-- 1. Total Revenue
SELECT 
    SUM(total_price) AS total_revenue
FROM coffee_sales;

--2. Average Order Value
SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM coffee_sales;
--3.Total Coffees Sold
SELECT 
    SUM(quantity) AS total_coffees_sold
FROM coffee_sales;
--4. Total Orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM coffee_sales;

--5.Average Coffees Per Order
SELECT 
    CAST(
        SUM(quantity) * 1.0 / COUNT(DISTINCT order_id)
        AS DECIMAL(10,2)
    ) AS avg_coffees_per_order
FROM coffee_sales;

--B. Daily Trend for Total Orders
SELECT 
    DATENAME(WEEKDAY, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM coffee_sales
GROUP BY DATENAME(WEEKDAY, order_date);

--C. Monthly Trend for Total Orders
SELECT 
    DATENAME(MONTH, order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM coffee_sales
GROUP BY DATENAME(MONTH, order_date), MONTH(order_date)
ORDER BY MONTH(order_date);
--D. % of Sales by Coffee Category
SELECT 
    coffee_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM coffee_sales)
        AS DECIMAL(10,2)
    ) AS pct_sales
FROM coffee_sales
GROUP BY coffee_category;
--E. % of Sales by Coffee Size
SELECT 
    coffee_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM coffee_sales)
        AS DECIMAL(10,2)
    ) AS pct_sales
FROM coffee_sales
GROUP BY coffee_size
ORDER BY coffee_size;
--F. Total Coffees Sold by Coffee Category (Month-wise)
SELECT 
    coffee_category,
    SUM(quantity) AS total_quantity_sold
FROM coffee_sales
WHERE MONTH(order_date) = 2
GROUP BY coffee_category
ORDER BY total_quantity_sold DESC;
--G. Top 5 Coffees by Revenue
SELECT TOP 5
    coffee_name,
    SUM(total_price) AS total_revenue
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_revenue DESC;

--H. Bottom 5 Coffees by Revenue
SELECT TOP 5
    coffee_name,
    SUM(total_price) AS total_revenue
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_revenue ASC;
--I. Top 5 Coffees by Quantity
SELECT TOP 5
    coffee_name,
    SUM(quantity) AS total_coffees_sold
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_coffees_sold DESC;

--J. Bottom 5 Coffees by Quantity
SELECT TOP 5
    coffee_name,
    SUM(quantity) AS total_coffees_sold
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_coffees_sold ASC;
--K. Top 5 Coffees by Total Orders
SELECT TOP 5
    coffee_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_orders DESC;
