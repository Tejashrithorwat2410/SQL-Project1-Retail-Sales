
--SQL Retail Sales Database

--Data Cleaning

create database SQL_Project1

select top 10 * FROM [dbo].[Retail Sales]

select count(*) from [dbo].[Retail Sales]


-- Check NUll Values
select * 
from [dbo].[Retail Sales]
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or 
	total_sale is null


--Delete those records who have null values

delete 
from [dbo].[Retail Sales]
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or 
	total_sale is null
	

--Data Exploration

--1. How many sales we have?
select count(total_sale) from [dbo].[Retail Sales]

--2. How many Customers we have?
select count(customer_id) from [dbo].[Retail Sales]

--there are some duplicate customers present in data so we have unique value 
select count(distinct customer_id) as [total customer] from [dbo].[Retail Sales]

--3. Hoe many unique categories we have?
select count(distinct category ) as [NO of Categories] from [dbo].[Retail Sales]

--Data Analysis / Business Problems 

-- Q1. Write a SQL query to retrive all columns for sales  made on '2022-11-05'?
select * from [dbo].[Retail Sales] where sale_date = '2022-11-05'

--Q2. Write a SQL Query to retrive all transactions where the category is 'clothing' and 
--the quantity sold more than equal to 4 in the month of nov-2022

select * 
from [dbo].[Retail Sales]
where
	category = 'Clothing'
	AND
	sale_date between '2022-11-01' and '2022-11-30'
	and 
	quantiy >=4
order by sale_date 

	--OR--

select *
from [dbo].[Retail Sales] 
where 
	category = 'Clothing' 
	and 
	quantiy >= 4 
	and 
	YEAR(sale_date) = '2022'
	and 
	MONTH(sale_date) = '11'

--Q3. Write SQL query to calculate the Total_Sale from each category
select sum(total_sale) as [Total Sale], Category, COUNT(*) as Total_orders
from [dbo].[Retail Sales] 
group by category


--Q4. write SQL query to find the average age of customers who purchased items from the 'Beauty'  category
select AVG(age) as avg_age
from [dbo].[Retail Sales] 
where category = 'Beauty'

--Q5. Write SQL query to find all transactions where the total_sale is greater than 1000
select *
from [dbo].[Retail Sales]
where total_sale > 1000

--Q6. write	SQL query to find total number of transaction made by each gender in each category
select category,gender , COUNT(*) as Total_Transaction
from [dbo].[Retail Sales]
group by category, gender


--Q7. Write SQL query to find average sale for each month, find out best selling in each year

--Average sale for each  month
select 
	YEAR(sale_date) as sale_year,
	MONTH(sale_date) as sale_month,
	AVG(total_sale) as avg_sale
	--RANK() over(partition by YEAR(sale_date) order by avg(total_sale) desc) as Rank
from [dbo].[Retail Sales]
group by YEAR(sale_date), MONTH(sale_date)
order by YEAR(sale_date), MONTH(sale_date)

--Best Selling in each year
select 
	sale_year,
	sale_month,
	avg_sale
from
(
select 
	YEAR(sale_date) as sale_year,
	MONTH(sale_date) as sale_month,
	AVG(total_sale) as avg_sale,
	RANK() over(partition by YEAR(sale_date) order by avg(total_sale) desc) as Rank
from [dbo].[Retail Sales]
group by YEAR(sale_date), MONTH(sale_date)

) as te
where Rank =1


--Q8 write a SQL Query to find top 5 customers based on the highest total sale
select 
	top 5 customer_id , 
	sum(total_sale)  as total_sale
from 
	[dbo].[Retail Sales]
group by customer_id
order by total_sale desc


--Q9. Write a SQL Query to find the number of Unique customers who purches items from each category
select 
	category,
	count(distinct customer_id) as Unique_cust	
from [dbo].[Retail Sales]
group by category
	
--Q10. Write a SQL Query to create each shift and number of orders(ex. morning<=12, afternoon between 12 & 17  and evening greater than 17)

with hourly_sale as (
select *,
 case
	when DATEPART(hour,sale_time) < 12 then 'Morning'
	when DATEPART(hour,sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
 END as Shift
from [dbo].[Retail Sales]
)

select
	shift ,
	COUNT(*) as total_orders
from hourly_sale
group by shift


--select * from [dbo].[Retail Sales]
--select DATEPART(hour, CURRENT_TIMESTAMP)