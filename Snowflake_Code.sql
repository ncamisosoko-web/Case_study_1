-displaying the whole database--
select*
from sales.retial.coffe_shop;



--example of null function--
SELECT product_id, product_category
from sales.retial.coffe_shop
WHERE product_category is not  null;
--calculating the revenue--
select TRANSACTION_ID,
Transaction_qty * unit_price as Revenue
from sales.retial.coffe_shop;

--counting the number of transactions--
SELECT count(transaction_id) as Number_of_Transaction
from sales.retial.coffe_shop;

---Counting the number of shops--
SELECT count(store_id) as number_of_shops
from sales.retial.coffe_shop;

--getting the number of different store--
select distinct store_id
from sales.retial.coffe_shop;

--Counting revenue by shops--
select STORE_LOCATION,
sum(transaction_qty*unit_price) as Revenue
from sales.retial.coffe_shop
group by STORE_LOCATION;

--what time does the shop open--
select min(TRANSACTION_TIME) as openning_time
from sales.retial.coffe_shop;

-- what time does the store close--
select max(TRANSACTION_TIME) as openning_time
from sales.retial.coffe_shop;

--what to know which store in Astoria makes more revenue--
select PRODUCT_CATEGORY,
 sum(Transaction_qty * unit_price) as Revenue,
  transaction_date,
  store_location,
  dayofmonth(transaction_date) as day_of_month,
   monthname(transaction_date) as month_name,
   dayname(transaction_date) as day_name,
   CASE
      when day_name  IN ('Sat','Sun') then  'weekend'
      else 'weekday'
      END AS day_of_week_classification,
  transaction_time,
CASE
    WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN ' 01. Morning'
    WHEN transaction_time BETWEEN '02:00:00' AND '15:59:59' THEN '02. Afternoon'
    WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '03. Evenning'
    WHEN transaction_time >= '20:00:00'  THEN '04. Night'
END as time_bucket
 FROM sales.retial.coffe_shop
 WHERE transaction_date>'2023-05-01'
 GROUP by ALL
ORDER BY revenue DESC;


 ---Using the date functions to get the month,day and year name--

select transaction_date,
   YEAR(transaction_date) as year,
   MONTH(transaction_date) as month,
   dayofmonth(transaction_date) as day_of_month,
   monthname(transaction_date) as month_name,
   dayname(transaction_date) as day_name,
   sum(transaction_qty*unit_price) as revenue,
   store_location,
   CASE
      when day_name  IN ('Sat','Sun') then  'weekend'
      else 'weekday'
      END AS day_of_week_classification,
   
from sales.retial.coffe_shop
GROUP BY ALL;


