USE sakila;

-- 1. Número de copias de Hunchback Impossible en el inventario

SELECT COUNT(*) AS total_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);

-- 2. Películas con duración superior a la media

SELECT
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;

-- 3. Actores que aparecen en Alone Trip

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
        WHERE title = 'ALONE TRIP'
    )
)
ORDER BY last_name, first_name;

-- 4. Bonus: Películas de la categoría Family

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

-- 5a. Bonus: Clientes de Canadá usando subqueries

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
)
ORDER BY last_name, first_name;

-- 6. Bonus: Películas del actor más prolífico

SELECT
    f.title
FROM film AS f
JOIN film_actor AS fa
    ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
)
ORDER BY f.title;

-- 7. Bonus: Películas alquiladas por el cliente más rentable

SELECT DISTINCT
    f.title
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

-- 8. Bonus: Clientes que gastaron más que la media por cliente

SELECT
    customer_id AS client_id,
    ROUND(SUM(amount), 2) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_amount_spent DESC;