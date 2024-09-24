-- Retrieve the total number of orders placed.
select count(*) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(p.price * od.quantity), 2) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id;

-- Identify the highest-priced pizza.
select * from pizzas order by price desc limit 1;

-- Identify the most common pizza size ordered.
SELECT 
    p.size, COUNT(od.order_details_id) AS count
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY 2 DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name, SUM(od.quantity) AS total_pizzas
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY 2 DESC
LIMIT 5;

