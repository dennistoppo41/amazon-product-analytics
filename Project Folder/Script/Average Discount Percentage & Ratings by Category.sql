select
main_category,
round(avg(rating), 2) as avg_rating,
round(avg((discount_amount / actual_price) * 100), 2) as avg_discount_pct
from fourth-groove-499909-u2.amazon.sales
group by main_category
having count(product_id) > 10
order by avg_rating DESC;