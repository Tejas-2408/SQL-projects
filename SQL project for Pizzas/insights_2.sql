-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(o.time) AS hours, COUNT(o.order_id) AS orders
FROM
    orders o
GROUP BY 1
ORDER BY 1;


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS distribution
FROM
    pizza_types
GROUP BY category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(orders), 0) AS avg_order
FROM
    (SELECT 
        o.date, SUM(quantity) AS orders
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 1) AS order_quantity;
    
    
-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pt.name, round(SUM(od.quantity*p.price),2) AS total_revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY 1
ORDER BY 2 DESC limit 3;
