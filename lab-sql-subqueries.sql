USE sakila;

-- 1. SELECT COUNT(*) AS number_of_copies
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = 101;  -- Replace 101 with the actual film_id obtained from the previous query
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

-- Bonus --

-- 5. Retrieve the name and email of customers from Canada using both 
-- subqueries and joins. To use joins, you will need to identify the relevant
 -- tables and their primary and foreign keys. 
SELECT 
    c.name,
    c.email
FROM 
    customers c
JOIN 
    addresses a ON c.customer_id = a.customer_id
WHERE 
    a.country = 'Canada';
    
    
-- 6. -- 
SELECT 
    f.title AS film_title
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
WHERE 
    fa.actor_id = most_prolific_actor_id;









