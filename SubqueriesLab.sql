/* 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.*/
SELECT COUNT(*) AS num_copies
FROM sakila.inventory
WHERE film_id = 
     (SELECT film_id
     FROM sakila.film
     WHERE title = 'Hunchback Impossible');

/* 2. List all films whose length is longer than the average length of all the films in the Sakila database.*/
SELECT title AS longer_films
FROM sakila.film
WHERE length > 
     (SELECT AVG(length)
     FROM sakila.film);

/* 3. Use a subquery to display all actors who appear in the film "Alone Trip".*/
SELECT CONCAT(actor.first_name, " ", actor.last_name) AS actors_alonetrip
FROM sakila.actor
INNER JOIN 
(SELECT actor_id 
FROM film_actor
INNER JOIN (      
			SELECT film_id FROM sakila.film
			WHERE film.title = 'Alone Trip') selected_film            
ON selected_film.film_id = film_actor.film_id) selected_actors
ON actor.actor_id = selected_actors.actor_id;

/* 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family
 films.*/
SELECT film.film_id, film.title, category.name AS family_category
FROM sakila.film
JOIN sakila.film_category ON film.film_id = film_category.film_id
JOIN sakila.category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

/* 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant
 tables and their primary and foreign keys.*/

/* To use joins, we need to connect the relevant tables using their primary and foreign keys:

customer table connects to the address table through the address_id column.
address table connects to the city table through the city_id column.
city table connects to the country table through the country_id column. */

SELECT first_name, last_name, email
FROM sakila.customer
WHERE address_id IN 
	(SELECT address_id
	FROM sakila.address
	WHERE city_id IN 
		(SELECT city_id
		FROM sakila.city
		WHERE country_id IN 
			(SELECT country_id
			FROM sakila.country
			WHERE country = 'Canada')));


/* 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted
 in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that 
 he or she starred in.*/
 
 /* Finding the most prolific actor */
SELECT actor_id, COUNT(*) AS film_count
FROM sakila.film_actor
GROUP BY actor_id
ORDER BY film_count DESC;

/* Find the films he or she starred in */
SELECT film.film_id, film.title
FROM sakila.film
JOIN sakila.film_actor ON sakila.film.film_id = film_actor.film_id
WHERE film_actor.actor_id = '107';

/* 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most
 profitable customer, i.e., the customer who has made the largest sum of payments.*/
SELECT film.title
FROM sakila.film
JOIN sakila.inventory ON film.film_id = inventory.film_id
JOIN sakila.rental ON inventory.inventory_id = rental.inventory_id
JOIN sakila.payment ON rental.rental_id = payment.rental_id
WHERE sakila.rental.customer_id = (
    -- Subquery to find the most profitable customer
    SELECT customer_id
    FROM sakila.payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1);

/* 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
You can use subqueries to accomplish this.*/



