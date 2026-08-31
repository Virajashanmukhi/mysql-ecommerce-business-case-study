
-- Product Count by Category
select product_category_name ,count(product_id) as no_of_products
from product
group by product_category_name
order by no_of_products desc;

-- Top Product Categories by Sales Volume and Orders
select p.product_category_name ,count(p.product_id)as no_of_products,count(i.order_id) as no_of_orders,
count(distinct order_id) as unique_norders
from item i
join product p
on i.product_id = p.product_id
group by product_category_name
order by no_of_orders desc;

-- Product-wise Revenue Contribution (%)
select p.product_category_name,p.product_id, round(sum(price),2) as revenue, 
round((sum(price)/(select sum(price) from item))*100,2) as `revenue%`
from product p
join item i
on i.product_id = p.product_id
group by product_category_name,p.product_id
order by `revenue%` desc;

-- Category-wise Revenue Contribution (%)
select p.product_category_name, round(sum(i.price),2) as revenue, 
round((sum(i.price)/(select sum(price) from item))*100,2) as `revenue%`
from product p
join item i
on i.product_id = p.product_id
group by product_category_name
order by `revenue%` desc;

-- Top Products by Total Price (Revenue per Product
select p.product_category_name,i.product_id,sum(price) as price
from item i
join product p
on i.product_id = p.product_id
group by product_id
order by price desc;

-- Monthly Category-wise Revenue Contribution (%) (2018)
select month(order_delivered_customer_date) as months,p.product_category_name, round(sum(i.price),2) as revenue, 
round((sum(i.price)/(select sum(price) from item))*100,2) as `revenue%`
from product p
join item i
on i.product_id = p.product_id
join orders o
on o.order_id = i.order_id
where year(order_delivered_customer_date) = 2018
group by months,product_category_name
order by `revenue%`desc ;