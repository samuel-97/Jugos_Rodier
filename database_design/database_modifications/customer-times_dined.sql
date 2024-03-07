-- Create view that includes num customer transactions

CREATE VIEW v_customer AS

WITH customer_names AS (
        SELECT c.customer_id                             AS id,
               CONCAT(c.first_name, c.last_name)         AS cname,
               COUNT(tr.customer_id)                     AS times_dined
        
        FROM transaction tr
        JOIN customer AS c ON tr.customer_id = c.customer_id

        GROUP BY id, cname
)

SELECT customer.customer_id,
       cname,
       customer.address,
       customer.sec_address,
       customer.city,
       customer.zipcode, 
       customer.state,
       times_dined
FROM customer_names
JOIN customer 
    ON customer_names.id = customer.customer_id
;