-- How many transactions are recorded? 

SELECT  COUNT(trans_id)
FROM transaction;

-------------------------------------------


-- What are our 10 most popular items?

SELECT transaction_item.item_id AS id, item.item_name AS name, 
        SUM(transaction_item.quantity) AS quantity
FROM transaction_item
JOIN item ON transaction_item.item_id = item.item_id
GROUP BY id, name
ORDER BY quantity DESC
LIMIT 10
;


-------------------------------------------


-- Most popular item categories? 

SELECT item.item_category AS category,
        SUM(transaction_item.quantity) AS quantity
FROM transaction_item
JOIN item ON transaction_item.item_id = item.item_id
GROUP BY category
ORDER BY quantity DESC
LIMIT 10
;


-------------------------------------------


-- Total Revenue:

SELECT SUM(quantity * item_price) AS Revenue
FROM transaction_item
;


-------------------------------------------


-- Average Cost per Transaction: 
SELECT AVG(transaction_total)
FROM transaction
;


--------------------------------------------


-- What is the most money a customer has spent with us on a single transaction?

SELECT  CONCAT(c.first_name, c.last_name)    AS fname,
        MAX(tr.transaction_total)            AS amount

FROM transaction tr
JOIN customer c ON tr.customer_id = c.customer_id
GROUP BY fname
ORDER BY amount DESC
LIMIT 1
;


-------------------------------------------


--  What proportion of our customers has dined with us more than 2 times? 

WITH customer_names AS (
        SELECT c.customer_id                             AS id,
               CONCAT(c.first_name, c.last_name)         AS cname,
               COUNT(tr.customer_id)                     AS times_dined
        
        FROM transaction tr
        JOIN customer AS c ON tr.customer_id = c.customer_id

        GROUP BY id, cname
),

customer_frequency AS (
        SELECT cname,
               CASE
                   WHEN times_dined > 2 THEN 1
                   ELSE 0
                   END AS loyalty
        FROM customer_names
)

SELECT  AVG(loyalty)                                    AS prcnt_repeat

FROM customer_frequency
;

-------------------------------------------

-- What is the average number of items purchased?

SELECT AVG(item)
FROM
        (SELECT trans_id, SUM(quantity) AS item
        FROM transaction_item
        GROUP BY trans_id) AS subquery
;


-------------------------------------------


--Counts for breakfast, lunch and dinner? 
        --morning 9-12
        --afternoon 12-15
        --evening 15-18:30

WITH timeday AS ( 
        SELECT CASE
           WHEN time_of_day BETWEEN '12:00:00' AND '15:00:00'
           THEN 'Morning'
           
           WHEN time_of_day BETWEEN '15:00:00' AND '20:00:00'
           THEN 'Afternoon'

           ELSE 'Evening'
        END AS class
        FROM transaction t) 
        
SELECT class, COUNT(class)
FROM timeday
GROUP BY class 
;


----------------------------------------


-- How much does each item cost to make?

WITH 

price_serv AS (

        SELECT i.carton_price / i.serv_per_carton       AS price_per_serv,
                recipe.recipe_id, 
                recipe.recipe_servings

        FROM inventory i
        JOIN recipe ON i.inventory_id = recipe.inventory_id)

SELECT item.item_name                                   AS name,
       recipe_id,
       SUM(price_per_serv * recipe_servings)            AS item_cost

FROM price_serv
JOIN item ON item.item_id = price_serv.recipe_id
GROUP BY item_name, price_serv.recipe_id, item.price
;


-------------------------------------------


-- How much profit do we make for each item?

WITH 

price_serv AS (

        SELECT  i.carton_price / i.serv_per_carton      AS price_per_serv,
                recipe.recipe_id, 
                recipe.recipe_servings

        FROM inventory i
        JOIN recipe ON i.inventory_id = recipe.inventory_id
        ),

costs AS (

        SELECT  item.item_name                          AS name,
                recipe_id,
                SUM(price_per_serv * recipe_servings)   AS item_cost,
                item.price                              AS price

        FROM price_serv
        JOIN item ON item.item_id = price_serv.recipe_id
        GROUP BY item_name, price_serv.recipe_id, item.price)

SELECT name,
       recipe_id,
       SUM(price - item_cost) AS item_profit
FROM costs
GROUP BY recipe_id, name, item_cost
;


-------------------------------------------


-- What is our Overall profit (before labor)?

WITH 

price_serv AS (

        SELECT i.carton_price / i.serv_per_carton       AS price_per_serv,
                recipe.recipe_id, 
                recipe.recipe_servings

        FROM inventory i
        JOIN recipe ON i.inventory_id = recipe.inventory_id
        
        ),

costs AS (

        SELECT item.item_name                          AS name,
               recipe_id,
               SUM(price_per_serv * recipe_servings)   AS item_cost,
               item.price                              AS price

        FROM price_serv
        JOIN item ON item.item_id = price_serv.recipe_id
        GROUP BY item_name, price_serv.recipe_id, item.price

        ),

profits AS (
        SELECT name,
               recipe_id,
               SUM(price - item_cost)                 AS item_profit
        FROM costs
        GROUP BY recipe_id, name, item_cost

        ), 

t_prof AS (

        SELECT  ti.trans_id,
                SUM(ti.quantity * p.item_profit)     AS trans_profit
                
        FROM profits p
        JOIN transaction_item ti ON p.recipe_id = ti.item_id 
        GROUP BY trans_id
)


SELECT SUM(t_prof.trans_profit)                      AS overall_profit
FROM t_prof 
;


----------------------------------------------


-- profit by category: 

WITH 

price_serv AS (

        SELECT i.carton_price / i.serv_per_carton     AS price_per_serv,
                recipe.recipe_id, 
                recipe.recipe_servings

        FROM inventory i
        JOIN recipe ON i.inventory_id = recipe.inventory_id),

costs AS (

        SELECT item.item_name                         AS name,
                recipe_id,
                SUM(price_per_serv * recipe_servings) AS item_cost,
                item.price as price

        FROM price_serv
        JOIN item ON item.item_id = price_serv.recipe_id
        GROUP BY item_name, price_serv.recipe_id, item.price),

profits AS (

        SELECT name,
               recipe_id,
               SUM(price - item_cost)                  AS item_profit
        FROM costs
        GROUP BY recipe_id, name, item_cost
        ),

i AS (

        SELECT  ti.trans_id                           AS id,
                p.recipe_id                           AS rec,
                (ti.quantity * p.item_profit)         AS profit1
                
        FROM profits p
        JOIN transaction_item ti ON p.recipe_id = ti.item_id)


SELECT  item.item_category                            AS category,
        SUM(profit1)                                  AS profit

FROM i 
JOIN item ON i.rec = item.item_id
GROUP BY item.item_category
;

