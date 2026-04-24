USE sakila;

-- 1: Count copies of "Hunchback Impossible" in inventory
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

-- 2: Films longer than average film length
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- 3: Actors appearing in "Alone Trip"
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