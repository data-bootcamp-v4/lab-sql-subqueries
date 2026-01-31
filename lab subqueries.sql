USE  sakila;

-- 1 Determina el numero de copias de la pelicua Hunchback Impossible que existen en le inventario
-- inventory_id (inventory
-- film_id ( film)
-- title ( film ) 
SELECT
COUNT(inventory_id) as copias_totales
FROM inventory
where film_id =
	(SELECT film_id
	FROM film
	WHERE title = 'Hunchback Impossible');
    
-- 2 lista de peliculas  con durancion media superior
-- title ( film) 
-- lenght ( film ) avg

SELECT 
title,
length
FROM film
WHERE length >
(SELECT AVG(length)
from film)
ORDER BY length DESC;

-- 3 identifica todos los actores que aparecen en la pelicual Alone Trip
-- firts_name ( actor )
-- last_name ( actor ) 
-- title ( film ) 
-- actor_id ( film_acotr)
-- film_id (film)

SELECT CONCAT(first_name ,' ', last_name) nombre_completo
from actor
where actor_id In(
		SELECT actor_id
		FROM film_actor
		WHERE film_id = 
				(SELECT film_id
				FROM film
				WHERE title = 'Alone Trip'));
                
-- 4 Identifica todas las peliculas que aparezcan en la categoria familia
-- title ( film )
-- film_id ( film_catergory , film)
-- category_id(category)
-- name (category )

SELECT title as peliculas_cat_fam
FROM film
where film_id IN(
	SELECT film_id
	FROM film_category
	WHERE category_id = (
			SELECT category_id 
			FROM category
			where name = 'Family'));

-- 5 devuel el nombre y correo de los clientes de canada
-- SUBQUERIE 
-- first_name y email ( customer ) 
-- addres_id (addres) 
-- city_id (addres)
-- country_id ( country ) 

SELECT CONCAT(first_name, ' ' , last_name ) AS nombre_completo,
email
FROM CUSTOMER
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE country_id IN(
			SELECT country_id
			FROM country
			WHERE country = 'Canada')));

-- JOINS
SELECT 
concat(c.first_name,' ',c.last_name) AS nombre_completo,
c.email
FROM customer as c
JOIN address AS a 
ON c.address_id = a.address_id
JOIN city AS ci 
ON a.city_id = ci.city_id
JOIN country AS co 
ON ci.country_id = co.country_id
WHERE co.country = 'Canada';



-- 6 determina que peliculas estan protagonizadas por es el mas prolifico 
-- actor_id ( film_actor ) 
-- film_id ( film_actor)
-- tittle ( film )

SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	WHERE actor_id = (
		SELECT actor_id
		FROM film_actor
		GROUP BY actor_id
		ORDER BY COUNT(film_id) DESC
		LIMIT 1));
	
-- 7 Encuentra la peliculas mas alquiladas por el cliente mas rentable
-- title ( film )
-- film_id ( inventory
-- inventory_id ( rental )
-- customer_id ( payment)
-- amount ( payment )

SELECT title
FROM film
WHERE film_id IN(
	SELECT film_id
	FROM inventory
	WHERE inventory_id IN(
		SELECT inventory_id
		FROM rental
		WHERE customer_id = (
			SELECT customer_id
			FROM payment
			GROUP BY customer_id
			ORDER BY SUM(amount) DESC
			LIMIT 1)));

-- 8 Encuetra a los clientes que gastan mas que la media
-- customer_id ( payment )
-- amount (payment)  -total_spent
-- amout(payment) -- avg_amount

SELECT 
customer_id,
SUM(amount) total_gastado
FROM payment
GROUP BY customer_id
HAVING total_gastado > (
	SELECT AVG (total_por_cliente)
	FROM
		(SELECT SUM(amount) AS total_por_cliente
		FROM payment
		GROUP BY customer_id
		) as promedio);





