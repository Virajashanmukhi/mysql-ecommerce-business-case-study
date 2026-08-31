-- review count by month
select month(review_creation_date) as months, count(review_id) 
from review
where year(review_creation_date) = 2018
group by months;

-- months vs avg_review_score
select month(review_creation_date) as months,avg(review_score) as avg_review_score
from review
where year(review_creation_date) = 2018
group by months
order by avg_review_score desc;

-- month wise rating score share
select month(review_creation_date) as months,
(sum(case when review_score = 5 then 1 else 0 end)*100)/count(*) as `5`,
(sum(case when review_score = 4 then 1 else 0 end)*100)/count(*) as `4`,
(sum(case when review_score = 3 then 1 else 0 end)*100)/count(*) as `3`,
(sum(case when review_score = 2 then 1 else 0 end)*100)/count(*) as `2`,
(sum(case when review_score = 1 then 1 else 0 end)*100)/count(*)as `1`
from review
group by months