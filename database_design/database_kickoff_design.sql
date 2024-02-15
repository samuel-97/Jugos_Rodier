CREATE TABLE customer (
    customer_id PRIMARY KEY,
    first_name varchar,
    last_name varchar,
    address varchar, 
    sec_address varchar NULL,
    zipcode varchar,
    city varchar,
    state varchar,
    country varchar
);

CREATE TABLE inventory (
    inventory_id PRIMARY KEY,
    ingred_name varchar,
    bushel_price float,
    serv_per_bushel int,
    inv_quantity int
);


CREATE TABLE item (
    item_id PRIMARY KEY,
    item_name varchar,
    item_category varchar, 
    item_size varchar, 
    price float
);

CREATE TABLE  recipe (
    row_id PRIMARY KEY, 
    item_id varchar,
    inventory_id varchar,
    inventory_name varchar,
    recipe_servings float
    FOREIGN KEY (item_id) REFERENCES item(item_id)
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
    FOREIGN KEY (inventory_name) REFERENCES inventory(ingred_name)
);

CREATE TABLE transaction (
    transaction_id PRIMARY KEY,
    customer_id varchar, 
    time_of_day datetime, 
    transaction_total float
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


CREATE TABLE transaction_item (
    transaction_item_id PRIMARY KEY,
    transaction_id varchar, 
    item_id varchar,
    quantity int,
    item_price float 
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
    FOREIGN KEY (item_id) REFERENCES item(item_id)
    FOREIGN KEY (item_price) REFERENCES item(price)
);

