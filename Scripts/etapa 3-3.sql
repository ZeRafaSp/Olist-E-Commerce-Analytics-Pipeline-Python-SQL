--concentração de faturamento
with faturamento_cliente as(
	select 
		oc.customer_unique_id as "Clientes",
		count(distinct o.order_id) as "Total de pedidos",
		round(sum(oi.price)::numeric, 2) as "Faturamento"		
		from olist_customers_dataset oc
		join olist_orders_dataset o on oc.customer_id = o.customer_id
		join olist_order_items_dataset oi on o.order_id = oi.order_id
		group by "Clientes"
),
ranking_cliente as (
	select *,
		row_number () over (order by "Faturamento" DESC) as "Ranking"
		from faturamento_cliente
),
resumo as (
	select
		sum("Faturamento") as "Faturamento total",
		sum(
			case
				when "Ranking" <= 10 then "Faturamento"
				else 0
			end ) as "Top 10",			
		sum(		
			case
				when "Ranking" <= 100 then "Faturamento"
				else 0
			end ) as "Top 100",			
		sum(
			case
				when "Ranking" <=1000 then "Faturamento"
				else 0
			end ) as "Top 1000"		
		from ranking_cliente
)
select
	Round("Faturamento total"::numeric, 2) as "Faturamento total",
	round("Top 10"::numeric, 2) as "Faturamento top 10",
	round(("Top 10" / "Faturamento total" *100)::numeric, 2) as "% Top 10",
	round("Top 100"::numeric, 2) as "Faturamento top 100",
	round(("Top 100" / "Faturamento total" *100 )::numeric, 2) as "% Top 100",
	round("Top 1000"::numeric, 2) as "Faturamento top 1000",
	round(("Top 1000" / "Faturamento total" *100 )::numeric, 2) as "%Top 1000"
	from resumo;
	
	











-- analise de faturamento por grupo de recorrencia de clientes
with faturamento_cliente as(
	select 
		oc.customer_unique_id as "Clientes",
		count(distinct o.order_id) as "Total de pedidos",
		round(sum(oi.price)::numeric, 2) as "Faturamento"		
		from olist_customers_dataset oc
		join olist_orders_dataset o on oc.customer_id = o.customer_id
		join olist_order_items_dataset oi on o.order_id = oi.order_id
		group by "Clientes"
),

grupo as (
	select	
		case
			when "Total de pedidos" = 1 then '1 pedido'
			when "Total de pedidos" = 2 then '2 pedidos'
			else '3+ pedidos'
		end as "Grupo",
		count(*) as "Clientes",
		sum("Faturamento") as "Faturamento",
		sum("Total de pedidos") as "Total de pedidos"
		from faturamento_cliente
		group by	
			case
				when "Total de pedidos" = 1 then '1 pedido'
				when "Total de pedidos" = 2 then '2 pedidos'
				else '3+ pedidos'	
				end
)
select 
	"Grupo",
	"Clientes",
	round("Faturamento"::numeric, 2) as "Faturamento",
	round(("Faturamento" / sum("Faturamento") over() * 100 )::numeric, 2) as "% Faturamento",
	round("Faturamento" / "Total de pedidos"::numeric, 2) as "Ticket médio"
	from grupo
	order by "Faturamento" DESC;














-- fatumaento por cliente
with faturamento_cliente as(
	select 
		oc.customer_unique_id as "Clientes",
		count(distinct o.order_id) as "Total de pedidos",
		round(sum(oi.price)::numeric, 2) as "Faturamento"		
		from olist_customers_dataset oc
		join olist_orders_dataset o on oc.customer_id = o.customer_id
		join olist_order_items_dataset oi on o.order_id = oi.order_id
		group by "Clientes"

)
select 
	count(*) as "Cliente que compraram",
	round(sum("Faturamento")::numeric, 2) as "Faturamento total",
	round(avg("Faturamento")::numeric, 2) as "Faturamento médio por cliente",
	round(max("Faturamento")::numeric, 2) as "Maior faturamento por cliente"
	from faturamento_cliente;
