USE sakila;

-- nº de copias de "Hunchback: Imposible":
SELECT COUNT(*) AS num_copies FROM inventory 
WHERE film_id = (FROM film WHERE title = 'Hunchback: Imposible');

-- Listado de pelis que duren mas que el promedio:
SELECT * FROM film
WHERE length > (SELECT ROUND(AVG(length),2) AS 'length' FROM film);


-- Actores que aparezcan en "Alone trip" :

SELECT first_name, last_name FROM actor WHERE actor_id IN (SELECT
actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film 
WHERE title = 'Alone Trip'));

-- Bonus: 
-- Busca las películas familiares ¿rating = g?:

SELECT title FROM film JOIN film_category USING (film_id)
JOIN category USING (category_id) WHERE category.name = 'Family';

-- Consigue el nombre y el correo de los usuarios canadoenses:
-- customer -> address_id (address) -> city_id (city) -> country_id (country)
SELECT first_name, last_name, email FROM customer WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN (SELECT city_id FROM city WHERE country_id IN (SELECT country_id FROM country)));

-- Consigue el listado de pelis en el que salga el actor mas prolifico
SELECT actor_id, COUNT(*) AS num_apariciones FROM film_actor GROUP BY actor_id ORDER BY num_apariciones DESC LIMIT 1;
SELECT first_name, last_name FROM actor WHERE actor_id = 107;

-- Consigue el listado de pelis que ha sacado el cliente mas frecuente: usa la tabla de clientes y los pagos para el id


-- Obten el client_id y el total_amount_spend para los clientes que gastaron mas que el promedio de total_amount x cliente: usa subconsultas

