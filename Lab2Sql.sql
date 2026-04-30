-- ============================================
-- LAB: SQL Subqueries - Sakila Database
-- ============================================

-- 1. Número de copias de "Hunchback Impossible" en inventario
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
);


-- 2. Películas con duración mayor al promedio
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film
)
ORDER BY length DESC;


-- 3. Actores que aparecen en "Alone Trip"
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


-- ============================================
-- BONUS
-- ============================================

-- B1. Películas clasificadas como "Family"
SELECT title
FROM film
WHERE film_id IN (
    SELECT fc.film_id
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Family'
);


-- B2. Nombre y email de clientes de Canadá
-- Con subconsulta:
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id FROM address
    WHERE city_id IN (
        SELECT city_id FROM city
        WHERE country_id = (
            SELECT country_id FROM country
            WHERE country = 'Canada'
        )
    )
);

-- Con JOIN:
SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';


-- B3. Películas del actor más prolífico
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);


-- B4. Películas alquiladas por el cliente más rentable
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY COUNT(payment_id) DESC
    LIMIT 1
);


-- B5. Clientes que gastaron más que el promedio total por cliente
SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS avg_per_customer
)
ORDER BY total_amount_spent DESC;