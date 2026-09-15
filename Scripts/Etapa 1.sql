select count(distinct order_id) as "Total de pedidos"
from olist_orders_dataset ood;

select COUNT(ocd.customer_unique_id) as "Total de Clientes"
from olist_customers_dataset ocd;

select count(distinct seller_id) as "Total de vendedores"
from olist_sellers_dataset osd ;

select count(distinct product_id) as "numero de produtos cadastrados"
from olist_products_dataset opd  ;

select count(order_item_id) as "Itens vendidos"
from olist_order_items_dataset ooid   ;

select ROUND(SUM(payment_value)::numeric, 2) AS "Total de faturamento"
from olist_order_payments_dataset oopd ;

select ROUND((SUM(op.payment_value) / count(distinct op.order_id))::numeric, 2) AS "Ticket médio por pedido"
from olist_order_payments_dataset op ;



--Tamanho geral da operação
with total_pedidos AS(
		select count(distinct order_id) as "Total de pedidos"
		from olist_orders_dataset	
),
		
total_clientes AS(
		select COUNT(distinct c.customer_unique_id) as "Clientes que compraram"
		from olist_customers_dataset c
		join olist_orders_dataset o 
		on c.customer_id = o.customer_id
),
	
total_vend AS(
		select count(distinct seller_id) as "Total de vendedores"
		from olist_sellers_dataset
),

numero_pro_cad as (
		select count(distinct product_id) as "numero de produtos cadastrados"
		from olist_products_dataset 

),

itens_vend AS(
		select count(order_item_id) as "Itens vendidos"
		from olist_order_items_dataset	
),

total_fat as(
		select ROUND(SUM(payment_value)::numeric, 2) AS "Total de faturamento"
		from olist_order_payments_dataset
),

ticket_medio as(
		select ROUND((SUM(op.payment_value) / count(distinct op.order_id))::numeric, 2) AS "Ticket médio por pedido"
		from olist_order_payments_dataset op
)

SELECT
    total_pedidos."Total de pedidos",
    total_clientes."Clientes que compraram",
    total_vend."Total de vendedores",
    numero_pro_cad."numero de produtos cadastrados",
    itens_vend."Itens vendidos",
    total_fat."Total de faturamento",
    ticket_medio."Ticket médio por pedido"
FROM total_pedidos
CROSS JOIN total_clientes
CROSS JOIN total_vend
CROSS JOIN numero_pro_cad
CROSS JOIN itens_vend
CROSS JOIN total_fat
CROSS JOIN ticket_medio;



--Verificando o pq o numero de clientes q compraram é igual ao numero de pedidos

select count(distinct customer_unique_id) as "clientes unicos",
	   count(customer_id) as "registros de clientes"
	from olist_customers_dataset; 


select 
		COUNT(c.customer_unique_id) as "Clientes que compraram",
		count(o.customer_id) as "Customers ids nos pedidos"
	from olist_customers_dataset c
	join olist_orders_dataset o 
	on c.customer_id = o.customer_id;


	
select
    customer_unique_id,
    COUNT(*) AS quantidade
FROM olist_customers_dataset
GROUP BY customer_unique_id
HAVING COUNT(*) > 1
ORDER BY quantidade DESC;











