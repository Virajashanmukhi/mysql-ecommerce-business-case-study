-- Monthly Revenue and Order Volume Trend 
select year(order_delivered_customer_date) as years,month(order_delivered_customer_date) as months,concat(round(sum(payment_value)/1000000,2),'M') as monthly_revenue,
count(distinct orders.order_id)as no_of_orders
from payment
join orders 
on payment.order_id = orders.order_id
group by years,months;

-- Monthly Orders, Item Count, and Total Sales Value (2018)
select count(distinct orders.order_id) as no_of_orders,count(order_item_id) as no_of_items,round(sum(price+freight_value),2) as total_price,month(orders.order_delivered_customer_date) as months
from item
join orders
on orders.order_id = item.order_id
where year(orders.order_delivered_customer_date) = 2018
group by months
order by no_of_orders desc;

-- Average Items per Order by Month (2018)
select count(t.order_id)as no_of_orders,avg(item_per_order) as avg_item_per_order,t.months
from (
	select item.order_id,count(item.order_item_id) as item_per_order,month(orders.order_delivered_customer_date) as months
    from item
    join orders
    on item.order_id = orders.order_id
    where year(order_delivered_customer_date) = 2018
    group by item.order_id,months
)t
group by t.months
order by avg_item_per_order desc;

-- Monthly Average Order Value (AOV) Analysis (2018)
select avg(payment_value) as aov,count(orders.order_id),month(order_delivered_customer_date) as months from payment
join orders
on orders.order_id = payment.order_id
where year(order_delivered_customer_date) =2018
group by months
order by aov desc;

-- Monthly Order Performance Analysis with Metric Rankings
with order_items as (
	select order_id, count(order_item_id) as item_count
    from item
    group by order_id
),
orders_payment as(
	select order_id, sum(payment_value) as order_value
    from payment
    group by order_id
),
monthly_data as(
	select month(order_delivered_customer_date)as months,
    o.order_id,i.item_count,p.order_value as payment_values
    from order_items i
    join orders o
    on o.order_id = i.order_id
    join orders_payment p
    on o.order_id = p.order_id
    where year(order_delivered_customer_date) =2018
),
monthly_metrics as (
	select months,
    count(order_id)as total_orders,
    sum(item_count) as total_items,
    avg(item_count) as avg_item_per_order,
    avg(payment_values) as aov,
    sum(payment_values) as total_revenue
    from monthly_data
    group by months
    )
select months,
rank()over(order by total_orders desc) as orders_rank,
rank()over(order by total_items desc) as items_rank,
rank()over(order by avg_item_per_order desc) as avg_items_rank,
rank()over(order by aov desc) as aov_rank,
rank()over(order by total_revenue desc) as revenue_rank
from monthly_metrics
order by months;

-- Monthly Order Distribution by Status (Percentage of Total Orders)
select month(order_delivered_customer_date) as months,count(order_id) as no_of_orders,
count(order_id)*100/(select count(order_id) from orders where year(order_delivered_customer_date) =2018) as `orders%`,
order_status
from orders
where year(order_delivered_customer_date) = 2018
group by order_status, months;

-- Monthly Order Status Breakdown with Percentage Share (2018)
select 
    month(order_delivered_customer_date) as months,
    order_status,
    count(order_id) AS no_of_orders,
    round(
        count(order_id) * 100.0 /
        sum(count(order_id)) OVER (partition by month(order_delivered_customer_date)),2) AS `orders%`
from orders
where year(order_delivered_customer_date) = 2018
group by month(order_delivered_customer_date),order_status
order by months,`orders%` desc;




