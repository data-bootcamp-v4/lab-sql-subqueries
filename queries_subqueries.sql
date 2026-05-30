-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".
-- Bonus:

-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
	-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, 
	-- i.e., the customer who has made the largest sum of payments.
-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

USE sakila;

SELECT count(inventory_id) 
FROM inventory 
WHERE film_id = (
	SELECT film_id 
    FROM film 
    WHERE title="Hunchback Impossible");

SELECT title 
FROM film 
WHERE length>(
	SELECT AVG(length) 
    FROM film);

SELECT
	first_name,
    last_name as actor 
FROM actor 
WHERE actor_id IN (
	SELECT af.actor_id 
    FROM film_actor as af 
    INNER JOIN film as f 
		ON af.film_id=f.film_id 
	WHERE title="Alone Trip");  

SELECT title 
FROM film 
WHERE film_id in (
	SELECT fc.film_id 
    FROM film_category as fc 
    JOIN category as c 
		ON c.category_id=fc.category_id 
	WHERE name='Family') ;

SELECT 
	concat(first_name,' ' ,last_name), 
    email 
FROM customer 
WHERE address_id IN (
	SELECT DISTINCT(a.address_id) 
    FROM address as a 
    INNER JOIN city as c 
		ON a.city_id=c.city_id 
	INNER JOIN country as co 
		ON c.country_id=co.country_id 
	WHERE co.country='Canada');

SELECT f.title 
FROM film as f 
INNER JOIN film_actor as fa 
	ON f.film_id=fa.film_id 
WHERE fa.actor_id = (
	SELECT actor_id 
    FROM film_actor 
    GROUP BY actor_id 
    ORDER BY count(film_id) DESC
    LIMIT 1);

SELECT f.title 
FROM film as f 
INNER JOIN inventory as i 
	ON f.film_id=i.film_id 
inner join rental as r 
	ON i.inventory_id=r.inventory_id 
WHERE customer_id =(
	SELECT customer_id 
    FROM payment 
    GROUP BY customer_id 
    ORDER BY sum(amount) DESC 
    LIMIT 1);

SELECT sum(amount) as total_amount 
FROM payment 
GROUP BY customer_id;

SELECT 
	customer_id as client_id, 
    sum(amount) as total_amount_spent 
FROM payment 
GROUP BY customer_id 
HAVING sum(amount) > (
		SELECT avg(total_amount) 
        FROM (
			SELECT sum(amount) as total_amount 
			FROM payment 
            GROUP BY customer_id) 
		as tas);