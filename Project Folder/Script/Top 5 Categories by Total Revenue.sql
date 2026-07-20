select
main_category,
round(sum(discounted_price), 2) as total_revenue,
count(product_id) as total_products
from fourth-groove-499909-u2.amazon.sales
group by main_category
order by total_revenue desc
limit 5;