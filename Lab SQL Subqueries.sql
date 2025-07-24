# Challenge
# Write SQL queries to perform the following tasks using the Sakila database:

# 1: Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (SELECT film_id
				FROM film
				WHERE title = "Hunchback Impossible");

# 2: List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title
FROM film
WHERE length > (SELECT round(avg(length))
	FROM film);

# 3: Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
WHERE actor_id in (SELECT actor_id
				FROM film_actor
				WHERE film_id in (SELECT film_id
								FROM film
								WHERE title = "Alone Trip"));


