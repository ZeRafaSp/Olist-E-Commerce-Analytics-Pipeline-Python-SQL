
--Analise de volume de vendas por categoria

with vendas_categoria as (
select 
	p.product_category_name as "Categoria",
	count(distinct o.order_id) as "Total de pedidos",
	count(oi.order_item_id) as "Total de itens vendidos" ,
	count(distinct oi.product_id) as "Total de produtos"
	from olist_orders_dataset o
join olist_order_items_dataset oi on o.order_id  = oi.order_id 
join olist_products_dataset p on p.product_id  = oi.product_id 
group by p.product_category_name

),

total_fat as(
		select 
		p.product_category_name as "Categoria",
		round(SUM(oi.price)::numeric,2) as "Faturamento"
		from olist_order_items_dataset oi
		join olist_products_dataset p on oi.product_id = p.product_id
		GROUP BY p.product_category_name
),

total_fat_geral as(
		select
		round(Sum(oi.price)::numeric, 2) as "Faturamento total"
		from olist_order_items_dataset oi
),

preco_med as( 
		select
		p.product_category_name as "Categoria",
		round(AVG(oi.price)::numeric, 2) as "Preço médio por item"
		from olist_order_items_dataset oi
		join olist_products_dataset p on oi.product_id = p.product_id
		group by p.product_category_name
)
		
select vc."Categoria",
	   vc."Total de pedidos",
	   vc."Total de itens vendidos",
	   vc."Total de produtos",
	   tf."Faturamento",
	   pm."Preço médio por item",
	   round((tf."Faturamento"/tfg."Faturamento total" * 100)::numeric, 2) as "% de faturamento"
	   
		from vendas_categoria vc
		join total_fat	tf 
		on vc."Categoria" = tf."Categoria"
		join preco_med pm
		on vc."Categoria" = pm."Categoria"
		cross join total_fat_geral tfg
		order by "% de faturamento" DESC;









