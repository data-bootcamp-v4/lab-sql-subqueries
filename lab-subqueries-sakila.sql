USE sakila;

# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT * FROM film;
SELECT * FROM inventory;

SELECT film_id
FROM film
WHERE title = "Hunchback Impossible";

SELECT COUNT(*)
FROM inventory
WHERE film_id = (
	SELECT film_id
	FROM film
	WHERE title = "Hunchback Impossible"
);

# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT AVG(length)
FROM film;

SELECT title, length
FROM film
WHERE length > (
	SELECT AVG(length)
	FROM film
);

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT * FROM film; -- film_id
SELECT * FROM film_actor; -- actor_id, film_id
SELECT * FROM actor; -- actor_id

-- Find "Alone Trip"
SELECT film_id
FROM film
WHERE title = "Alone Trip";

-- Who acted in film 17
SELECT actor_id
FROM film_actor
WHERE film_id = 17;

-- Find actors
SELECT *
FROM actor
WHERE actor_id IN (
    SELECT actor_id
	FROM film_actor
	WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
    )
);




