{{ config(materialized='table') }}
SELECT
    date_date,
    COUNT(DISTINCT orders_id) AS nb_transactions,
    SUM(revenue) AS revenue,
    SUM(revenue) / NULLIF(COUNT(DISTINCT orders_id), 0) AS average_basket,
    SUM(operational_margin) AS operational_margin,
    SUM(purchase_cost) AS purchase_cost,
    SUM(shipping_fee) AS shipping_fee,
    SUM(logcost) AS logistics_cost,
    SUM(quantity) AS quantity
FROM {{ ref('int_orders_operational') }}
GROUP BY
    date_date