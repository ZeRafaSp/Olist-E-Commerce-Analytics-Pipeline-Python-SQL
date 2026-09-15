--evolução mensal de pagamentos com porcentagem de crescimento
with pagamento_mes as (
select
	date_trunc('month', o.order_purchase_timestamp) as "mes",
	count(*) as "Total de pagamentos",
	count(distinct op.order_id) as "Pedidos",
	round(sum(op.payment_value)::numeric, 2) as  "Valor total",
	round(avg(op.payment_value)::numeric, 2) as  "Média de pagamentos"
	from olist_order_payments_dataset op
	join olist_orders_dataset o on op.order_id = o.order_id 
	where op.payment_installments >=1 
	group by "mes"
)	
select	
	*,
	round((
	"Valor total" /
	sum("Valor total") over() *100)::numeric, 2) as "% do valor total",	

	round(((
	"Valor total" /
	lag("Valor total") over(order by "mes"))-1 )*100, 2) as "% Crescimento"

	from pagamento_mes
	order by "mes" ASC;









-- distribuição de faturamento, a vista vs parcelado
select
		case 
			when "payment_installments" =1
			then 'a vista'
			when "payment_installments" >=2
			then 'parcelado'
		end as "Tipo de pagamento",
	count(*) as "Total de pagamentos",
	count(distinct order_id) as "Pedidos",
	round(sum(payment_value)::numeric, 2) as  "Valor total",
	round(avg(payment_value)::numeric, 2) as  "Média de pagamentos",
	round((
	sum(payment_value) /
	sum(sum(payment_value)) over() *100)::numeric, 2) as "% do valor total"
	from olist_order_payments_dataset
	where payment_installments >=1 
	group by 			
		case 
			when "payment_installments" =1
			then 'a vista'
			when "payment_installments" >=2
			then 'parcelado'
		end 
	order by "Valor total" DESC;








-- distribuição das parcelas
select
	payment_installments as "Parcelas",
	count(*) as "Total de pagamentos",
	count(distinct order_id) as "Pedidos",
	round(sum(payment_value)::numeric, 2) as  "Valor total",
	round(avg(payment_value)::numeric, 2) as  "Média de pagamentos",
	round((
	sum(payment_value) /
	sum(sum(payment_value)) over() *100)::numeric, 2) as "% do valor total"
	from olist_order_payments_dataset
	group by "Parcelas"
	order by "Parcelas" ;






-- métodos de pagamento
select
	payment_type as "Método de pagamento",
	count(*) as "Total de pagamentos",
	count(distinct order_id) as "Pedidos",
	round(sum(payment_value)::numeric, 2) as  "Valor total",
	round(avg(payment_value)::numeric, 2) as  "Média de pagamentos",
	round((
	sum(payment_value) /
	sum(sum(payment_value)) over() *100)::numeric, 2) as "% do valor total"
	from olist_order_payments_dataset
	group by payment_type;






-- visão geral dos pagamentos
select
	count(*) as "Total de pagamentos",
	count(distinct order_id) as "Pedidos com pagamento",
	round(sum(payment_value)::numeric, 2) as  "Valor total",
	round(avg(payment_value)::numeric, 2) as  "Média de pagamentos",
	max(payment_value) as "Maior pagamento",
	round(avg(payment_installments)::numeric, 2) as "Média de parcelas"	
	from olist_order_payments_dataset;
		


