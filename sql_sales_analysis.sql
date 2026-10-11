show databases;

USE `sales analysis`;

select * from cleaned_data
limit 5;

alter table cleaned_data
rename column ï»¿segment to segment;

select * from cleaned_data
limit 1;

select sum(total_price) as amount, sum(profit) as total_profit from cleaned_data;

select product, round(sum(total_price),2) as sales, round(sum(profit),2) as total_profit
from cleaned_data
group by product
order by sales desc
limit 5;

select country, round(sum(total_price),2) as sales, round(sum(profit),2) as total_profit
from cleaned_data
group by country
order by sales desc
limit 5;

select segment, round(sum(total_price),2) as sales, round(sum(profit),2) as total_profit
from cleaned_data
group by segment
order by sales and total_profit desc
limit 5;

select `year`, month_name, round(sum(total_price),2) as total_sales, round(sum(profit),2) as total_profit
from cleaned_data
group by `year`, month_name
order by `year`, month_name;

select discount_band, count(*) as total_records, round(sum(discounts),2) as total_discount, round(sum(total_price),2) as total_sales, round(sum(profit),2) as total_profit
from cleaned_data
group by discount_band
order by  total_discount desc;

SELECT product, ROUND(SUM(total_price), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit,
ROUND(SUM(profit) / NULLIF(SUM(total_price), 0) * 100,2) AS profit_margin_percentage
FROM cleaned_data
GROUP BY product
ORDER BY profit_margin_percentage DESC;

SELECT product, ROUND(SUM(total_price), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_data
GROUP BY product
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

select product, sum(total_price) as sales, sum(profit) as total_profit from cleaned_data
group by product
having total_profit<0;

select product, sum(profit) as total_profit from cleaned_data
where profit<0
group by product
having total_profit<0
order by total_profit desc;

SELECT year, ROUND(SUM(total_price), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_data
GROUP BY `year`
ORDER BY total_sales DESC;

SELECT ROW_NUMBER() OVER (ORDER BY SUM(units_sold) DESC) AS row_num, product, SUM(units_sold) AS total_units_sold, ROUND(SUM(total_price), 2) AS total_sales
FROM cleaned_data
GROUP BY product
ORDER BY total_units_sold DESC;

SELECT ROUND(SUM(total_price), 2) AS total_sales, ROUND(SUM(gross_sales), 2) AS total_gross_sales,
ROUND(SUM(discounts), 2) AS total_discounts, ROUND(SUM(cost_of_goods_sold), 2) AS total_cost,
ROUND(SUM(profit), 2) AS total_profit, ROUND(SUM(profit) / NULLIF(SUM(total_price), 0) * 100, 2) AS profit_margin_percentage
FROM cleaned_data;