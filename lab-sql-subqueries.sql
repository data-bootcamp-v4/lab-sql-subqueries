USE Sakila;

-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS num_copies
FROM film
JOIN inventory USING (film_id)
WHERE title = "HUNCHBACK IMPOSSIBLE";

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (
SELECT AVG(length) FROM film
);

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor
FROM (
    SELECT fa.film_id, fi.title, fa.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor
    FROM film_actor AS fa
    JOIN actor AS a ON fa.actor_id = a.actor_id
    JOIN film AS fi ON fa.film_id = fi.film_id
) AS S
WHERE title = 'ALone Trip';

-- 4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT f.film_id, f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';




