# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory_id)
FROM inventory 
WHERE film_id = (SELECT film_id
				FROM film
				WHERE title = "Hunchback Impossible");

# List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
				FROM film)
ORDER BY length DESC;

# Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name
FROM actor 
WHERE actor_id in (SELECT actor_id
					FROM film_actor
					WHERE film_id = (SELECT film_id
									FROM film
									WHERE title = "Alone Trip"));





