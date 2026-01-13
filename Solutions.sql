USE sakila;

---------------------------------------------------
-- 1. Número de copias de "Hunchback Impossible"
---------------------------------------------------
SELECT 
    COUNT(*) AS copies_of_hunchback_impossible
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);


---------------------------------------------------
-- 2. Películas con duración mayor que la media
---------------------------------------------------
SELECT 
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC, title;


---------------------------------------------------
-- 3. Actores que aparecen en "Alone Trip" (subquery)
---------------------------------------------------
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'ALONE TRIP'
)
ORDER BY a.last_name, a.first_name;


---------------------------------------------------
-- BONUS 4. Películas de la categoría "Family"
---------------------------------------------------
SELECT 
    f.film_id,
    f.title
FROM film f
WHERE f.film_id IN (
    SELECT fc.film_id
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Family'
)
ORDER BY f.title;


---------------------------------------------------
-- BONUS 5. Clientes de CANADÁ (subquery)
---------------------------------------------------
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


---------------------------------------------------
-- BONUS 5 (otra forma): Clientes de CANADÁ (JOIN)
---------------------------------------------------
SELECT 
    c.first_name,
    c.last_name,
    c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci   ON a.city_id     = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY c.last_name, c.first_name;


---------------------------------------------------
-- BONUS 6. Películas del actor más prolífico
-- Paso 1 (info extra): actor más prolífico (opcional)
---------------------------------------------------
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS films_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY films_count DESC
LIMIT 1;


---------------------------------------------------
-- Paso 2: Películas en las que actúa el actor más prolífico
---------------------------------------------------
SELECT 
    f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.title;


---------------------------------------------------
-- BONUS 7. Películas alquiladas por el cliente más rentable
---------------------------------------------------
SELECT DISTINCT
    f.title
FROM payment p
JOIN rental r    ON p.rental_id   = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id      = f.film_id
WHERE p.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;


---------------------------------------------------
-- BONUS 8. Clientes que gastaron más que la media
-- de lo gastado por cada cliente
---------------------------------------------------
SELECT 
    customer_id,
    total_amount_spent
FROM (
    SELECT 
        customer_id,
        SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE total_amount_spent > (
    SELECT AVG(total_amount)
    FROM (
        SELECT 
            SUM(amount) AS total_amount
        FROM payment
        GROUP BY customer_id
    ) AS avg_totals
)
ORDER BY total_amount_spent DESC;
