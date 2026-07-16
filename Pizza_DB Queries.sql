use Pizza_DB
-----Total Revenue
SELECT CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue
FROM pizza_sales;
-----Average Order Value (AOV)
SELECT CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS avg_order_value
FROM pizza_sales;
------Total Pizzas Sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;
-------Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;
-------Average Pizzas per Order
SELECT CAST(
    (SUM(quantity) * 1.0) / COUNT(DISTINCT order_id) 
    AS DECIMAL(10,2)
) AS avg_pizzas_per_order
FROM pizza_sales;
-------Daily Trend for Total Orders
-------  DATENAME ---> extracts the text name of that day
SELECT DATENAME(WEEKDAY, order_date) AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date), DATEPART(WEEKDAY, order_date)
ORDER BY DATEPART(WEEKDAY, order_date);
------ Monthly Trend for Orders
SELECT DATENAME(MONTH, order_date) AS month_name,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date), DATEPART(MONTH, order_date)
ORDER BY DATEPART(MONTH, order_date);
------- % of Sales by Pizza Category
SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(
           (SUM(total_price) * 100.0) / (SELECT SUM(total_price) FROM pizza_sales) 
           AS DECIMAL(10,2)
       ) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_category;
--------% of Sales by Pizza Size
SELECT pizza_size,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(
           (SUM(total_price) * 100.0) / (SELECT SUM(total_price) FROM pizza_sales) 
           AS DECIMAL(10,2)
       ) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;
------- #Total Pizzas Sold by Category  For each Month
SELECT
    MONTH(order_date) AS order_month,
    pizza_category, 
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY 
    MONTH(order_date), 
    pizza_category
ORDER BY 
    order_month ASC, 
    Total_Quantity_Sold DESC;

-------Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;
--------Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC;
-------Top 5 Pizzas by Quantity Sold
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

-------Bottom 5 Pizzas by Quantity Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

-------- Bottom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
-------- Bottom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC

--------Peak Order Hours
SELECT DATEPART(hour, order_time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS revenue
FROM pizza_sales
GROUP BY DATEPART(hour, order_time)
ORDER BY order_hour;


------Weekday vs. Weekend Performance
SELECT 
    CASE 
        WHEN DATENAME(dw, order_date) IN ('Saturday', 'Sunday') THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS day_type,
    COUNT(DISTINCT order_id) AS total_orders,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS revenue,
    CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS avg_order_value
FROM pizza_sales
GROUP BY 
    CASE 
        WHEN DATENAME(dw, order_date) IN ('Saturday', 'Sunday') THEN 'Weekend' 
        ELSE 'Weekday' 
    END;
---------Revenue Concentration / Pareto Analysis
-------------Finding Your "Hero" Products (The 80/20 Rule)
-------------it is common for 80% of revenue to come from just 20% of the products
WITH pizza_rev AS (
  SELECT pizza_name, SUM(total_price) AS revenue
  FROM pizza_sales
  GROUP BY pizza_name
)
SELECT pizza_name,
       CAST(revenue AS DECIMAL(10,2)) AS revenue,
       -- Calculates individual percentage of total revenue
       CAST((revenue / SUM(revenue) OVER()) * 100 AS DECIMAL(5,2)) AS pct_of_total_revenue
FROM pizza_rev
ORDER BY revenue DESC;

