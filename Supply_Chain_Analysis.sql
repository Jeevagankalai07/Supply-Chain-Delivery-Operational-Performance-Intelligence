-- 1. DATA OVERVIEW

SELECT *
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`
LIMIT 10;

-- 2. UNIQUE ORDERS

SELECT COUNT(DISTINCT `Order Id`) AS unique_orders
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`;

-- 3. DUPLICATE RECORD ANALYSIS

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT `Order Item Id`) AS unique_order_items,
    COUNT(*) - COUNT(DISTINCT `Order Item Id`) AS duplicate_records
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`;

-- 4. DELIVERY PERFORMANCE ANALYSIS

SELECT
    AVG(`Days for shipping _real_`) AS avg_actual_days,
    AVG(`Days for shipment _scheduled_`) AS avg_scheduled_days,
    COUNTIF(`Late_delivery_risk` = 1) AS late_delivery_count,
    COUNT(*) AS total_order_items
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`;

-- 5. SHIPPING MODE PERFORMANCE ANALYSIS

SELECT
    `Shipping Mode`,
    AVG(`Days for shipping _real_`) AS avg_delivery_days,
    COUNT(*) AS total_orders
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`
GROUP BY `Shipping Mode`
ORDER BY avg_delivery_days DESC;

-- 6. REGIONAL DELIVERY PERFORMANCE

SELECT
    `Order Region`,
    AVG(`Days for shipping _real_`) AS avg_delivery_days,
    COUNT(*) AS total_orders

FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`

GROUP BY `Order Region`

ORDER BY avg_delivery_days DESC;

-- 7. REGIONAL LATE DELIVERY RISK ANALYSIS

SELECT
    `Order Region`,

    COUNTIF(`Late_delivery_risk` = 1)
        AS late_risk_orders,
    COUNT(*) AS total_orders,

    ROUND(
        SAFE_DIVIDE(
            COUNTIF(`Late_delivery_risk` = 1),
            COUNT(*)
        ) * 100, 2
    ) AS late_risk_percentage

FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`

GROUP BY `Order Region`

ORDER BY late_risk_percentage DESC;

-- 8. PRODUCT CATEGORY PROFITABILITY ANALYSIS

SELECT
    `Category Name`,

    SUM(`Benefit per order`) AS total_profit,

    AVG(`Benefit per order`) AS avg_profit_per_item,

    COUNT(*) AS total_order_items

FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`

GROUP BY `Category Name`

ORDER BY total_profit DESC;

-- 9. SALES VS PROFIT ANALYSIS

SELECT
    `Category Name`,

    SUM(Sales) AS total_sales,

    SUM(`Benefit per order`) AS total_profit,

    ROUND(
        SAFE_DIVIDE(
            SUM(`Benefit per order`),
            SUM(Sales)
        ) * 100, 2
    ) AS profit_margin_percentage

FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`

GROUP BY `Category Name`

ORDER BY total_sales DESC;

-- 10. MONTHLY SALES TREND

SELECT
    EXTRACT(YEAR FROM `order date _DateOrders_`) AS order_year,
    EXTRACT(MONTH FROM `order date _DateOrders_`) AS order_month,
    SUM(Sales) AS total_sales,
    COUNT(DISTINCT `Order Id`) AS total_orders
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- 11. YEARLY SALES PERFORMANCE

SELECT
    EXTRACT(YEAR FROM `order date _DateOrders_`) AS order_year,
    SUM(Sales) AS total_sales,
    COUNT(DISTINCT `Order Id`) AS total_orders,
    ROUND(AVG(Sales), 2) AS avg_sales_per_item
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`
GROUP BY order_year
ORDER BY order_year;

-- 12. CUSTOMER SEGMENT ANALYSIS

SELECT
    `Customer Segment`,
    COUNT(DISTINCT `Order Id`) AS total_orders,
    SUM(Sales) AS total_sales,
    ROUND(AVG(Sales), 2) AS avg_sales_per_item
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`
GROUP BY `Customer Segment`
ORDER BY total_sales DESC;

-- 13. ORDER STATUS ANALYSIS

SELECT
    `Order Status`,
    COUNT(DISTINCT `Order Id`) AS total_orders,
    SUM(Sales) AS total_sales
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`
GROUP BY `Order Status`
ORDER BY total_orders DESC;

-- 14. TOP 10 PRODUCTS BY SALES

SELECT
    `Product Name`,
    SUM(Sales) AS total_sales,
    SUM(`Benefit per order`) AS total_benefit,
    COUNT(DISTINCT `Order Id`) AS total_orders
FROM `supply-chain-analytics-513203.supply_chain_data.supply_chain_orders`
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;




