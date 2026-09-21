WITH orders_margin AS (
    SELECT * FROM {{ ref('int_orders_margin') }}
),
ship AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
)

SELECT
    orders_margin.orders_id,
    orders_margin.date_date,
    orders_margin.revenue,
    orders_margin.quantity,
    orders_margin.purchase_cost,
    orders_margin.margin,
    -- Dışarı aktarılması gereken eksik sütunlar eklendi:
    CAST(ship.shipping_fee AS FLOAT64) AS shipping_fee,
    CAST(ship.logcost AS FLOAT64) AS logcost,
    CAST(ship.ship_cost AS FLOAT64) AS ship_cost,
    -- Operasyonel Marj Hesabı: Marj + Nakliye Ücreti - Lojistik Maliyeti - Nakliye Maliyeti
    orders_margin.margin + CAST(ship.shipping_fee AS FLOAT64) - CAST(ship.logcost AS FLOAT64) - CAST(ship.ship_cost AS FLOAT64) AS operational_margin
FROM orders_margin
LEFT JOIN ship
    ON orders_margin.orders_id = ship.orders_id