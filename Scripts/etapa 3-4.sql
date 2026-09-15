--ranking de ticket medio com volume minimo de 1000 pedidos 
with venda_estado as(
	select 
		oc.customer_state as "Estado",
		count(oc.customer_unique_id) as "Clientes unicos",
		count(distinct o.order_id) as "Total de pedidos",
		round(sum(oi.price)::numeric, 2) as "Faturamento"		
		from olist_customers_dataset oc
		join olist_orders_dataset o on oc.customer_id = o.customer_id
		join olist_order_items_dataset oi on o.order_id = oi.order_id
		group by "Estado"
),
ranking_ticket as (
	select *,
		round(("Faturamento" / "Total de pedidos")::numeric, 2) as "Ticket medio",
		row_number() over(order by "Faturamento" / "Total de pedidos" DESC) as "Ranking"
		from venda_estado _
		where "Total de pedidos" >= 1000
)
select 
	"Ranking",
    "Estado",
    "Clientes unicos",
    "Total de pedidos",
    round("Faturamento"::numeric, 2) AS "Faturamento",
    "Ticket medio"
		from ranking_ticket
		order by "Ranking";










--vendas por estado
with venda_estado as(
	select 
		oc.customer_state as "Estado",
		count(oc.customer_unique_id) as "Clientes unicos",
		count(distinct o.order_id) as "Total de pedidos",
		round(sum(oi.price)::numeric, 2) as "Faturamento"		
		from olist_customers_dataset oc
		join olist_orders_dataset o on oc.customer_id = o.customer_id
		join olist_order_items_dataset oi on o.order_id = oi.order_id
		group by "Estado"
),
Total_fat as (
	select
		sum("Faturamento") as "Faturamento total"
		from venda_estado
)
select
	ve."Estado",
    ve."Clientes unicos",
    ve."Total de pedidos",
    round(ve."Faturamento"::numeric, 2) AS "Faturamento",
    round((ve."Faturamento" / tf."Faturamento total" * 100)::numeric, 2) as "% de Faturamento",
    round ((ve."Faturamento" / ve."Total de pedidos" )::numeric, 2) as "Ticket médio"
    from venda_estado ve
    cross join total_fat tf
    order by "Faturamento" desc;










