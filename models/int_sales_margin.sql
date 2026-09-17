WITH sales AS (
    SELECT * FROM {{ ref('stg_raw__sales') }}
),
product AS (
    SELECT * FROM {{ ref('stg_raw__product') }}
)

SELECT
    sales.orders_id,
    sales.date_date,
    sales.products_id,
    sales.revenue,
    sales.quantity,
    product.purchase_price,
    -- Satın Alma Maliyeti Hesabı
    CAST(sales.quantity AS FLOAT64) * product.purchase_price AS purchase_cost,
    -- Marj Hesabı
    sales.revenue - (CAST(sales.quantity AS FLOAT64) * product.purchase_price) AS margin
FROM sales
LEFT JOIN product
    ON sales.products_id = product.products_id