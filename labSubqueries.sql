-- 1. Determine la cantidad de copias de la película "Hunchback Impossible" que existen en el sistema de inventario.

SELECT 
    COUNT(i.inventory_id) AS total_copies
FROM 
    inventory i
WHERE 
    i.film_id = (SELECT f.film_id 
                 FROM film f 
                 WHERE f.title = 'Hunchback Impossible');

-- 2. Enumere todas las películas cuya duración sea mayor que la duración promedio de todas las películas en la base de datos Sakila.

SELECT 
    f.title,
    f.length
FROM 
    film f
WHERE 
    f.length > (SELECT AVG(f2.length) 
                FROM film f2)
ORDER BY 
    f.length DESC;


-- 3. Utilice una subconsulta para mostrar todos los actores que aparecen en la película "Alone Trip". 

SELECT 
    a.first_name,
    a.last_name
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
WHERE 
    fa.film_id = (SELECT f.film_id 
                  FROM film f 
                  WHERE f.title = 'Alone Trip');
