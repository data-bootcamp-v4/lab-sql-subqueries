USE sakila;
-- 1. numero de copias de Hunchback Impossible en el inventario
SELECT COUNT(*) AS copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'HUNCHBACK IMPOSSIBLE');
SELECT film_id FROM film WHERE title = 'HUNCHBACK IMPOSSIBLE';

-- 2. peliculas con duracion mayor que la media
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;
SELECT AVG(length) FROM film;

-- 3. actores que aparecen en Alone Trip
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'ALONE TRIP')
);
SELECT actor_id
FROM film_actor
WHERE film_id = (SELECT film_id FROM film WHERE title = 'ALONE TRIP');

-- 4. peliculas de la categoria Family
SELECT title
FROM film
WHERE film_id IN (
    SELECT fc.film_id
    FROM film_category AS fc
    WHERE fc.category_id = (SELECT category_id FROM category WHERE name = 'Family')
);

-- 5a. clientes de Canada con subconsultas
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')
    )
);

-- 6. peliculas del actor que ha actuado en mas peliculas
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

-- 7. peliculas alquiladas por el cliente que mas ha pagado
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
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

-- 8. clientes que gastaron mas que la media de gasto por cliente
SELECT customer_id AS client_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(amount) AS total
        FROM payment
        GROUP BY customer_id
    ) AS totals
);