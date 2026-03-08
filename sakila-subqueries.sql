USE sakila;

-- 1
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);

-- 2
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC, title ASC;

-- 3
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
    )
)
ORDER BY last_name, first_name;

-- 4
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

-- 5
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

SELECT c.first_name, c.last_name, c.email
FROM customer AS c
JOIN address AS a
    ON c.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY c.last_name, c.first_name;

-- 6
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

-- 7
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

-- 8
SELECT
    customer_id AS client_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT customer_id, SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_amount_spent DESC;