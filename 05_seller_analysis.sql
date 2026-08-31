-- State-wise Seller Distribution (Number of Sellers by State)
select seller_state , count(seller_id) as no_of_seller
from seller
group by seller_state
order by no_of_seller desc;

-- Top Sellers by Number of Orders
select seller_id , count(distinct order_id) as no_of_orders
from item
group by seller_id
order by no_of_orders desc;

-- Top 10 sellers by orders and revenue
with seller_rank as(
	select seller_id ,count(distinct i.order_id) as no_of_orders,
    sum(price) as revenue
    from item i
    join orders o
    on o.order_id = i.order_id
    group by seller_id
)
select t.seller_id from(
	select seller_id,no_of_orders,revenue,
    rank()over(order by no_of_orders desc, revenue desc) as rn
    from seller_rank
)t
where rn<11;

-- State-wise Item Volume and Unique Order Count by Sellers
select s.seller_state, count(i.order_id) as no_of_items, count(distinct i.order_id) as unique_orders
from item i
join seller s 
on s.seller_id = i.seller_id
group by seller_state
order by unique_orders desc;

-- State-wise Seller Revenue and Percentage Contribution 
select seller_state, round(sum(price),2) as seller_revenue, 
round((sum(price)/(select sum(price) from item))*100,2) as `revnue%`
from seller s
join item i
on s.seller_id = i.seller_id
group by seller_state
order by seller_revenue desc;

