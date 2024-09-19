USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title as titles, count(i.inventory_id) as nro_inventory
FROM inventory i
LEFT JOIN film f ON i.film_id = f.film_id
WHERE f.title = "Hunchback Impossible"
GROUP BY titles;

-- 2.List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT * 
FROM film
WHERE length > (SELECT avg(length) FROM film)
;

-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.first_name, a.last_name
FROM actor a 
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (
SELECT film_id
FROM film
WHERE title = "Alone Trip");