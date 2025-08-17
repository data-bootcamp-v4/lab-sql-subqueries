-- 1) Number of copies of the film "Hunchback Impossible"
SELECT COUNT(*)
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

-- 2) List all films whose length is longer than the average length
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(sub.length)
    FROM (
        SELECT length
        FROM film
    ) AS sub
);

-- 3) Display all actors who appear in the film "Alone Trip"
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);