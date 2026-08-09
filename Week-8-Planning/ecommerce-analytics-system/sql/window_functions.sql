
-- Rank customers by lifetime value
SELECT
    c.customer_id,
    c.customer_name,
    SUM(
        oi.quantity * oi.unit_price *
        (1 - oi.discount_percent / 100.0)
    ) AS lifetime_value,
    RANK() OVER (
        ORDER BY SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;


-- Running total
SELECT
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY month
    ) AS running_total
FROM (
    SELECT
        strftime('%Y-%m', o.order_date) AS month,
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY month
);


-- Moving average
SELECT
    month,
    monthly_revenue,
    AVG(monthly_revenue) OVER (
        ORDER BY month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average
FROM (
    SELECT
        strftime('%Y-%m', o.order_date) AS month,
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY month
);
