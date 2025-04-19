SELECT * FROM public.retail_sales
ORDER BY transactions_id ASC LIMIT 10

select count(*) from retail_sales;

select * from retail_sales
where transactions_id is null;

select *from retail_sales
where sale_date is null;

select * from retail_sales
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
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

	 delete from retail_sales
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
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

----Data Exploration--
---How many sales we have?
select count(*) as total_sale from retail_sales;

--How many unique customers do we have?
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category from retail_sales;


--Data Analysis & Business key problems & Answers--

---q1) write a sql query to retrieve all columns for sales made on '2022-11-05'?--
select * from retail_sales
where sale_date = '2022-11-05';

--q2) Write a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 
    -- 4 in the month of nov-2022--
	
select * from retail_sales
where category='clothing'
AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND quantiy >=4;

--q3) write a sql query to calculate the total sales (total_sale) for each category
select * from retail_sales;

select category,sum(total_sale)as net_sales ,count(*) as total_orders 
from retail_sales
group by 1;

--q4) write a sql query to find the average age of customers who purchased items from the 'Beauty' category.--

select round(avg(age),2)as avg_age from retail_sales
where category='Beauty';

--q5) write a sql query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales 
where total_sale > 1000;

--q6) write a sql query to find the total number of transactions (transaction_id) made by each gender in each category.
  select category,gender,count(*) as total_trans
  from retail_sales
  group by 1,2
  order by 1;

--q7)write a sql query to calculate the average sale for each month .Find out best selling month in each year..
select * from 
(
       select 
          EXTRACT(YEAR FROM sale_date) as year,
          EXTRACT(MONTH FROM sale_date) as month,
          AVG(total_sale) as avg_sale,
          RANK() OVER(PARTITION BY  EXTRACT(YEAR FROM sale_date) order by  AVG(total_sale) desc)as rank
          from retail_sales
          group by 1,2
)as t1
where rank=1

--q8)write a sql query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale)as total_sales from retail_sales
group by 1 
order by 2 desc
limit 5;

--q9) write a sql query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) from retail_sales
group by 1

--q10) write a sql query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening>17)
with hourly_sale
as
(
select *,
    CASE
	    WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
from retail_sales	
)
select shift, count(*) as total_orders from hourly_sale
group by shift	 

---END OF PROJECT--


