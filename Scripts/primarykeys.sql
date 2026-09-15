ALTER TABLE olist_customers_dataset ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);
ALTER TABLE olist_orders_dataset ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);
ALTER TABLE olist_products_dataset ADD CONSTRAINT pk_products PRIMARY KEY (product_id);
ALTER TABLE olist_sellers_dataset ADD CONSTRAINT pk_sellers PRIMARY KEY (seller_id);
ALTER TABLE product_category_name_translation ADD CONSTRAINT pk_category_translation PRIMARY KEY (product_category_name);
ALTER TABLE olist_order_items_dataset ADD CONSTRAINT pk_order_items PRIMARY KEY (order_id, order_item_id);
ALTER TABLE olist_order_reviews_dataset ADD CONSTRAINT pk_order_reviews PRIMARY KEY (review_id, order_id);
ALTER TABLE olist_order_payments_dataset ADD CONSTRAINT pk_order_payments PRIMARY KEY (order_id, payment_sequential);