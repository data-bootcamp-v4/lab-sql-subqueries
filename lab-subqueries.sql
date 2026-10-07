USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(inventory_id) AS copy_number FROM inventory
WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, ROUND(AVG(length)) AS avg_duration
FROM film
GROUP BY title
HAVING avg_duration > (SELECT AVG(length) FROM film)
ORDER BY avg_duration;

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Alone Trip'));

-- Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.

SELECT title FROM film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id IN (SELECT category_id FROM category WHERE name = 'Family'));

-- Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT 
    customer_id, first_name, last_name, email
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
                    city AS ci
                        LEFT JOIN
                    country AS co ON ci.country_id = co.country_id
                WHERE
                    co.country = 'Canada'));


-- Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_actor
        WHERE
            actor_id = (SELECT 
                    actor_id
                FROM
                    film_actor
                GROUP BY actor_id
                ORDER BY COUNT(film_id) DESC
                LIMIT 1));

