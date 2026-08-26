
-- A. KPI’s (Key Performance Indicators)


-- 1. Total Revenue: What is the total revenue generated from pizza sales?
SELECT ROUND(SUM(total_price)::numeric, 2) AS Total_Revenue 
FROM pizza_sales;

-- 2. Average Order Value: What is the average amount spent per order?
SELECT ROUND((SUM(total_price) / COUNT(DISTINCT order_id))::numeric, 2) AS Avg_order_Value 
FROM pizza_sales;

-- 3. Total Pizzas Sold: What is the total number of pizzas sold?
SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales;

-- 4. Total Orders: What is the total number of orders placed?
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- 5. Average Pizzas Per Order: On average, how many pizzas are sold per order?
SELECT ROUND((SUM(quantity)::numeric / COUNT(DISTINCT order_id)), 2) AS Avg_Pizzas_per_order 
FROM pizza_sales;



-- B & C. Trend Analysis


-- 6. Daily Trend for Total Orders: Which day of the week has the highest number of orders?
SELECT TO_CHAR(order_date, 'FMDay') AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'FMDay')
ORDER BY total_orders DESC;

-- 7. Monthly Trend for Orders: Which month has the highest number of orders?
SELECT TO_CHAR(order_date, 'FMMonth') AS Month_Name, 
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'FMMonth')
ORDER BY Total_Orders DESC;


-- D & E. Percentage Sales Breakdown


-- 8. % of Sales by Pizza Category: Which category contributes the highest percentage of revenue?
SELECT pizza_category, 
       ROUND(SUM(total_price)::numeric, 2) AS total_revenue,
       ROUND((SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales))::numeric, 2) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- 9. % of Sales by Pizza Size: Which size contributes the highest percentage of revenue?
SELECT pizza_size, 
       ROUND(SUM(total_price)::numeric, 2) AS total_revenue,
       ROUND((SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales))::numeric, 2) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- F. Category Analysis (With Filter)


-- 10. Total Pizzas Sold by Pizza Category (Specifically for February)
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- G - L. Top 5 & Bottom 5 Analysis


-- 11. Top 5 Pizzas by Revenue
SELECT pizza_name, ROUND(SUM(total_price)::numeric, 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- 12. Bottom 5 Pizzas by Revenue
SELECT pizza_name, ROUND(SUM(total_price)::numeric, 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

-- 13. Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- 14. Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

-- 15. Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

-- 16. Bottom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

