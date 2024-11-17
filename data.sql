-- Escriba consultas SQL para realizar las siguientes tareas utilizando la base de datos Sakila:
-- 1. Determinar el número de copias de la película “Jorobado: Imposible” que existen en el sistema de inventario.

SELECT COUNT(*) FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = 'Huncback Impossible');

-- 2. Enumere todas las películas cuya duración sea mayor que la duración promedio de todas las películas en la base de datos de Sakila.

SELECT * FROM film WHERE length > (SELECT AVG(length) FROM film);

-- 3. Utilice una subconsulta para mostrar todos los actores que aparecen en la película "Alone Trip".

SELECT * FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));


-- Bono :
-- 4. Las ventas han disminuido entre las familias jóvenes y usted desea dirigirse a películas familiares para una promoción. 
-- Identifique todas las películas categorizadas como películas familiares.

SELECT f.title 
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- 5. Recupere el nombre y el correo electrónico de los clientes de Canadá mediante subconsultas y uniones. 
-- Para utilizar uniones, deberá identificar las tablas relevantes y sus claves primarias y externas.

SELECT first_name, email FROM customer WHERE address_id IN 
(SELECT address_id FROM address WHERE country_id = 
(SELECT country_id FROM country WHERE country = 'Canada')); 


-- 6. Determina qué películas protagonizó el actor más prolífico en la base de datos de Sakila. 
-- Un actor prolífico se define como el actor que ha actuado en la mayor cantidad de películas. 
-- Primero, deberás encontrar al actor más prolífico y luego usar ese actor_id para encontrar 
-- las diferentes películas en las que protagonizó.

SELECT title FROM film WHERE film_id IN 
(SELECT film_id FROM film_actor WHERE actor_id = 
(SELECT actor_id FROM actor WHERE actor_id = 
(SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(*) DESC LIMIT 1)));


-- 7. Encuentra las películas alquiladas por el cliente más rentable en la base de datos de Sakila. 
-- Puedes utilizar las tablas de clientes y pagos para encontrar al cliente más rentable, es decir, 
-- el cliente que ha realizado la mayor suma de pagos.

SELECT title FROM film WHERE film_id IN 
(SELECT film_id FROM rental WHERE customer_id = 
(SELECT customer_id FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 1));


-- 8. Recupere el client_id y el total_amount_spent de aquellos clientes que gastaron más que el promedio del total_amount gastado por cada cliente. 
-- Puede usar subconsultas para lograr esto.

SELECT customer_id, SUM(amount) AS total_amount_spent FROM payment GROUP BY customer_id HAVING SUM(amount) > 
(SELECT AVG(SUM(amount)) FROM payment GROUP BY customer_id);