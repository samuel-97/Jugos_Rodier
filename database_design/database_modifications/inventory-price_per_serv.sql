-- Alter ‘Ingredients’ table to include virtual column ‘price_per_serv’

ALTER TABLE inventory
ADD COLUMN  price_per_serv FLOAT
    GENERATED ALWAYS AS (carton_price / serv_per_carton ) STORED
; 

SELECT * FROM inventory;