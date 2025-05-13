# Pizza-Sales-Analysis-using-SQL-Excel

## Project Overview

This project analyzes pizza sales data using SQL and Excel to derive key business insights. It includes data extraction, transformation, and visualization to identify revenue trends, best-selling items, and customer ordering patterns.

### Dashboard Overview

 The dashboard provides insights into total revenue, order trends, best & worst sellers, and category-wise sales.

 -Key highlights include:

 -Total Revenue: $69,793

 -Total Pizzas Sold: 4,232

 -Average Order Value: $38

 -Peak Order Time: 12 PM - 1 PM & 4 PM - 8 PM

 -Best-Selling Pizza: The Pepperoni Pizza

 -Worst-Selling Pizza: The Brie Carre Pizza


![Dashboard](https://github.com/sindhujak785/Sales-Analysis-using-SQL-Excel/blob/main/pizza%20sales%20dashboard.png)

## Key Insights from Data Analysis

### Sales & Customer Trends:

 Orders peak on Friday & Saturday evenings.

 Large-sized pizzas contribute to the highest revenue.

### Best & Worst Performers:

 The Pepperoni Pizza has the highest sales.

 The Brie Carre Pizza is the least popular.


### Revenue & Order Patterns:

 Classic category pizzas generate maximum revenue.

 The highest number of orders occur between 12 PM - 1 PM and 4 PM - 8 PM.

## Technologies Used

SQL (Data extraction & transformation)

Excel (Dashboard creation & visualization)

Power Query (Data cleaning & processing)


## SQL Queries & Analysis


### KPI Calculations:
 

### Total Revenue:

```sql
SELECT
   CAST(SUM(total_price) AS decimal (10,2)) AS total_revenue
FROM pizza_sales;
```

### Average Order Value

```sql
SELECT
  SUM(total_price)/COUNT(DISTINCT order_id) AS average_order_value 
FROM pizza_sales;
```

### Total Pizzas Sold
```sql
SELECT
  SUM(quantity)AS total_pizza_sales
FROM pizza_sales;
```


### Sales Trends:

### Daily Trend for Total Orders
```sql

SELECT 
  to_char(order_date,'day' )AS order_day,
  COUNT(DISTINCT order_id)AS total_orders
FROM pizza_sales
GROUP BY 1;
```



### Hourly Trend for Orders
```sql

SELECT  
  EXTRACT(HOUR FROM order_time)AS order_hour,
   COUNT(DISTINCT order_id)AS total_orders
FROM pizza_sales
GROUP BY 1
ORDER BY 1;
```


### % of Sales by Pizza Category
```sql
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
```



### Best & Worst Sellers:

### Top 5 Best Selling Pizzas
```sql
SELECT pizza_name,
SUM(quantity)as total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC
LIMIT 5;
```
### Bottom 5 Worst Selling Pizzas
```sql
SELECT pizza_name,
SUM(quantity)as total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 
LIMIT 5;
```

Click here to view the full SQL query file (https://github.com/sindhujak785/Sales-Analysis-using-SQL-Excel/blob/main/SQL%20queries.sql)

## Conclusion

This project provides valuable insights into pizza sales trends using Excel and SQL. The interactive dashboard and queries help in understanding revenue, order trends, and best-selling pizzas.












  









