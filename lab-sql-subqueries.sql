USE sakila; 

-- 1
SELECT COUNT(inventory_table.inventory_id) As number_of_copies
FROM film film_table
JOIN inventory inventory_table ON film_table.film_id = inventory_table.film_id
WHERE film_table.title = "HUNCHBACK IMPOSSIBLE";

-- 2.
SELECT title, length
FROM film
WHERE length > (
SELECT AVG(length)
FROM film );

-- 3.
SELECT 
actor_table.first_name,
actor_table.last_name
FROM actor actor_table
JOIN film_actor film_actor_table
ON actor_table.actor_id = film_actor_table.actor_id
WHERE film_actor_table.film_id = (
SELECT film_id
FROM film 
WHERE title = "ALONE TRIP" );

