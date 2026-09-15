SELECT *
FROM public.product_category_name_translation;

SELECT *
FROM olist_products_dataset 
WHERE product_category_name = '';

UPDATE olist_products_dataset
SET product_category_name = NULL
WHERE product_category_name = '';

SELECT *
FROM olist_products_dataset 
WHERE product_category_name is  NULL;