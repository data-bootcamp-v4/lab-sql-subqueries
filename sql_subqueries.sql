use sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT count(*)
FROM inventory
WHERE film_id = (
	SELECT film_id
    FROM film
    WHERE title = "Hunchback Impossible"
    );
    
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database
SELECT title, length 
FROM film 
WHERE length>(
	SELECT AVG(length) 
    FROM film);
    
-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name as actor
	FROM actor
    WHERE actor_id IN(
		SELECT actor_id
        FROM film_actor
        WHERE film_id = (
			SELECT film_id
            FROM film
            WHERE title = "Alone Trip")
            );
       
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- 6. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT 
    c.first_name, 
    c.last_name, 
    c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
