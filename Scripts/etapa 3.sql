-- resumo dos clientes
with pedido_cliente as (
	select	
		oc.customer_unique_id as "Clientes",
		count(distinct o.order_id) as "Total de pedidos"
		from olist_customers_dataset oc
		join olist_orders_dataset o on oc.customer_id = o.customer_id 
		group by "Clientes"
)

select 
	count(*) as "Total de pedidos",
	count(*) filter(
	where "Total de pedidos" = 1) as "Clientes com 1 pedido",
	count(*) filter(
	where "Total de pedidos" > 1) as "Clientes recorrentes",	
	round(
	(count(*) filter( where "Total de pedidos" > 1)::numeric  / count(*)) *100, 2 ) as "% Clientes recorrentes",
	round(avg("Total de pedidos")::numeric) as "Média de pedidos por cliente",
	round(max("Total de pedidos")) as "maio numero de pedidos por cliente"
	from pedido_cliente;





--distribuição de frequência de pedidos
WITH pedidos_cliente AS (
	select 
		oc.customer_unique_id as "Clientes",
		count(distinct o.order_id) as "Total de pedidos"
		from olist_customers_dataset oc
		join olist_orders_dataset o on o.customer_id = oc.customer_id 
		group by oc.customer_unique_id 

)
select 
	"Total de pedidos",
	count(*) as "Clientes"
	from pedidos_cliente
	group by "Total de pedidos"
	order by "Total de pedidos";





--verificar clientes recorrentes
with 
pedido_cliente as(
	select 
		oc.customer_unique_id as "Clientes",
		count(distinct o.order_id) as "Total de pedidos"
		from olist_customers_dataset oc
		join olist_orders_dataset o on o.customer_id = oc.customer_id 
		group by oc.customer_unique_id 
		
)
	select
		count(*) as "Total de clientes",
		count(*) Filter(
		where "Total de pedidos" = 1) as "Clientes com 1 pedido",
		count(*) Filter(
		where "Total de pedidos" > 1) as "Clientes recorrentes"
		
		from pedido_cliente;








--quantos clientes fizeram pedido

select 
		o.customer_id as "clientes",
		count(distinct o.order_id ) as "Total de pedidos"
		from olist_orders_dataset o
		group by o.customer_id
		order by "Total de pedidos"  DESC;




--verificar quantidade de clientes q realizaram pedidos
select 
	count(distinct customer_id) as "Clientes Unicos",
	count(distinct order_id) as "Pedidos"
	from olist_orders_dataset