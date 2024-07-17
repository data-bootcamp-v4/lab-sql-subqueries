USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(i.inventory_id) AS inventory
FROM inventory i
WHERE i.film_id IN (SELECT f.film_id FROM film f WHERE f.title = "Hunchback Impossible");

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT f.title FROM film f WHERE f.length > (SELECT AVG(f2.length) FROM film f2); 

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.actor_id IN (SELECT 
            fa.actor_id
        FROM
            film_actor fa
                JOIN
            film f ON fa.film_id = f.film_id
        WHERE
            f.title = 'Alone Trip');