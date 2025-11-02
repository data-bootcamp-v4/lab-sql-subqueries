-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT 
    'Hunchback Impossible' AS title,
    COUNT(*) AS total_copies
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
);

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT f.title, f.length
FROM film f
WHERE f.length > (
    SELECT AVG(fi.length)
    FROM film fi
);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id = (
        SELECT f.film_id
        FROM film f
        WHERE f.title = 'Alone Trip'
    )
);

