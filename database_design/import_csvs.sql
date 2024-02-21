\c jugos_rodier;

COPY customer(customer_id, first_name, last_name, address, sec_address, zipcode, city, state, country)
FROM '/home/srodier/repos/jugos_rodier/csvs/customer_info.csv'
DELIMITER ','
CSV HEADER;

COPY inventory(inventory_id,ingred_name,carton_price,serv_per_carton,carton_quantity)
FROM '/home/srodier/repos/jugos_rodier/csvs/ingredients.csv'
DELIMITER ','
CSV HEADER;

COPY item(item_id,item_name,item_category,item_size,price)
FROM '/home/srodier/repos/jugos_rodier/csvs/menu_items.csv'
DELIMITER ','
CSV HEADER;

COPY recipe(row_id,recipe_id,inventory_id,inventory_name,recipe_servings)
FROM '/home/srodier/repos/jugos_rodier/csvs/recipe.csv'
DELIMITER ','
CSV HEADER;

COPY transaction(trans_id,transaction_total,customer_id,time_of_day)
FROM '/home/srodier/repos/jugos_rodier/csvs/transaction.csv'
DELIMITER ','
CSV HEADER;
 
COPY transaction_item(transaction_item_id,trans_id,item_id,item_price,quantity)
FROM  '/home/srodier/repos/jugos_rodier/csvs/transaction_items.csv'
DELIMITER ','
CSV HEADER;

