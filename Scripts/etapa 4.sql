-- avaliações das notas recebidas pelos pedidos entregues dentro e fora do prazo, verificando quantidade e porcentagem de notas negativas 
with entregas as (
	select
		o.order_id,
		case 
			when "order_delivered_customer_date" > "order_estimated_delivery_date"
			then 'atrasado'
			else 'no prazo'
		end as "Status de entrega"
        from olist_orders_dataset o
       	where o.order_status = 'delivered' 
       	and o.order_delivered_customer_date is not null
       	and o.order_estimated_delivery_date is not null
),
avaliacao as(
	select
		orr.order_id,
		avg(orr.review_score) as "Nota"
		from olist_order_reviews_dataset orr
		where orr.review_score is not null
		group by orr.order_id  
)
select
	e."Status de entrega",
	count(*) as "Pedidos entregues",
	round(avg(a."Nota")::numeric, 2) as "Média de notas",
	count(*) filter( where a."Nota" <= 2) as "Avaliações negativas",
	round((count(*) filter( where a."Nota" <= 2)::numeric / count(*)) *100 , 2) as "% avaliações negativas"
	from entregas e
	join avaliacao a on e.order_id = a.order_id
	group by e."Status de entrega"
	order by "Média de notas";









--evoluçao dos prazos e entregas reais mês a mês
with entregas as (
	select
		o.order_id,
        date_trunc('month', o.order_purchase_timestamp ) as "mes",
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_purchase_timestamp"))/86400 as "Dias para entrega",
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_estimated_delivery_date"))/86400 as "Diferença de prazo"
        from olist_orders_dataset o
       	where o.order_status = 'delivered' 
       	and o.order_delivered_customer_date is not null
       	and o.order_estimated_delivery_date is not null
),
resumo_mes as(
	select
		"mes",
		count(*) as "Pedidos entregues",
		Avg("Dias para entrega") as "Tempo médio",
		avg("Diferença de prazo") as "Diferença média",
		count (*) filter(where "Diferença de prazo" > 0 ) as "Pedidos atrasados"
		from entregas
		group by "mes"

)
select
	"mes",
	"Pedidos entregues",
	round("Tempo médio"::numeric, 2) as "Tempo médio de entrega",
	round("Diferença média"::numeric, 2) as "Tempo médio de prazo",
	"Pedidos atrasados",
	Round(("Pedidos atrasados"::numeric / "Pedidos entregues") *100, 2) as "% pedidos atrasados"
	from resumo_mes
	order by "mes";















--analise de prazo e entrega real por estado com volume minimo de 1000 pedidos
with entregas as (
	select
		o.order_id,
        oc.customer_state as "Estado",
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_purchase_timestamp"))/86400 as "Dias para entrega",
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_estimated_delivery_date"))/86400 as "Diferença de prazo"
        from olist_orders_dataset o
        join olist_customers_dataset oc on o.customer_id = oc.customer_id
       	where o.order_status = 'delivered' 
       	and o.order_delivered_customer_date is not null
       	and o.order_estimated_delivery_date is not null
),
resumo_estado as(
	select
		"Estado",
		count(*) as "Pedidos entregues",
		Avg("Dias para entrega") as "Tempo médio",
		avg("Diferença de prazo") as "Diferença média",
		count (*) filter(where "Diferença de prazo" > 0 ) as "Pedidos atrasados"
		from entregas
		group by "Estado"

)
select
	"Estado",
	"Pedidos entregues",
	round("Tempo médio"::numeric, 2) as "Tempo médio de entrega",
	round("Diferença média"::numeric, 2) as "Tempo médio de prazo",
	"Pedidos atrasados",
	Round(("Pedidos atrasados"::numeric / "Pedidos entregues") *100, 2) as "% pedidos atrasados"
	from resumo_estado
	where "Pedidos entregues" >= 1000
	order by "% pedidos atrasados" DESC;


















--analise de prazo e entrega real por estado
with entregas as (
	select
		o.order_id,
        oc.customer_state as "Estado",
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_purchase_timestamp"))/86400 as "Dias para entrega",
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_estimated_delivery_date"))/86400 as "Diferença de prazo"
        from olist_orders_dataset o
        join olist_customers_dataset oc on o.customer_id = oc.customer_id
       	where o.order_status = 'delivered' 
       	and o.order_delivered_customer_date is not null
       	and o.order_estimated_delivery_date is not null
)
select
	"Estado",
	count(*) as "Pedidos entregues",
	round(avg("Dias para entrega")::numeric, 2) as "Tempo médio de entrega",
	round(avg("Diferença de prazo")::numeric, 2) as "Tempo médio de prazo",
	count(*) filter( where "Diferença de prazo" >= 0) as "pedidos atrasados",
	Round((count(*) filter ( where "Diferença de prazo" >= 0)::numeric / count(*)) *100, 2) as "% pedidos atrasados"
	from entregas
	group by "Estado"
	order by "% pedidos atrasados" DESC;











-- analise entre prazo e entrega real
with entregas as (
	select
		o.order_id,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_purchase_timestamp"))/86400 as "Dias para entrega",
        extract(
        EPOCH from ("order_delivered_customer_date" - "order_estimated_delivery_date"))/86400 as "Diferença de prazo"
        from olist_orders_dataset o
       	where o.order_status = 'delivered' 
       	and o.order_delivered_customer_date is not null
       	and o.order_estimated_delivery_date is not null
)
select
	count(*) as "Pedidos entregues",
	round(avg("Dias para entrega")::numeric, 2) as "Tempo médio de entrega",
	round(avg("Diferença de prazo")::numeric, 2) as "Tempo médio de prazo",
	count(*) filter( where "Diferença de prazo" >= 0) as "pedidos atrasados",
	Round((count(*) filter ( where "Diferença de prazo" >= 0)::numeric / count(*)) *100, 2) as "% pedidos atrasados"
	from entregas;


















--analise do tempo das entregas realizadas
with entregas as(
	select 
		o.order_id,
		o.order_purchase_timestamp,
		o.order_delivered_customer_date
		from olist_orders_dataset o
		where o.order_status = 'delivered' and o.order_delivered_customer_date is not null
)

select 	
	round(avg(extract
	(EPOCH from ("order_delivered_customer_date" - "order_purchase_timestamp"))/86400 )::numeric, 2) as "Tempo medio de entregas (dias)",
	round(min(extract
	(Epoch from ("order_delivered_customer_date" - "order_purchase_timestamp"))/86400 )::numeric, 2) as "menor tempo (dias)",
	round(max(extract
	(Epoch from ("order_delivered_customer_date" - "order_purchase_timestamp"))/86400 )::numeric, 2) as "maior tempo (dias)"
from entregas;


