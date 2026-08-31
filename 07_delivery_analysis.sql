-- Monthly Delivery count(2018)
select month(order_delivered_customer_date) as months,round(avg(datediff(order_delivered_customer_date,order_estimated_delivery_date)),2) as delay
from orders
where year(order_delivered_customer_date) = 2018
group by months;

-- Monthly Delivery Delay, Order Share, and Revenue Contribution (2018)
select month(order_delivered_customer_date) as months,
round(avg(datediff(order_delivered_customer_date,order_estimated_delivery_date)),2) as delay,
round((count(distinct o.order_id)/(select count(distinct order_id) from orders))*100,2) as no_of_orders,
round(((sum(price)/(select sum(price) from item))*100),2) as `revenue%`
from item o
join orders p 
on p.order_id = o.order_id
where year(order_delivered_customer_date) = 2018
group by months;

-- Monthly Top 5 Customer States by Revenue, Orders, and Customer % (2018)
select * from(
select month(o.order_delivered_customer_date) as months,customer_state,count(distinct o.order_id) as no_of_orders,
round(((count(distinct o.customer_id)/(select count(distinct customer_id) from orders))*100),2) as `customer%`,
round(((count(distinct i.order_id)/(select count(distinct order_id) from orders))*100),2) as `orders%`,
round(((sum(price+freight_value)/(select sum(price+freight_value) from item))*100),2) as `revenue%`,
row_number() over (partition by month(o.order_delivered_customer_date) 
           order by sum(price + freight_value) desc) as rn
from customer c
join orders o
on o.customer_id = c.customer_id
join item i
on i.order_id  = o.order_id
where year(order_delivered_customer_date)=2018
group by customer_state,months)t
where rn<=5
order by months,`revenue%` desc;

-- Monthly Customer Trends with Delivery Delay and Next-Month Comparison (2018)
with month_lead as (
  select month(order_purchase_timestamp) as months,
    avg(datediff(order_delivered_customer_date, order_estimated_delivery_date)) as avg_delay,
    count(distinct customer_id) as customers
  from orders
  where year(order_purchase_timestamp) =2018
  group by months
)
select months,avg_delay,customers,
  lead(customers) over (order by months) as next_month_customers
from month_lead;

-- State-wise Delivery Delay, Order Share, and Revenue Contribution (2018)
select c.customer_state,
round(avg(datediff(order_delivered_customer_date,order_estimated_delivery_date)),2) as delay,
round((count(distinct o.order_id)/(select count(distinct order_id) from orders))*100,2) as no_of_orders,
round(((sum(price)/(select sum(price) from item))*100),2) as `revenue%`
from item i
join orders o 
on i.order_id = o.order_id
join customer c
on c.customer_id = o.customer_id
where year(order_delivered_customer_date) = 2018
group by customer_state
order by delay desc;