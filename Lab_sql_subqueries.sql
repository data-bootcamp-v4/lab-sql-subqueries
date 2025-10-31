USE sakila;

-- EJERCICIO 1
-- Determina el número de copias de la película "Hunchback Impossible" que existen en el sistema de inventario.

SELECT
COUNT(inventory_id) AS total_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'HUNCHBACK IMPOSSIBLE');

-- EJERCICIO 2
-- Enumera todas las películas cuya duración sea superior a la duración media de todas las películas de la 
-- base de datos de Sakila.

SELECT
f.title
FROM film AS f
WHERE length > (SELECT AVG(length) FROM film);

-- EJERCICIO 3
-- Utilice una subconsulta para mostrar todos los actores que aparecen en la película "Alone Trip".

-- film_id y actor_id en film_actor
-- film_id y title en film
-- actor_id first_name y last_name en actor

SELECT 
first_name,
last_name
FROM actor 
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'ALONE TRIP'));

-- EJERCICIO 4
-- Las ventas entre familias jóvenes han estado bajas, y usted desea enfocar su promoción en películas familiares. 
-- Identifique todas las películas categorizadas como 'FAMILY FILMS'.

-- category_id y name en category
-- film_id y category_id en film_category
-- film:id y title en film

SELECT 
title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = "family"));

-- EJERCICIO 5
-- Obtén el nombre y el correo electrónico de los clientes de Canadá utilizando subconsultas y combinaciones (joins). 
-- Para usar combinaciones, deberás identificar las tablas relevantes y sus claves primarias y foráneas.

-- customer
-- adress 
-- city
-- country

SELECT
c.first_name AS name,
c.last_name AS last_name,
c.email AS email
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
WHERE ci.country_id = (SELECT country_id FROM country WHERE country = 'Canada')
ORDER BY c.last_name;

-- EJERCICIO 6
-- Determina en qué películas actuó el actor más prolífico de la base de datos de Sakila. Un actor prolífico es aquel que ha participado 
-- en la mayor cantidad de películas. Primero, debes encontrar al actor más prolífico y luego usar su ID para buscar las diferentes películas 
-- en las que actuó.

-- actor_id y film_id en film_actor
-- film_id y title en film

SELECT
f.title AS movie_name
FROM film AS f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(film_id) DESC LIMIT 1)
ORDER BY f.title ASC;

-- EJERCICIO 7
-- Encuentra las películas alquiladas por el cliente más rentable en la base de datos de Sakila. Puedes usar las tablas de clientes y 
-- pagos para encontrar al cliente más rentable, es decir, el cliente que ha realizado la mayor cantidad de pagos.

-- payment_id y customer_id en payment
-- customer_id en customer
-- film_id en inventory

SELECT
f.title AS movie_rent
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (SELECT customer_id FROM payment GROUP BY customer_id ORDER BY COUNT(payment_id) DESC LIMIT 1)
GROUP BY f.title;

-- EJERCICO 8
-- Recupera el client_id y el total_amount_spent de aquellos clientes que gastaron más que el promedio del total_amount gastado 
-- por cliente. Puedes usar subconsultas para lograrlo.





