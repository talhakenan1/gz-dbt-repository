SELECT
    orders_id,
    MAX(date_date) AS date_date, -- Siparişteki tarihlerden en güncel olanı alır
    SUM(revenue) AS revenue,
    SUM(CAST(quantity AS FLOAT64)) AS quantity,
    SUM(purchase_cost) AS purchase_cost,
    SUM(margin) AS margin
FROM {{ ref('int_sales_margin') }}
GROUP BY orders_id