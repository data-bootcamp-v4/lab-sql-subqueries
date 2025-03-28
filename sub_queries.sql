USE sakila;

/* Write SQL queries to perform the following tasks using the Sakila database:

1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
2. List all films whose length is longer than the average length of all the films in the Sakila database.
3. Use a subquery to display all actors who appear in the film "Alone Trip".

*/

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title, COUNT(i.inventory_id) AS availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Hunchback Impossible'
GROUP BY 
    f.title; 
    
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
-- JOINING the table: actor, film and film_actor
-- Actor: actor_id, first_name, last_name
-- film: film_id, title
-- film_actor: film_id, actor_id

SELECT 
    first_name, last_name
FROM
    actor a
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
                    

-- Bonus:
SELECT f.title AS 'Movie Title'
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Family';

-- Bonus: Retrieve the name and email of customers from Canada using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

-- Using subqueries
SELECT 
    first_name, last_name, email
FROM
    customer
WHERE
    address_id IN (SELECT 
            address_id
        FROM
            address
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    city
                WHERE
                    country_id = (SELECT 
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'Canada')));

-- Using joins
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
