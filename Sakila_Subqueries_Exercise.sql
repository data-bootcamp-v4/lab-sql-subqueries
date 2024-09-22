
-- 1. Determinar cuántas copias de la película "Hunchback Impossible" existen en el sistema de inventario
SELECT 
    COUNT(i.inventory_id) AS total_copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

-- 2. Listar todas las películas cuya duración es mayor que el promedio de todas las películas
SELECT 
    title, 
    length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Usar una subconsulta para mostrar todos los actores que aparecen en la película "Alone Trip"
SELECT 
    a.first_name, 
    a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');
