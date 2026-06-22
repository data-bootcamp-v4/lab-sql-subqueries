-- 1
SELECT
    COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f
    ON i.film_id = f.film_id
WHERE f.title = 'HUNCHBACK IMPOSSIBLE';

-- 2 
SELECT
    title,
    length
FROM film
WHERE length >
(
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;

-- 3
SELECT
    actor_id,
    first_name,
    last_name
FROM actor
WHERE actor_id IN
(
    SELECT actor_id
    FROM film_actor
    WHERE film_id =
    (
        SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
    )
);
  
-- 4
SELECT
    f.title
FROM film f
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
WHERE c.name = 'Family'
ORDER BY f.title;

-- 5
SELECT
    first_name,
    last_name,
    email
FROM customer
WHERE address_id IN
(
    SELECT address_id
    FROM address
    WHERE city_id IN
    (
        SELECT city_id
        FROM city
        WHERE country_id =
        (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);

-- 6 
SELECT
    f.title
FROM film f
JOIN film_actor fa
    ON f.film_id = fa.film_id
WHERE fa.actor_id =
(
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.title;

-- 7
SELECT DISTINCT
    f.title
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
WHERE r.customer_id =
(
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
HAVING SUM(amount) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT
            SUM(amount) AS customer_total
        FROM payment
        GROUP BY customer_id
    ) t
)
ORDER BY total_amount_spent DESC;

