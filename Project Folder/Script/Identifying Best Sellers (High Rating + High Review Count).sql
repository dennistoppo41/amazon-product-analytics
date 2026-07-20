select
product_name,
main_category,
discounted_price,
rating,
rating_count
from fourth-groove-499909-u2.amazon.sales
where rating >= 4.3 and rating_count > 10000
order by rating_count desc;