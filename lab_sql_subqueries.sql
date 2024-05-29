USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS number_of_copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select f.film_id, f.title, f.length from film as f
where f.length > (select avg(length) from film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor AS fa
    JOIN film AS f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip');

-- **Bonus**:

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. 
SELECT f.title
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT c.first_name, c.last_name, c.email
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- 6. Determine which films were starred by the most prolific actor in the Sakila database.
--  A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and 
-- then use that actor_id to find the different films that he or she starred in.
SELECT fa.actor_id, a.first_name, a.last_name, COUNT(*) AS film_count
FROM film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
ORDER BY film_count DESC
LIMIT 1;
SELECT f.title
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = X;

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.



-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.