-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
USE sakila;
select * from film;
SELECT film_id FROM film
WHERE title = "Hunchback Impossible";

SELECT film_id, count(film_id) FROM inventory
WHERE film_id IN (SELECT film_id FROM film
WHERE title = "Hunchback Impossible")
GROUP BY film_id;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
-- average length

SELECT film_id, AVG(length) FROM film
GROUP BY film_id
HAVING AVG(length) > (SELECT round(AVG(length),2) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT film_id FROM film
WHERE title = "Alone Trip";

SELECT actor_id FROM film_actor
WHERE film_id in (SELECT film_id FROM film
WHERE title = "Alone Trip");

SELECT first_name, last_name FROM actor
WHERE actor_id in (SELECT actor_id FROM film_actor
WHERE film_id in (SELECT film_id FROM film
WHERE title = "Alone Trip"));

-- 4. Sales have been lagging among young families, 
-- and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT film_id, title FROM film
WHERE film_id IN (SELECT film_id FROM film_category
WHERE category_id IN (SELECT category_id FROM category
WHERE name = "Family"));

-- 5. Retrieve the name and email of customers from Canada
-- using both subqueries and joins. To use joins, you will need to identify
-- the relevant tables and their primary and foreign keys.

-- USING SUBQUERIY

SELECT customer_id, first_name, last_name, email, address_id from customer
WHERE address_id IN (SELECT address_id FROM address
WHERE city_id IN(SELECT city_id from city
WHERE country_id IN (SELECT country_id from country
WHERE country = "Canada")));
USE sakila;
-- USING JOINS

SELECT cu.customer_id, 
	   cu.first_name, 
       cu.last_name,
       cu.email,
       co.country
FROM ((
	customer as cu
	JOIN address as ad
	ON ad.address_id = cu.address_id )
	JOIN city as ci
	ON ci.city_id = ad.city_id )
JOIN country as co
ON co.country_id = ci.country_id
WHERE co.country = 'Canada';

-- 6. Determine which films were starred by the most prolific actor
-- in the Sakila database. A prolific actor is defined as the actor 
-- who has acted in the most number of films. First, you will need to find
-- the most prolific actor and then use that actor_id to find the different films that he or she starred in.


-- Most prolific actor
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY count(film_id) DESC
LIMIT 1;

-- film_id of the most profilic actor
SELECT film_id
FROM film_actor
WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
);
-- get the title of movies
SELECT film_id, title
FROM film
WHERE film_id in
(
SELECT film_id
FROM film_actor
WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
));

-- 7. Find the films rented by the most profitable customer
-- in the Sakila database. You can use the customer and payment 
-- tables to find the most profitable customer, i.e.,
--  the customer who has made the largest sum of payments.
-- a. findind the most profitable cutomer:
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC
LIMIT 1;

-- Finding the films rented by customer_id = 526
SELECT inventory_id
FROM rental
WHERE customer_id = 
	(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	ORDER BY sum(amount) DESC
	LIMIT 1
    );
    
SELECT film_id
FROM inventory
WHERE inventory_id IN
(
SELECT inventory_id
FROM rental
WHERE customer_id = 
	(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	ORDER BY sum(amount) DESC
	LIMIT 1
    )
    );

-- finding the title of films:
SELECT title
FROM film
WHERE film_id in
(
SELECT film_id
FROM inventory
WHERE inventory_id IN
(
SELECT inventory_id
FROM rental
WHERE customer_id = 
	(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	ORDER BY sum(amount) DESC
	LIMIT 1
    )
    ));
    
    -- 8. Retrieve the client_id and the total_amount_spent
    -- of those clients who spent more than the average of the total_amount
    -- spent by each client. You can use subqueries to accomplish this.
    
    -- a. finding the average of the total amount:
    SELECT round(AVG(amount), 2) as average_amount
    FROM payment;
    
    -- list of customer with payment > average amount
    SELECT customer_id, sum(amount) as total_per_customer
    FROM payment
    GROUP BY customer_id
    HAVING 
    total_per_customer > (SELECT round(AVG(amount), 2) as average_amount
									FROM payment)
	;
    
