USE sakila;   -- Selecting the sakila database
-- Counting how many copies of the film exist in the inventory
SELECT 
    COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
);
-- Showing all films whose length is greater than the average length of all films
SELECT 
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film
);
-- Retrieving all actors who acted in the film "Alone Trip"
SELECT 
    a.first_name,
    a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id 
        FROM film 
        WHERE title = 'Alone Trip'
    )
);
