-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.category, 
    round(SUM(od.quantity*p.price)*100/(
    select sum(ods.quantity*ps.price) from order_details ods 
    join pizzas ps on ps.pizza_id = ods.pizza_id),2) AS revenue_percentage
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY 1
ORDER BY 2;


-- Analyze the cumulative revenue generated over time.
select date,sum(revenue) over(order by date) as cumm_revenue from
(select o.date,round(sum(od.quantity*p.price),2) as revenue
from orders o
join order_details od on od.order_id = o.order_id
join pizzas p on p.pizza_id = od.pizza_id
group by 1) as total_revenue;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.


with cte as(SELECT 
    pt.category, pt.name, SUM(od.quantity * p.price) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY 1 , 2)

select * from
(select category,name,revenue,rank() over(partition by category order by revenue) as rnk
from cte) as b
where rnk<=3;