USE sakila;

-- 1. Copias de "Hunchback Impossible" en el inventario
SELECT COUNT(*) AS copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'HUNCHBACK IMPOSSIBLE')
    
-- 2. Películas más largas que la duración media
SELECT
    title,
    length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- 3. Actores que aparecen en "Alone Trip"
SELECT
    first_name,
    last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor 
WHERE film_id = (SELECT film_id FROM film WHERE title = 'ALONE TRIP'));

-- 4. Películas de la categoría "Family"
SELECT
    film_id,
    title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category
    WHERE category_id = (SELECT category_id FROM category WHERE name = 'Family'));
    
-- 5. Nombre y email de los clientes de Canadá
SELECT
    first_name,
    last_name,
    email
FROM customer
WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN (SELECT city_id
FROM city
WHERE country_id = (SELECT country_id FROM country 
WHERE country = 'Canada')
)
);