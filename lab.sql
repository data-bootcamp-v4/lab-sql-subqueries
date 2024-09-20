-- 1. Determinar el número de copias de la película “Hunchback Impossible” que existen en el sistema de inventario.
SELECT COUNT(inv.inventory_id) as "number of copies"
FROM film as f
LEFT JOIN inventory as inv
ON f.film_id = inv.film_id
WHERE title LIKE "%Hunchback Impossible%";

-- 2. Enumere todas las películas cuya duración sea mayor que la duración promedio de todas las películas en la base de datos de Sakila.
SELECT f.title, f.length
FROM film as f
WHERE f.length > (SELECT AVG(length) FROM film);

-- 3. Utilice una subconsulta para mostrar todos los actores que aparecen en la película "Alone Trip".
SELECT ac.first_name, ac.last_name  -- -> el primer select es lo que quieres que te de
FROM actor as ac
WHERE ac.actor_id IN (
        SELECT 
            fa.actor_id
        FROM 
            film_actor as fa
        JOIN 
            film f ON fa.film_id = f.film_id
        WHERE 
            f.title = 'Alone Trip'
);
