drop table if exists zepto;
create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC (8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--data exploration

--count of rows
SELECT COUNT (*) FROM zepto;

--sample data
SELECT * FROM zepto
LIMIT 10;

--null values
SELECT * FROM zepto
where name is null
or
category is  null
or
mrp is null
or
discountPercent is null
or
discountedsellingprice is null
or 
weightInGms is null
or
availableQuantity is null
or
outOfStock is null
or
quantity is null;


--different product categories
SELECT DISTINCT category
from zepto
order by category;

---product in stock vs out of stock
select outOfstock, COUNT(sku_id)
from zepto
group by outOfstock;

--product names present multiple times
select name, count(sku_id) as "Number of SKUS"
from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc;


--data cleaning

--products with price = 0

SELECT * from zepto
where mrp = 0 or discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT mrp, discountedSellingPrice from zepto

--Q1 . Find the top 10 best - value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
From zepto
order by discountPercent DESC
LIMIT 10;

--Q2 what are the product with high MRP but out of stock

select distinct name, mrp
from zepto 
where outofstock = TRUE and mrp > 300
order by mrp DESC;

--Q3. Calculated Estimated  Revenue for each category
SELECT category ,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
from zepto
group by category
order by total_revenue;


--Q4. Find all products where MRP is greater than 500 and discount is less than 10%.
select distinct name, mrp, discountpercent
from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc , discountPercent desc;

--Q5. Identify the top 5 categories offering the highest average discount percentage.

select category,
ROUND(AVG(discountPercent),2) As avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

--Q6. Find the price per gram for products above 100g and sort by best value.

select distinct name, weightInGms, discountedSellingPrice,
round(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto
where weightinGms >= 100
order by price_per_gram;

--Q7 Group the products into categories like Low, Medium, Bulk.
select distinct name, weightInGms,
Case when weightInGms < 1000 Then 'LOW'
     when weightInGms < 5000 then 'MEDIUM'
	 else 'BULK'
	 end as weight_category
from zepto;

--Q8. What is the Total inventory weight per category
select category,
sum (weightInGms * availableQuantity ) as total_weight
from zepto
group by category
order by total_weight;



