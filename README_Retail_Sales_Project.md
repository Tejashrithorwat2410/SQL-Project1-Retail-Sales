
# 📊 Retail Sales Data Analysis (SQL Project)

This project demonstrates end-to-end data cleaning, exploration, and analysis using **Microsoft SQL Server** on a retail sales dataset. The goal is to derive meaningful business insights that can help optimize inventory, understand customer behavior, and improve marketing strategies.

---

## 📁 Database & Table Used

- **Database:** `SQL_Project1`
- **Table:** `[dbo].[Retail Sales]`

---

## 🧹 1. Data Cleaning

### ✅ Check Sample Data
```sql
SELECT TOP 10 * FROM [dbo].[Retail Sales];
```

### ✅ Count Records
```sql
SELECT COUNT(*) FROM [dbo].[Retail Sales];
```

### ✅ Null Values Check
```sql
SELECT * FROM [dbo].[Retail Sales]
WHERE
    transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR
    customer_id IS NULL OR gender IS NULL OR category IS NULL OR
    quantiy IS NULL OR cogs IS NULL OR total_sale IS NULL;
```

### ✅ Delete Null Records
```sql
DELETE FROM [dbo].[Retail Sales]
WHERE
    transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR
    customer_id IS NULL OR gender IS NULL OR category IS NULL OR
    quantiy IS NULL OR cogs IS NULL OR total_sale IS NULL;
```

---

## 🔍 2. Data Exploration

### 🛒 Total Sales Count
```sql
SELECT COUNT(total_sale) FROM [dbo].[Retail Sales];
```

### 👥 Total vs Unique Customers
```sql
SELECT COUNT(customer_id) FROM [dbo].[Retail Sales];
SELECT COUNT(DISTINCT customer_id) AS [total customer] FROM [dbo].[Retail Sales];
```

### 🏷️ Unique Categories
```sql
SELECT COUNT(DISTINCT category) AS [NO of Categories] FROM [dbo].[Retail Sales];
```

---

## 📈 3. Business Questions & Analysis

### Q1. Sales on Specific Date
```sql
SELECT * FROM [dbo].[Retail Sales] WHERE sale_date = '2022-11-05';
```

### Q2. Clothing Sales with Quantity ≥ 4 in Nov-2022
```sql
SELECT *
FROM [dbo].[Retail Sales]
WHERE category = 'Clothing' AND quantiy >= 4 AND
      YEAR(sale_date) = '2022' AND MONTH(sale_date) = '11';
```

### Q3. Total Sales by Category
```sql
SELECT SUM(total_sale) AS [Total Sale], Category, COUNT(*) AS Total_orders
FROM [dbo].[Retail Sales]
GROUP BY category;
```

### Q4. Average Age of 'Beauty' Category Customers
```sql
SELECT AVG(age) AS avg_age
FROM [dbo].[Retail Sales]
WHERE category = 'Beauty';
```

### Q5. Transactions with Sales > ₹1000
```sql
SELECT *
FROM [dbo].[Retail Sales]
WHERE total_sale > 1000;
```

### Q6. Transactions by Gender and Category
```sql
SELECT category, gender, COUNT(*) AS Total_Transaction
FROM [dbo].[Retail Sales]
GROUP BY category, gender;
```

---

## 📅 Q7. Monthly Average Sales & Best Month per Year

### ➕ Monthly Average Sales
```sql
SELECT 
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS avg_sale
FROM [dbo].[Retail Sales]
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR(sale_date), MONTH(sale_date);
```

### 🏆 Best Selling Month per Year (Based on Avg Sale)
```sql
SELECT sale_year, sale_month, avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS Rank
    FROM [dbo].[Retail Sales]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_sales
WHERE Rank = 1;
```

---

## 🥇 Q8. Top 5 Customers by Total Sales
```sql
SELECT TOP 5 customer_id, SUM(total_sale) AS total_sale
FROM [dbo].[Retail Sales]
GROUP BY customer_id
ORDER BY total_sale DESC;
```

---

## 🧍 Q9. Unique Customers per Category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS Unique_cust
FROM [dbo].[Retail Sales]
GROUP BY category;
```

---

## 🕒 Q10. Shift-wise Transaction Count

| Shift      | Time Range          |
|------------|---------------------|
| Morning    | Before 12 PM        |
| Afternoon  | 12 PM to 5 PM       |
| Evening    | After 5 PM          |

```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN DATEPART(hour, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(hour, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS Shift
    FROM [dbo].[Retail Sales]
)

SELECT Shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY Shift;
```

---

## ✅ Summary

This SQL project covered:
- Data cleaning to ensure quality
- Exploratory analysis for understanding trends
- Solving key business problems with SQL queries
- Extracting customer behavior, peak sale periods, and sales by category

---

## 🛠️ Tools Used
- **SQL Server Management Studio (SSMS)**
- **Retail Sales Dataset (custom table)**
