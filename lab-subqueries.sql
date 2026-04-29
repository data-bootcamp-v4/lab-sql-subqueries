USE sakila;

-- 1. Determina cuántas copias de la película "Hunchback Impossible" existen en el inventario
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id          -- devuelve el ID de la película
    FROM film
    WHERE title = 'Hunchback Impossible'
);

-- 2. Lista todas las películas cuya duración sea mayor que la duración media de todas las películas
SELECT title,
       length
FROM film
WHERE length > (
    SELECT AVG(length)   -- calcula la media de duración
    FROM film            -- de todas las películas
);

-- 3. Usar subquery para mostrar todos los actores que aparecen en pelicula "Alone Trip"
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id          -- todos los actores de esa película
    FROM film_actor
    WHERE film_id = (
        SELECT film_id       -- el ID de "Alone Trip"
        FROM film
        WHERE title = 'Alone Trip'
    )
);
-- Bonus
-- 4. Identifica todas las películas categorizadas como películas familiares
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id          -- películas que pertenecen a 'Family'
    FROM film_category
    WHERE category_id = (
        SELECT category_id  -- el ID de la categoría 'Family'
        FROM category
        WHERE name = 'Family'
    )
);

