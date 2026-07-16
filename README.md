# 🍕 Pizza Sales Data Analysis (E-commerce Data Analysis - Group 4)

A data analysis project exploring pizza sales performance using SQL Server (T-SQL), Excel, and Power BI. The project uncovers revenue trends, customer ordering behavior, and top/bottom performing products to support data-driven business decisions.

## 📌 Project Overview

This project analyzes a pizza sales dataset (Pizza_DB) to answer key business questions such as:


How much total revenue and how many orders were generated?
What are the busiest days, months, and hours for orders?
Which pizzas are the best and worst performers?
How does weekday vs. weekend performance compare?
Which products drive the majority of revenue (Pareto / 80-20 analysis)?


The workflow covers the full pipeline: data cleaning → SQL analysis → Power BI dashboard visualization.

🛠️ Tools & Technologies


SQL Server / T-SQL — data querying, aggregation, and KPI calculations
Microsoft Excel — data cleaning and preliminary exploration
Power BI — interactive dashboard and data visualization


## 📊 Key Metrics (KPIs)


Total Revenue
Average Order Value (AOV)
Total Pizzas Sold
Total Orders
Average Pizzas per Order


### 🔍 Analysis Performed

AnalysisDescriptionDaily & Monthly TrendsOrder volume by day of week and by monthSales by Category% of revenue by pizza category (Classic, Veggie, etc.)Sales by Size% of revenue by pizza size (S, M, L, XL)Category Sales by MonthQuantity sold per category, broken down monthlyTop/Bottom 5 PizzasRanked by revenue, quantity sold, and total ordersPeak Order HoursOrder volume and revenue by hour of dayWeekday vs. WeekendOrders, revenue, and AOV comparisonPareto (80/20) AnalysisCumulative revenue contribution per pizza to identify "hero" products

### 📈 Power BI Dashboard

The Power BI dashboard visualizes the KPIs and trends above for quick, interactive exploration.


<img width="2360" height="1377" alt="image" src="https://github.com/user-attachments/assets/b061bb3d-c6c5-4c44-923d-64e58663472e" />




 ### 🗃️ Data Analysis

 Below is a sample SQL query used in this project to calculate the % of Sales by Pizza Category:

```sql
SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(
           (SUM(total_price) * 100.0) / (SELECT SUM(total_price) FROM pizza_sales) 
           AS DECIMAL(10,2)
       ) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_category;
```
'''

This query calculates each pizza category's total revenue and its percentage contribution to overall sales, helping identify which categories drive the most revenue.

🚀 How to Use


1.Clone the repository:


bash   git clone https://github.com/Mohamedibrahim705-dev/E-commerce-data-analysis-group4.git


2.Restore the Pizza_DB dataset into SQL Server.

3.Run the queries in the SQL file to reproduce the KPIs and analysis tables.

4.Open the .pbix file in Power BI Desktop to explore the interactive dashboard.


### 💡 Key Insights (Results & Findings)

- Steady demand — 21K+ orders and $817K+ in revenue, averaging ~2 pizzas per order.
- Friday peak — orders build through the week, peaking before the weekend.
- Mild seasonality — slight July high and February low, otherwise stable.
- Balanced categories — no single category dominates; demand is spread evenly.
- Large size wins — nearly half of revenue comes from Large pizzas, showing clear size preference.
- Thai Chicken Pizza leads revenue ($43,434), just ahead of other chicken varieties.
- Brie Carre is the weakest pizza — bottom in revenue, quantity, and orders.
- Classic Deluxe is most popular, topping both quantity sold and total orders.
- Revenue and volume leaders differ — pricing, not just popularity, drives top revenue.
- A few specialty pizzas underperform consistently (Brie Carre, Mediterranean, Spinach Supreme).
- Lunch is the busiest time — orders peak around 12–1 PM (2,520 and 2,455 orders), far above early morning hours.



### 👥 Team Members

1-Mohamed Ibrahim Abdelaziz - linkedin.com/in/mohamed-ibrahim55

2-Ehab El-Siad Mohamed - https://www.linkedin.com/in/ehab-elsayed-38221432b

3-Mohamed Samy Eid  

4-Mamdouh Issa Al Hammadi Issa Mohammed 

### 📚 References
-SQL for Businesses 

-[Kaggle](https://kaggle.com)

### 📄 License

This project is for educational purposes as part of a group data analysis assignment.
