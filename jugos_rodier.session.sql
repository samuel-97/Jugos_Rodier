-- Export Inventory, Item view and Customer View to csv

COPY v_customer 
TO '/home/srodier/repos/jugos_rodier/csvs/updated_views'
WITH
    DELIMITER ','
;