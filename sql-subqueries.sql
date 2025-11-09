-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
USE sakila;
SELECT * FROM inventory;
SELECT * FROM film;
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database
SELECT title, length
FROM film
WHERE length > (
    SELECT ROUND(AVG(length), 2)
    FROM film
);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT 
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name
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

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM film;

SELECT title, film_id
	FROM film
	WHERE film_id IN (
		SELECT film_id
		FROM film_category
		WHERE category_id = 
        (SELECT category_id
			FROM category
			WHERE name = "Family"
			)
		);
        
-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys
SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT 
    c.first_name,
    c.last_name,
    c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country_id = (
    SELECT country_id
    FROM country
    WHERE country = 'Canada'
);

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT * FROM film;
SELECT * FROM film_actor;

SELECT f.title
FROM film f
JOIN film_actor fa 
ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);

-- 7.Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, 
-- i.e., the customer who has made the largest sum of payments.
SELECT f.title                      
FROM film f
JOIN inventory i ON f.film_id = i.film_id      
JOIN rental r ON i.inventory_id = r.inventory_id  
WHERE r.customer_id = (
  SELECT customer_id                
    FROM payment                      
    GROUP BY customer_id              
    ORDER BY SUM(amount) DESC         
    LIMIT 1                          
);