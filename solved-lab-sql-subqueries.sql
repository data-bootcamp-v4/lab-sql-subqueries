# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(DISTINCT inventory_id) AS number_of_copies
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE title = "Hunchback Impossible";

# The avobe code is using joins. This exercise asks to use subqueries. See code below.
SELECT COUNT(inventory_id) AS number_of_copies
FROM inventory
WHERE film_id = ( SELECT film_id
						FROM film
						WHERE title = "Hunchback Impossible" ) ;

# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
# END RESULT
SELECT title
FROM film
WHERE length > ( SELECT AVG(LENGTH) as avg_length
					from film ) ;

# LIST ALL FILMS
SELECT title
FROM film;

# LIST ALL FILMS WHOSE LENGTH IS LONGER THAN 120 MIN.
SELECT title
FROM film
WHERE length > 120;

# RETRIEVE the average length of all the films in the Sakila database.
SELECT AVG(LENGTH) as avg_length
from film;

#3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
USING (actor_id)
WHERE film_id = ( SELECT film_id
					FROM film
					WHERE title = "Alone Trip" );
                    
# 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT title
FROM film
WHERE film_id IN ( 	SELECT film_id
					FROM film_actor
					WHERE actor_id = ( SELECT actor_id
										from film_actor
										GROUP BY actor_id
										ORDER BY COUNT(film_id) DESC
										LIMIT 1 )) ;
                                        
# 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
# above_average_spenders

SELECT customer_id, SUM(amount) AS tspc
FROM payment
GROUP BY customer_id
HAVING tspc > ( SELECT AVG(ts)
					FROM 	(SELECT SUM(amount) ts
					FROM payment
					GROUP BY customer_id) AS spent );
###############

SELECT AVG(ts)
FROM 	(SELECT SUM(amount) ts
		FROM payment
		GROUP BY customer_id) AS spent;