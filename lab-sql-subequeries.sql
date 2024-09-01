USE SAKILA; 

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT film.title, COUNT(inventory.inventory_id) AS number_of_copies
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible'
GROUP BY film.title;


-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT f.title, f.length FROM film AS f 
WHERE length > (SELECT avg(length) FROM film)

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    WHERE film_actor.film_id = (
        SELECT film.film_id 
        FROM film 
        WHERE film.title = 'Alone Trip'
    )
);