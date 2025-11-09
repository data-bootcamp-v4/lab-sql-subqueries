-- LABORATORIO 5

# 1. Determina cuántas copias de la película **"Hunchback Impossible"** existen en el sistema de inventario.

SELECT COUNT(inventory_id)
FROM inventory
WHERE film_id = (
				SELECT film_id
				FROM film
				WHERE title = 'Hunchback Impossible'
);

# 2. Lista todas las películas cuya duración sea **mayor que la duración media** de todas las películas de la base de datos Sakila.

SELECT title, length
FROM film 
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length ASC;

# 3. Usa una **subconsulta** para mostrar todos los actores que aparecen en la película **"Alone Trip"**.

SELECT first_name
FROM actor
WHERE actor_id IN (
				SELECT actor_id
				FROM film_actor
				WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip')
);

# 4. Las ventas han sido bajas entre familias jóvenes, y quieres hacer una promoción dirigida a películas familiares. **Identifica todas las películas clasificadas como películas familiares**.

SELECT title
FROM film
WHERE film_id IN (
				SELECT film_id
				FROM film_category
				WHERE category_id = (SELECT category_id FROM category WHERE name = 'Family')
);

# 5. Recupera el **nombre y el correo electrónico** de los clientes de **Canadá**, usando tanto **subconsultas** como **joins**. 
# Para usar joins, necesitarás identificar las tablas relevantes y sus claves primarias y foráneas.

SELECT customer.first_name, customer.last_name, customer.email, country.country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Canada';

# 6. Determina qué películas protagonizó el **actor más prolífico** en la base de datos Sakila. 
# Un actor prolífico se define como el que ha actuado en **el mayor número de películas**. 
# Primero debes encontrar quién es ese actor y luego usar su `actor_id` para encontrar las películas en las que participó.

SELECT film.title, film.film_id, film_actor.actor_id
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id    -- para sacar el film title
JOIN (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS top_actor    -- crea una subconsulta, es decir, una tabla con el ranking de actores por peliculas y se queda solo con el primero
ON film_actor.actor_id = top_actor.actor_id     -- relacionas el actor_id de film_actor con el id de actor encontrado antes 
ORDER BY film.title;

# 7. Encuentra las películas alquiladas por el **cliente más rentable** de la base de datos Sakila. 
# Puedes usar las tablas `customer` y `payment` para encontrar al cliente que haya realizado la **mayor suma total de pagos**.

SELECT film.title
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
WHERE customer_id = (SELECT customer_id
					FROM payment
					GROUP BY customer_id
					ORDER BY SUM(amount) DESC
					LIMIT 1);


# 8. Recupera el `client_id` y el `total_amount_spent` de aquellos clientes que han gastado **más que el promedio** del total gastado por cada cliente. Puedes usar subconsultas para esto.


SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(sub.total_gasto) as promedio_gasto
						   FROM (
								SELECT customer_id, SUM(amount) as total_gasto
								FROM payment
								GROUP BY customer_id) as sub
						);





