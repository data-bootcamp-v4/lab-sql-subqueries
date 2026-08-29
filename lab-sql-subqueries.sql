USE sakila;
-- Challenge 1
-- Determine the number of copies of "Hunchback Impossible"
-- in the inventory system

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);
-- Challenge 2
-- List films longer than the average film length

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;
-- Challenge 3
-- Display all actors who appear in "Alone Trip"

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
-- Bonus Challenge 4
-- Identify all movies categorized as family films

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
)
ORDER BY title;
-- Bonus Challenge 5a
-- Retrieve the names and emails of customers from Canada using subqueries

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
)
ORDER BY last_name, first_name;
-- Bonus Challenge 5b
-- Retrieve customers from Canada using JOINs

SELECT
    c.first_name,
    c.last_name,
    c.email
FROM customer AS c
JOIN address AS a
    ON c.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY c.last_name, c.first_name;
-- Bonus Challenge 6
-- Find films starring the most prolific actor

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
)
ORDER BY title;
-- Bonus Challenge 7
-- Find films rented by the most profitable customer

SELECT DISTINCT f.title
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;
-- Bonus Challenge 8
-- Find clients whose total spending is above
-- the average total spending per client

SELECT
    customer_id AS client_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(amount) AS customer_total
        FROM payment
        GROUP BY customer_id
    ) AS totals
)
ORDER BY total_amount_spent DESC;