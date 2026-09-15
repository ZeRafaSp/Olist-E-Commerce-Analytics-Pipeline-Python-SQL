SELECT DISTINCT p.product_category_name
FROM olist_products_dataset p
LEFT JOIN product_category_name_translation t 
  ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL 
  AND t.product_category_name IS NULL;

SELECT *
FROM public.product_category_name_translation
WHERE product_category_name_english  like '%pc%';

INSERT INTO product_category_name_translation (product_category_name, product_category_name_english)
VALUES 
  ('pc_gamer', 'pc_gamer'),
  ('portateis_cozinha_e_preparadores_de_alimentos', 'kitchen_portables_and_food_preparators');