-- 1. Número de copias de la película “Jorobado: Imposible” en el inventario
SELECT COUNT(*) AS total_copies
FROM inventory
WHERE film_id = (
  SELECT film_id FROM film WHERE title = 'Jorobado: Imposible'
);

-- 2. Películas cuya duración es mayor que la duración promedio
SELECT title, length
FROM film
WHERE length > (
  SELECT AVG(length) FROM film
);

-- 3. Todos los actores que aparecen en la película "Alone Trip"
SELECT a.first_name, a.last_name
FROM actor a
WHERE actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  JOIN film f ON fa.film_id = f.film_id
  WHERE f.title = 'Alone Trip'
);

-- BONUS 4. Películas clasificadas como películas familiares
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- BONUS 5. Nombre y correo de clientes de Canadá
SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
WHERE cu.address_id IN (
  SELECT a.address_id
  FROM address a
  JOIN city ci ON a.city_id = ci.city_id
  JOIN country co ON ci.country_id = co.country_id
  WHERE co.country = 'Canada'
);

-- BONUS 6. Películas del actor más prolífico
SELECT f.title
FROM film f
WHERE f.film_id IN (
  SELECT fa.film_id
  FROM film_actor fa
  WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
  )
);

-- BONUS 7. Películas alquiladas por el cliente más rentable
SELECT f.title
FROM film f
WHERE f.film_id IN (
  SELECT i.film_id
  FROM inventory i
  JOIN rental r ON i.inventory_id = r.inventory_id
  WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
  )
);

-- BONUS 8. Clientes que gastaron más que el promedio total gastado
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
  SELECT AVG(total)
  FROM (
    SELECT SUM(amount) AS total
    FROM payment
    GROUP BY customer_id
  ) AS subquery
);
