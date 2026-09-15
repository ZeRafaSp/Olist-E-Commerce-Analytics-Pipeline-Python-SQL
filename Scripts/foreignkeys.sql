-- orders -> customers
ALTER TABLE olist_orders_dataset
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES olist_customers_dataset (customer_id);

-- order_items -> orders
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset (order_id);

-- order_items -> products
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id)
REFERENCES olist_products_dataset (product_id);

-- order_items -> sellers
ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT fk_order_items_seller
FOREIGN KEY (seller_id)
REFERENCES olist_sellers_dataset (seller_id);

-- order_payments -> orders
ALTER TABLE olist_order_payments_dataset
ADD CONSTRAINT fk_payments_order
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset (order_id);

-- order_reviews -> orders
ALTER TABLE olist_order_reviews_dataset
ADD CONSTRAINT fk_reviews_order
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset (order_id);

-- products -> category translation
ALTER TABLE olist_products_dataset
ADD CONSTRAINT fk_products_category
FOREIGN KEY (product_category_name)
REFERENCES product_category_name_translation (product_category_name);