 \c jugos_rodier;

CREATE TABLE IF NOT EXISTS customer (
    customer_id varchar PRIMARY KEY,
    first_name varchar,
    last_name varchar,
    address varchar, 
    sec_address varchar NULL,
    zipcode varchar,
    city varchar,
    state varchar,
    country varchar
);

CREATE TABLE IF NOT EXISTS inventory (
    inventory_id varchar PRIMARY KEY,
    ingred_name varchar,
    carton_price float,
    serv_per_carton int,
    carton_quantity int,
    UNIQUE(inventory_id),
    UNIQUE(ingred_name)
);


CREATE TABLE IF NOT EXISTS item (
    item_id varchar PRIMARY KEY,
    item_name varchar,
    item_category varchar, 
    item_size varchar, 
    price float,
    UNIQUE(item_id)
);

CREATE TABLE IF NOT EXISTS recipe (
    row_id varchar PRIMARY KEY, 
    recipe_id varchar,
    inventory_id varchar,
    inventory_name varchar,
    recipe_servings float,
    CONSTRAINT fk_item_id1
        FOREIGN KEY (recipe_id) REFERENCES item(item_id), 
    CONSTRAINT fk_inventory_id
        FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    CONSTRAINT fk_ingred_name
        FOREIGN KEY (inventory_name) REFERENCES inventory(ingred_name)
);

CREATE TABLE IF NOT EXISTS transaction (
    trans_id varchar PRIMARY KEY,
    customer_id varchar, 
    time_of_day time, 
    transaction_total float,
    CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


CREATE TABLE IF NOT EXISTS transaction_item (
    transaction_item_id varchar PRIMARY KEY,
    trans_id varchar, 
    item_id varchar,
    quantity int,
    item_price float,
    CONSTRAINT fk_transaction_id
        FOREIGN KEY (trans_id) REFERENCES transaction(trans_id),
    CONSTRAINT fk_item_id2
        FOREIGN KEY (item_id) REFERENCES item(item_id)
);

