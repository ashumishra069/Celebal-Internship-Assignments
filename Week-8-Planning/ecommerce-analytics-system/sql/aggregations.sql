
-- Revenue per customer
SELECT
    c.customer_id,
    c.customer_name,
    SUM(
        oi.quantity * oi.unit_price *
        (1 - oi.discount_percent / 100.0)
    ) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;


-- Revenue by category
SELECT
    p.category,
    SUM(
        oi.quantity * oi.unit_price *
        (1 - oi.discount_percent / 100.0)
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category;


-- Revenue by month
SELECT
    strftime('%Y-%m', o.order_date) AS month,
    SUM(
        oi.quantity * oi.unit_price *
        (1 - oi.discount_percent / 100.0)
    ) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;


-- Top products by quantity
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 10;


-- Top products by revenue
SELECT
    p.product_name,
    SUM(
        oi.quantity * oi.unit_price *
        (1 - oi.discount_percent / 100.0)
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;
