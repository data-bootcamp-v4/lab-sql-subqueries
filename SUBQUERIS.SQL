USE sakila;

SELECT
    f.title,
    (
        SELECT COUNT(*)
        FROM inventory AS i
        WHERE i.film_id = f.film_id
    ) AS inventory_copies
FROM film AS f
WHERE f.title = 'HUNCHBACK IMPOSSIBLE';
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;
SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor AS fa
    WHERE fa.film_id = (
        SELECT f.film_id
        FROM film AS f
        WHERE f.title = 'ALONE TRIP'
    )
)
ORDER BY a.last_name, a.first_name;
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
SELECT
    c.first_name,
    c.last_name,
    c.email
FROM customer AS c
JOIN address AS a
    ON c.address_id = a.address_id
WHERE a.city_id IN (
    SELECT ci.city_id
    FROM city AS ci
    WHERE ci.country_id = (
        SELECT country_id
        FROM country
        WHERE country = 'Canada'
    )
)
ORDER BY c.last_name, c.first_name;
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    f.title
FROM actor AS a
JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
JOIN film AS f
    ON fa.film_id = f.film_id
WHERE a.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
)
ORDER BY f.title;
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
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.title;
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
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.title;
SELECT
    customer_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(amount) AS customer_total
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_amount_spent DESC;