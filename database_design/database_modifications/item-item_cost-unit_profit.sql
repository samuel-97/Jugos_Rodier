-- Create view that calculates cost and unit profit for each menu item


CREATE OR REPLACE VIEW v_item AS

WITH cost AS
(SELECT recipe.recipe_id,
        SUM(inventory.price_per_serv * recipe.recipe_servings)  AS item_cost
FROM recipe
JOIN inventory 
    ON recipe.inventory_id = inventory.inventory_id
GROUP BY recipe.recipe_id
)

SELECT i.item_id,
       i.item_name,
       i.item_category,
       i.item_size,
       i.price,
       item_cost, 
       (i.price - item_cost)                    AS unit_profit
FROM cost
JOIN item i  
    ON i.item_id = cost.recipe_id
;

SELECT * FROM v_item;