

# 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(film_id)
FROM inventory
WHERE film_id IN (SELECT film_id 
					FROM film
					WHERE title = "Hunchback Impossible" # Filtering 
)
;

# List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title 
FROM film
WHERE length > (SELECT AVG(length) FROM film);


# Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT *
FROM ACTOR 
WHERE actor_id IN (
					SELECT actor_id 
					FROM film_actor
					WHERE film_id IN (
										SELECT film_id
										FROM film
										WHERE title = "Alone Trip"
                                        )
					);
                    


# Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this
                
SELECT customer_id, SUM(amount) as total_amount
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(total_amount)
    FROM (
			SELECT SUM(amount) AS total_amount
			FROM payment
			GROUP BY customer_id
    ) AS each_client
);

