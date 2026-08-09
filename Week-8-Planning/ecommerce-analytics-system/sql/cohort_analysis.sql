
-- Find first purchase month
WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(strftime('%Y-%m', order_date)) AS first_purchase_month
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
)

SELECT
    o.customer_id,
    f.first_purchase_month,
    strftime('%Y-%m', o.order_date) AS purchase_month
FROM orders o
JOIN first_purchase f
    ON o.customer_id = f.customer_id;


-- Repeat vs one-time customers
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS number_of_orders,
    CASE
        WHEN COUNT(DISTINCT order_id) = 1
        THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_status
FROM orders
WHERE customer_id IS NOT NULL
GROUP BY customer_id;
