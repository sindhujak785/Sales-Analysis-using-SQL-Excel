--Creating Table
DROP TABLE IF EXISTS pizza_sales;
CREATE TABLE pizza_sales
(
pizza_id INT,	
order_id INT,
pizza_name_id VARCHAR(50),	
quantity INT,
order_date DATE,
order_time TIME,
unit_price FLOAT,
total_price FLOAT,
pizza_size VARCHAR(10),
pizza_category VARCHAR(10),
pizza_ingredients VARCHAR(250),	
pizza_name VARCHAR(100)
);


--KPI Calculations:

--Total Revenue:
SELECT
   CAST(SUM(total_price) AS decimal (10,2)) AS total_revenue
FROM pizza_sales;


--Average Order Value
SELECT
  SUM(total_price)/COUNT(DISTINCT order_id) AS average_order_value 
FROM pizza_sales;


--Total Pizzas Sold
SELECT
  SUM(quantity)AS total_pizza_sales
FROM pizza_sales;


--Total Orders
SELECT
  COUNT(DISTINCT order_id)AS total_orders 
FROM pizza_sales;

--Average Pizzas Per Order
SELECT 
  CAST(
    SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) 
    AS DECIMAL(10,2)
  ) AS avg_pizza_sales
FROM pizza_sales;


--Sales Trends:

--Daily Trend for Total Orders
SELECT 
  to_char(order_date,'day' )AS order_day,
  COUNT(DISTINCT order_id)AS total_orders
FROM pizza_sales
GROUP BY 1;


--Hourly Trend for Orders
SELECT  
  EXTRACT(HOUR FROM order_time)AS order_hour,
   COUNT(DISTINCT order_id)AS total_orders
FROM pizza_sales
GROUP BY 1
ORDER BY 1;


--% of Sales by Pizza Category
SELECT  
  pizza_category,
  SUM(total_price)::numeric,
  ROUND(SUM(total_price)::numeric*100/(
                                 SELECT SUM(total_price)::numeric FROM pizza_sales WHERE to_char(order_date,'mm')='01'
								 ),2
					             )AS percentage_category
FROM pizza_sales
WHERE to_char(order_date,'mm')='01'
GROUP BY 1;


--% of Sales by Pizza Size
SELECT 
  pizza_size,
  ROUND(SUM(total_price)::NUMERIC, 0)::INTEGER,
  ROUND(SUM(total_price)::numeric*100/(
                        SELECT SUM(total_price)::numeric FROM pizza_sales WHERE to_char(order_date,'mm')='01'
						),2
						)AS percentage_size
FROM pizza_sales
WHERE to_char(order_date,'mm')='01'
GROUP BY 1
ORDER BY 1;



--Total Pizzas Sold by Pizza Category
SELECT pizza_category ,
SUM(quantity)as total_pizza_sold
FROM pizza_sales
GROUP BY 1;


--Best & Worst Sellers:

--Top 5 Best Selling Pizzas
SELECT pizza_name,
SUM(quantity)as total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC
LIMIT 5;

--Bottom 5 Worst Selling Pizzas
SELECT pizza_name,
SUM(quantity)as total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 
LIMIT 5;