SHOW TABLES;

##1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT t.title, COUNT(*) AS no_of_copies FROM
(SELECT iv.inventory_id, iv.film_id, category_id, f.title FROM inventory iv
LEFT JOIN film_category fct
ON iv.film_id=fct.film_id
LEFT JOIN film f 
ON iv.film_id=f.film_id
) t
LEFT JOIN category c 
ON t.category_id=c.category_id
GROUP BY t.title
HAVING title="Hunchback Impossible"
;

##2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length FROM film
WHERE length >
	(
	SELECT AVG(length) as avg_film_length FROM film)
;
    
##3. Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT tt.actor_id, tt.first_name, tt.last_name FROM
(SELECT f.title, fa.actor_id, a.first_name, a.last_name FROM film f
LEFT JOIN film_actor fa
ON f.film_id=fa.film_id
JOIN actor a 
ON fa.actor_id=a.actor_id
) tt
WHERE title="Alone Trip";

## BONUS

##4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT * FROM
(SELECT f.title, c.name FROM film f
LEFT JOIN film_category fc
ON f.film_id=fc.film_id
JOIN category c 
ON fc.category_id=c.category_id) tt
WHERE tt.name="family"
;

##5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT tt.cust_name, tt.email, cc.country FROM 
(SELECT CONCAT(c.first_name, " ",c.last_name) AS cust_name, c.email, cty.country_id  FROM customer c 
LEFT JOIN address a 
ON c.address_id=a.address_id
LEFT JOIN city cty 
ON a.city_id=cty.city_id) AS tt
LEFT JOIN country cc 
ON tt.country_id=cc.country_id
WHERE cc.country="Canada"
;

##6. Determine which films were starred by the most prolific actor in the Sakila database.
SELECT * FROM (select CONCAT(first_name," ",last_name) AS actor_name, a.actor_id, COUNT(fa.film_id) AS no_of_films FROM actor a 
LEFT JOIN film_actor fa
ON a.actor_id=fa.actor_id
GROUP BY a.actor_id
ORDER BY no_of_films DESC
LIMIT 1) AS tt 
INNER JOIN film_actor faa
ON tt.actor_id= faa.actor_id
INNER JOIN film f 
ON faa.film_id=f.film_id
;

##7. Find the films rented by the most profitable customer in the Sakila database.
SELECT tt.cust_name, f.title FROM 
(SELECT CONCAT(first_name," ",last_name) AS cust_name, c.customer_id, SUM(p.amount) AS cust_revenue FROM payment p 
LEFT JOIN customer c 
ON p.customer_id=c.customer_id
GROUP BY c.customer_id
ORDER BY cust_revenue DESC
LIMIT 1) tt
LEFT JOIN rental r 
ON tt.customer_id=r.customer_id
LEFT JOIN inventory iv 
ON r.inventory_id=iv.inventory_id
LEFT JOIN film f
ON iv.film_id=f.film_id
;

##8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
SELECT customer_id, SUM(amount) AS total_amt_spent FROM payment 
GROUP BY customer_id
HAVING total_amt_spent > (
SELECT ROUND(AVG(tt.avg_total_amt_spent),2) AS average_total_amount_spent_each_client FROM (
SELECT customer_id, SUM(amount) AS avg_total_amt_spent FROM payment
GROUP BY customer_id ) AS tt) 
;
