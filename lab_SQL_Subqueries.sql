USE sakila;

-- 1 Number of copies of the film "Hunchback Impossible"
SELECT COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f
	ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';


-- 2 All films whose length is longer than the average length of all the films in the Sakila database
SELECT f.title,
	   f.length
FROM film f
WHERE f.length > (
	SELECT AVG(length)
    FROM film
    )
ORDER BY f.length DESC;


-- 3 Subquery to display all actors who appear in the film "Alone Trip"
SELECT first_name
	   last_name
FROM actor
WHERE actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f
        ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
)
ORDER BY last_name, first_name;
