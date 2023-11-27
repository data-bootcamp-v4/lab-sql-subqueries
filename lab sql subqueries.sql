/* Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system. */

SELECT SUM(inventory_id) AS total_copies
FROM sakila.inventory
WHERE film_id = "Hunchback Impossible";


/* List all films whose length is longer than the average length of all the films in the Sakila database. */

SELECT film_id, title, length
FROM film
WHERE length > 
			( SELECT AVG(length)
            FROM film );
            

/* Use a subquery to display all actors who appear in the film "Alone Trip". */

SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id = 
						(SELECT film_id
						FROM film
						WHERE title = 'Alone Trip'
);


/* Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. */


SELECT film.film_id, film.title
FROM sakila.film
JOIN category ON category_id = category.category_id
WHERE category.name = 'Family';

/* Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys. */

SELECT first_name, last_name, email
FROM customer 
JOIN address ON customer.customer_id = customer.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.city = country.country
WHERE country.country = 'Canada';


/*  Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number 
of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in. */

SELECT CONCAT(first_name, ' ', last_name) AS actor_name, COUNT(*) AS number_of_movies
FROM sakila.actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor_name
ORDER BY number_of_movies DESC
LIMIT 1;


/* Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer,
 i.e., the customer who has made the largest sum of payments. */
 
SELECT customer_id, SUM(amount) AS total_payments
FROM sakila.payment
GROUP BY customer_id
ORDER BY total_payments DESC
LIMIT 1;
		(SELECT title 
		FROM customer 
		JOIN rental ON c.customer_id = customer_id
		JOIN inventory i ON r.inventory_id = i.inventory_id
		JOIN film ON i.film_id = film_id
		WHERE customer_id = customer_id
);

/*  Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the 
total_amount spent by each client. You can use subqueries to accomplish this. */

SELECT client_id, SUM(amount) AS total_amount_spent
FROM sakila.payment
GROUP BY client_id
HAVING SUM(amount) 



SHOW TABLES;

