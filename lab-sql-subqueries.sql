-- ## Introduction

-- Welcome to the SQL Subqueries lab!

-- In this lab, you will be working with the [Sakila](https://dev.mysql.com/doc/sakila/en/) database on movie rentals. Specifically, you will be practicing how to perform subqueries, which are queries embedded within other queries. Subqueries allow you to retrieve data from one or more tables and use that data in a separate query to retrieve more specific information.

-- ## Challenge

-- Write SQL queries to perform the following tasks using the Sakila database:

USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(i.film_id) AS num_of_copies FROM inventory AS i
WHERE i.film_id = (SELECT film_id FROM film AS f WHERE f.title = "Hunchback Impossible");

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT * FROM film AS f
WHERE f.length > (SELECT AVG(film.length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT * FROM sakila.actor AS a
WHERE a.actor_id IN (
					SELECT fa.actor_id FROM sakila.film_actor AS fa 
                    JOIN sakila.film AS f ON fa.film_id = f.film_id 
                    WHERE f.title = "Alone Trip");


-- **Bonus**:

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
	-- Identify all movies categorized as family films. 
-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
	-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
	-- A prolific actor is defined as the actor who has acted in the most number of films. 
	-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- 7. Find the films rented by the most profitable customer in the Sakila database. 
	-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
	-- You can use subqueries to accomplish this.