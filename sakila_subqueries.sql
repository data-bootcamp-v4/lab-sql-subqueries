USE sakila;

SELECT i.film_id, f.title, COUNT(i.film_id)
FROM inventory i
JOIN film f
ON f.film_id = i.film_id
GROUP BY 1,2
HAVING f.title LIKE 'Hunchback Impossible';

SELECT f.title, f.length
FROM film f
WHERE f.length > (SELECT AVG(length) FROM film );

SELECT fa.actor_id, a.first_name, a.last_name
FROM film_actor fa
JOIN actor a
ON fa.actor_id = a.actor_id
WHERE fa.film_id IN (SELECT film_id FROM film WHERE title = 'Alone Trip');

SELECT film_id, title
FROM film
WHERE film_id IN ( SELECT film_id FROM film_list WHERE category = 'Family');


SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a
ON a.address_id = c.address_id
WHERE c.address_id IN (SELECT address_id FROM address aa JOIN city cc ON aa.city_id = cc.city_id JOIN country co ON cc.country_id = co.country_id WHERE co.country = 'Canada')
;


## Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
##First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
WITH cte AS (SELECT actor_id, COUNT(*) as nr_of_movies
					FROM film_actor
					GROUP BY 1
					ORDER BY nr_of_movies DESC
					LIMIT 1)
SELECT c.actor_id, f.title
FROM cte c
LEFT JOIN film_actor fa
ON c.actor_id = fa.actor_id
LEFT JOIN film f
ON fa.film_id = f.film_id;


## Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 

SELECT customer_id, SUM(amount) as total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(amount) FROM payment);

## Find the films rented by the most profitable customer in the Sakila database. 
##You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
## TOP 10 Customers with highest payment per rental

WITH cte AS(SELECT customer_id, SUM(amount)/COUNT(rental_id) as payment_per_rental
FROM payment
GROUP BY 1
ORDER BY payment_per_rental DESC
LIMIT 10)

SELECT DISTINCT f.title
FROM cte c
LEFT JOIN rental r
ON c.customer_id = r.customer_id 
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id;