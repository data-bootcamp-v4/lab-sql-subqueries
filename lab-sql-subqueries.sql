#Challenge
Use Sakila;
# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
#I need to connect film and inventory and count the copies.
SELECT 
	film.title,
    COUNT(inventory.film_id) AS number_of_copies
FROM inventory
JOIN film
ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible'
GROUP BY film.title;

SELECT 
    title,
    (SELECT COUNT(*)
     FROM inventory
     WHERE inventory.film_id = film.film_id) AS number_of_copies
FROM film
WHERE title = 'Hunchback Impossible';
# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
#All (*) films where film.length > AVG length from film.length.
SELECT 
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);
# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
# ALL (*) actors where "Alone Trip"
SELECT 
    film.title,
    actor.first_name,
    actor.last_name
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id
WHERE film.title = 'Alone Trip';
#subquery version
SELECT 
    film.title,
    actor.first_name,
    actor.last_name
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id
WHERE film_actor.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'
);