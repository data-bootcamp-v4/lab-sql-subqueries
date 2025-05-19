-- 1 ¿Cuántas copias de la película "Hunchback Impossible" existen en el inventario?

SELECT 
COUNT(film_id) AS total_copias
FROM inventory 
WHERE film_id= (
	SELECT 
    film_id 
    FROM film
    WHERE title ="Hunchback Impossible"
);

-- 2 Listar todas las películas cuya duración sea mayor que la duración promedio de todas las películas

SELECT title, 
length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- 3 Mostrar todos los actores que aparecen en la película "Alone Trip"
SELECT 
a.first_name, 
a.last_name 
FROM actor a 
WHERE a.actor_id IN (
	SELECT fa.actor_id 
    FROM film_actor fa
    WHERE fa.film_id = (
		SELECT film_id
        FROM film 
        WHERE title= "Alone Trip")
);