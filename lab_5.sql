-- Question 1
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS n_copies
FROM sakila.inventory
WHERE film_id = (SELECT film_id FROM sakila.film WHERE title = "HUNCHBACK IMPOSSIBLE");

-- Question 2
-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT * FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film);

-- Question 3
-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);
