USE sakila;


-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS copies_in_inventory
FROM inventory i
JOIN film f USING (film_id)
WHERE f.title = 'Hunchback Impossible';

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) FROM film
);


-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f USING (film_id)
    WHERE f.title = 'Alone Trip'
);


-- 4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT f.film_id, f.title
FROM film f
JOIN film_category fc USING (film_id)
JOIN category c USING (category_id)
WHERE c.name = 'Family';

-- 5 Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys
-- (Sorry, I could not get this one...)

-- 6 Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT f.film_id, f.title
FROM film f
JOIN film_actor fa USING (film_id)
WHERE fa.actor_id = (
    SELECT fa.actor_id
    FROM film_actor fa
    GROUP BY fa.actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

 -- 7 Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
 -- 8 Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
-- These ones I could not do either
