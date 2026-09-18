--avaliação vs prazo de entrega
WITH entregas AS (
    SELECT
        o.order_id,
        CASE
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 'Atrasado'
            ELSE 'No prazo'
        END AS "Status da entrega"
    FROM olist_orders_dataset o
    WHERE o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND o.order_estimated_delivery_date IS NOT NULL
),

avaliacoes AS (
    SELECT
        r.order_id,
        AVG(r.review_score) AS "Nota"
    FROM olist_order_reviews_dataset r
    WHERE r.review_score IS NOT NULL
    GROUP BY r.order_id
)

SELECT
    e."Status da entrega",
    COUNT(*) AS "Pedidos avaliados",
    ROUND(AVG(a."Nota")::numeric, 2) AS "Nota média",
    COUNT(*) FILTER (
        WHERE a."Nota" <= 2
    ) AS "Avaliações negativas",
    ROUND((
            COUNT(*) FILTER (WHERE a."Nota" <= 2)::numeric
            / COUNT(*)
        ) * 100,
        2
    ) AS "% negativas"
FROM entregas e
JOIN avaliacoes a
    ON e.order_id = a.order_id
GROUP BY e."Status da entrega"
ORDER BY "Nota média" DESC;







-- avaliação vs método de pagamento
WITH avaliacoes AS (
    SELECT
        order_id,
        AVG(review_score) AS "Nota"
    FROM olist_order_reviews_dataset
    WHERE review_score IS NOT NULL
    GROUP BY order_id
),
pagamentos AS (
    SELECT DISTINCT
        order_id,
        payment_type AS "Método de pagamento"
    FROM olist_order_payments_dataset
)
SELECT
    p."Método de pagamento",
    COUNT(*) AS "Pedidos avaliados",
    ROUND(AVG(a."Nota")::numeric, 2) AS "Nota média",
    COUNT(*) FILTER (WHERE a."Nota" <= 2) AS "Avaliações negativas",
    ROUND((COUNT(*) FILTER (WHERE a."Nota" <= 2)::numeric / COUNT(*)) * 100,2) AS "% negativas"
FROM pagamentos p
JOIN avaliacoes a
    ON p.order_id = a.order_id
GROUP BY p."Método de pagamento"
ORDER BY "Nota média" DESC;








--Avaliação por categoria e nota com volume minimo de 500 pedidos
WITH avaliacoes AS (
    SELECT
        order_id,
        AVG(review_score) AS "Nota"
    FROM olist_order_reviews_dataset
    WHERE review_score IS NOT NULL
    GROUP BY order_id
),
pedido_categoria AS (
    SELECT DISTINCT
        oi.order_id,
        p.product_category_name AS "Categoria"
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
)
SELECT
    pc."Categoria",
    COUNT(*) AS "Avaliações",
    ROUND(AVG(a."Nota")::numeric, 2) AS "Nota média",
    COUNT(*) FILTER (WHERE a."Nota" <= 2) AS "Avaliações negativas",
    ROUND((COUNT(*) FILTER (WHERE a."Nota" <= 2)::numeric / COUNT(*)) * 100, 2) AS "% negativas"
FROM pedido_categoria pc
JOIN avaliacoes a
    ON pc.order_id = a.order_id
GROUP BY pc."Categoria"
HAVING COUNT(*) >= 500
ORDER BY "Nota média" DESC;








WITH avaliacoes AS (
    SELECT
        order_id,
        AVG(review_score) AS "Nota"
    FROM olist_order_reviews_dataset
    WHERE review_score IS NOT NULL
    GROUP BY order_id
),
pedido_categoria AS (
    SELECT DISTINCT
        oi.order_id,
        p.product_category_name AS "Categoria"
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
)
SELECT
    pc."Categoria",
    COUNT(*) AS "Avaliações",
    ROUND(AVG(a."Nota")::numeric, 2) AS "Nota média",
    COUNT(*) FILTER (WHERE a."Nota" <= 2) AS "Avaliações negativas",
    ROUND((COUNT(*) FILTER (WHERE a."Nota" <= 2)::numeric / COUNT(*)) * 100,2) AS "% negativas"
FROM pedido_categoria pc
JOIN avaliacoes a
    ON pc.order_id = a.order_id
GROUP BY pc."Categoria"
ORDER BY "Nota média" DESC;






-- distribuição de notas
select 	
	review_score as "Nota",
	count(*) as "Quantidade",
	Round((Count(*)::numeric / sum(Count(*)) over()) *100, 2) as "% Total"
	from olist_order_reviews_dataset
	where review_score is not null
	group by review_score
	order by review_score;
	








-- visão geral das avaliações

select 
	count(*) as "Total de avaliações",
	count(distinct order_id) as "Total de pedidos",
	round(Avg(review_score)::numeric, 2 ) as "Nota média",
	count(*) Filter (where review_score <= 2) as "Avaliações negativas",
	round((count(*) Filter (where review_score <= 2)::numeric / count(*))*100, 2 ) as "% Avaliações negativas"
	
	from olist_order_reviews_dataset
	where review_score is not null;