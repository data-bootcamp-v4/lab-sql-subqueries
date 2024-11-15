-- Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(inventory_id) AS copy_count
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT CONCAT(first_name, " ", last_name) AS name FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor 
	WHERE film_id IN (
		SELECT film_id FROM film
		WHERE title="ALONE TRIP")
);

-- Bonus:
-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT title FROM film
WHERE film_id IN (
	SELECT film_id FROM film_category 
	WHERE category_id IN (
		SELECT category_id FROM category
		WHERE name="Family")
);


-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT CONCAT(first_name, " ", last_name) AS name, email FROM customer 
WHERE address_id IN (
	SELECT address_id FROM address AS a
    JOIN city AS c
    ON a.city_id=c.city_id
    JOIN country as co
    ON c.country_id=co.country_id 
    WHERE co.country="Canada");

    -- Determine which films were starred by the most prolific actor in the Sakila database. 
    -- A prolific actor is defined as the actor who has acted in the most number of films. 
    -- First, you will need to find the most prolific actor and then use that actor_id to find the different 
    -- films that he or she starred in.
    
 SELECT title FROM film 
 WHERE film_id IN (SELECT film_id FROM film_actor 
 WHERE actor_id = (SELECT actor_id FROM film_actor 
 GROUP BY actor_id
 ORDER BY count(film_id) DESC LIMIT 1)
 );   
 
 
    Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
    Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
