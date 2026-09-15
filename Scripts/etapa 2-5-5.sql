-- Evolução temporal das vendas por mês

with pedidos_mes as(
		select 
		date_trunc('month', o.order_purchase_timestamp) as "mes",
		count(distinct o.order_id) as "Total de pedidos",
		round(SUM(oi.price)::numeric, 2) as "Faturamento",
		round((sum(oi.price) / count(distinct o.order_id))::numeric, 2) as "Ticket médio"
		from olist_orders_dataset o
		join olist_order_items_dataset oi on o.order_id = oi.order_id
		group by "mes"
),

evolucao as(
		select
		pm.*,
		lag(pm."Total de pedidos") Over( order by pm."mes") as "Pedido mes anterior"
		from pedidos_mes pm
),

evolucao_fat as(
		select
		pm.*,
		lag(pm."Faturamento") Over(order by pm."mes") as "Faturamento mes anterior"
		from pedidos_mes pm

)

select
	e."mes",
	e."Total de pedidos",
	e."Faturamento",
	e."Ticket médio",
	round(((e."Total de pedidos" - e."Pedido mes anterior") / e."Pedido mes anterior"::numeric) *100, 2) as "% evolução mensal de pedidos",
	round (((ef."Faturamento" - ef."Faturamento mes anterior") / ef."Faturamento mes anterior"::numeric) *100, 2) as "% evolução mensal faturamento"
	from evolucao e
	join evolucao_fat ef on e."mes" = ef."mes"
	order by e."mes";








SELECT
    MIN(order_purchase_timestamp) AS "Primeiro pedido",
    MAX(order_purchase_timestamp) AS "Último pedido"
FROM olist_orders_dataset;

select
	date_trunc('month', o.order_purchase_timestamp) as "mes",
    o.order_purchase_timestamp
	FROM olist_orders_dataset o
	WHERE o.order_purchase_timestamp >= '2018-09-01'
    AND o.order_purchase_timestamp < '2018-10-01'
	order by o.order_purchase_timestamp;

SELECT
    COUNT(*) AS "Total de registros",
    COUNT(DISTINCT o.order_id) AS "Pedidos distintos"
FROM olist_orders_dataset o
WHERE o.order_purchase_timestamp >= '2018-09-01'
  AND o.order_purchase_timestamp < '2018-10-01';


SELECT
    o.order_id,
    o.order_purchase_timestamp
FROM olist_orders_dataset o
WHERE o.order_purchase_timestamp >= '2018-09-01'
  AND o.order_purchase_timestamp < '2018-10-01'
ORDER BY o.order_purchase_timestamp;


SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS "mes",
    COUNT(DISTINCT o.order_id) AS "Total de pedidos",
    ROUND(SUM(oi.price)::numeric, 2) AS "Faturamento"
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_purchase_timestamp >= '2018-09-01'
  AND o.order_purchase_timestamp < '2018-10-01'
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp);



SELECT
    o.order_id,
    o.order_purchase_timestamp,
    oi.order_id AS "item_order_id",
    oi.price
FROM olist_orders_dataset o
LEFT JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_purchase_timestamp >= '2018-09-01'
  AND o.order_purchase_timestamp < '2018-10-01'
ORDER BY o.order_purchase_timestamp;



SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date
FROM olist_orders_dataset o
WHERE o.order_purchase_timestamp >= '2018-09-01'
  AND o.order_purchase_timestamp < '2018-10-01'
ORDER BY o.order_purchase_timestamp;


SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS "mes",
    o.order_status AS "status",
    COUNT(DISTINCT o.order_id) AS "Total de pedidos"
FROM olist_orders_dataset o
WHERE o.order_purchase_timestamp >= '2018-09-01'
GROUP BY
    DATE_TRUNC('month', o.order_purchase_timestamp),
    o.order_status
ORDER BY "mes", "status";
