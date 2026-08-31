select *  from customer;

-- Top 10 Customers by orders and revenue
with customer_rank as (
	select customer_id, count(distinct i.order_id) as no_of_orders,
    sum(price) as revenue
    from orders o
    join item i
    on o.order_id = i.order_id
    group by customer_id
)
select t.customer_id from(
select customer_id,no_of_orders,revenue,rank() over(order by no_of_orders desc,revenue desc)as rn
from customer_rank
group by customer_id)t
where rn<11;

-- Monthly customers
select month(order_delivered_customer_date) as months,count(distinct customer_id) as no_of_customer
from orders
where year(order_delivered_customer_date) = 2018
group by months;

-- which customer state has more customers
select customer_state, count(customer_id) as no_of_customer
from customer
group by customer_state
order by no_of_customer desc;

-- Number of Orders by Customer State (Ranked by Order Volume)
select customer_state, count(distinct order_id) as no_of_orders
from customer c
join orders o
on c.customer_id = o.customer_id
group by customer_state
order by no_of_orders desc;

-- customer state wise revenue%
select customer_state, round(sum(price),2) as customer_revenue, 
round((sum(price)/(select sum(price) from item))*100,2) as `revnue%`
from customer c
join orders o
on o.customer_id = c.customer_id
join item i
on o.order_id = i.order_id
group by customer_state
order by customer_revenue desc;


-- Monthly New vs Repeat Customer Distribution
with first_orders as(
	select customer_id ,
    min(order_purchase_timestamp) as first_order_date
    from orders
    group by customer_id
),
customer_type as(
	select distinct o.customer_id,
    month(o.order_purchase_timestamp) as months,
    case 
    when month(o.order_purchase_timestamp) = month(f.first_order_date)
    then 'NEW customer'
    else 'Repeated Customer'
    end as customer_type
    from orders o
    join first_orders f
    on o.customer_id = f.customer_id
    where month(o.order_purchase_timestamp) in(1,2,3,4,5,6,7,8,9,10,11,12)
)
select months ,customer_type,count(distinct customer_id) as no_of_customer
from customer_type
group by months, customer_type
order by months, customer_type;
