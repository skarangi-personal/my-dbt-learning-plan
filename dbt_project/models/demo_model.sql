-- Sample unformatted DBT model for SQLFluff demo
SELECT
    customer_id,
    order_date,
    amount,
    status
FROM raw_orders
WHERE status = 'completed' AND amount > 100
ORDER BY order_date DESC
