-- Excetive Overview KPI's

select concat(round(sum(price + freight_value)/1000000,2),'M') as Estimated_item_revenue from item;
select concat(round(sum(payment_value)/1000000,2),'M') as Total_Revenue from payment;
select count(distinct customer_id) as Total_Customers from customer;
select count(distinct order_id) as Total_orders from orders;
select count(distinct product_id) as Total_Products from product;
select count(distinct seller_id) as Total_sellers from seller;
select round(avg(price),2) as Average_Order_Value from item;
with customer_orders as(
	select customer_id, count(order_id) as order_count
    from orders
    group by customer_id
)
select round(sum(
	case when order_count>1 then 1 else 0 end )*100/count(*),2) as `Repeat_customer%`,
    round(sum(case when order_count<2 then 1 else 0 end)*100/count(*),2) as `New Customer%`
from customer_orders;
select round(avg(review_score),2) as Average_Review_Score from review;
select round(sum(
	case when order_status = 'delivered' then 1 else 0 end)*100/count(*),2) as `On-Time_Delivery%` 
from orders;