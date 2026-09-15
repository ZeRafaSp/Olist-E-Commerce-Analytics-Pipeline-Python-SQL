SELECT order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value
FROM public.olist_order_items_dataset;


SELECT review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp
FROM public.olist_order_reviews_dataset;

SELECT review_id, COUNT(*)
FROM olist_order_reviews_dataset
GROUP BY review_id
HAVING COUNT(*) > 1


SELECT review_id, order_id, COUNT(*)
FROM olist_order_reviews_dataset
GROUP BY review_id, order_id
HAVING COUNT(*) > 1;

SELECT order_id, order_item_id, COUNT(*)
FROM olist_order_items_dataset
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;


SELECT order_id, payment_sequential, COUNT(*)
FROM olist_order_payments_dataset
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;







