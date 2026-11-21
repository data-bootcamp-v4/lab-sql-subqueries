-- =====================================================
-- LAB | SQL Subqueries (sakila)
-- =====================================================
USE sakila;

-- 1. Copias de "Hunchback Impossible" en el inventario
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'HUNCHBACK IMPOSSIBLE');

-- 2. Películas más largas que la duración media
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- 3. Actores que aparecen en "Alone Trip" (con subconsulta)
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'ALONE TRIP')
);

-- ---------------- BONUS ----------------

-- 4. Películas de la categoría Family
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (SELECT category_id FROM category WHERE name = 'Family')
);

-- 5. Nombre y email de los clientes de Canadá
-- 5a. Con subconsultas
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id FROM address
    WHERE city_id IN (
        SELECT city_id FROM city
        WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')
    )
);

-- 5b. Con joins
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a  ON c.address_id = a.address_id
JOIN city ci    ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- 6. Películas del actor más prolífico (el que ha hecho más películas)
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 7. Películas alquiladas por el cliente más rentable (el que más ha pagado)
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r    ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- 8. Clientes que han gastado más que la media de gasto por cliente
SELECT customer_id AS client_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (SELECT SUM(amount) AS total_spent
          FROM payment
          GROUP BY customer_id) AS totals
)
ORDER BY total_amount_spent DESC;
