select t4.product_category_name 
from tb_order_items t2 inner join tb_products t4 on t2.product_id=t4.product_id
group by t4.product_category_name 
order by count(1) desc
LIMIT 50;
