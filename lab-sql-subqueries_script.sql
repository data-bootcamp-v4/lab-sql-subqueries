USE sakila;

# Task 1
# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

#SELECT first_name
#FROM actor
#WHERE actor_id IN (SELECT actor_id
#					FROM film_actor AS fa
#					WHERE film_id = (SELECT film_id ## instead of IN (1,2,3)
#									FROM film AS f
#									WHERE title = "FORWARD TEMPLE")); ## instead of 2


SELECT COUNT(inventory_id) as amount
FROM inventory
WHERE film_id IN (SELECT film_id
				FROM film
				WHERE title in ("Hunchback Impossible"));

#SELECT film_id
#FROM film
#WHERE title in ("Hunchback Impossible");

# Task 2
# List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
				FROM film)
ORDER BY length DESC;

# Task 3
# Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id = (SELECT film_id
									FROM film
                                    WHERE title = "ALONE TRIP"));

#SELECT *
#FROM actor
#WHERE actor_id IN ()