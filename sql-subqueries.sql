USE SAKILA;

SELECT f.title, 
	COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible"
GROUP BY f.title;

SELECT
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;

SELECT
    first_name,
    last_name
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

SELECT
    title
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
    first_name,
    last_name,
    email
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

