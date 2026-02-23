USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory_id) AS total_copies
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
);

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film
);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
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

-- BONUS 4. Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id 
        FROM category 
        WHERE name = 'Family'
    )
);

-- BONUS 5. Retrieve the name and email of customers from Canada (using subqueries).
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id 
            FROM country 
            WHERE country = 'Canada'
        )
    )
);

-- BONUS 6. Determine which films were starred by the most prolific actor.
-- First, find the actor_id with the most films, then find the films.
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
);

-- BONUS 7. Find the films rented by the most profitable customer.
SELECT title
FROM film
WHERE film_id IN (
    SELECT inventory_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE customer_id = (
            SELECT customer_id
            FROM payment
            GROUP BY customer_id
            ORDER BY SUM(amount) DESC
            LIMIT 1
        )
    )
);

-- 8. Clients who spent more than the average
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(total_customer_spent)
    FROM (
        SELECT SUM(amount) AS total_customer_spent
        FROM payment
        GROUP BY customer_id
    ) AS avg_table -- This alias "avg_table" fixes your error!
);
