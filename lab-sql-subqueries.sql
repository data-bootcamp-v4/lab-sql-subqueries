-- LAB | Subconsultas SQL
-- Ironhack
 
USE sakila;
 
-- Ejercicio 1
-- Determinar cuántas copias de la película "Hunchback Impossible" existen en el inventario.
 
SELECT 
    film_id
    ,title 
    ,description
FROM film
WHERE TRUE
   AND title = "Hunchback Impossible"
   AND film_id = 439;
 
SELECT 
    COUNT(*) AS number_of_copies FROM inventory
WHERE film_id in ( 
    SELECT film_id
    FROM film
    WHERE title ="Hunchback Impossible"
)
;
 
 
-- Ejercicio 2
-- Mostrar las películas cuya duración sea superior a la duración media de todas las películas.
 
SELECT AVG(length)
FROM film;
 
SELECT title
FROM film
WHERE length > (SELECT AVG(length)
FROM film);
 
 
-- Ejercicio 3
-- Mostrar todos los actores que aparecen en la película "Alone Trip".
 
SELECT film_id
FROM film
WHERE title = "Alone Trip";
 
SELECT 
    actor_id
    ,first_name
    ,last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
    )
);
 
 
-- Bonus
 
 
-- Ejercicio
-- Identificar todas las películas clasificadas como familiares.
 
SELECT category_id
FROM category
WHERE name = "Family";
 
SELECT 
    film_id
    ,title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id IN (
        SELECT category_id
        FROM category
        WHERE name = "Family"
    )
);
 
 
-- Ejercicio 5
-- Obtener el nombre y el correo electrónico de los clientes de Canadá.
 
-- Subqueries
 
SELECT 
    first_name
    ,last_name
    ,email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id IN (
            SELECT country_id
            FROM country
            WHERE country = "Canada"
        )
    )
);
 
-- Joins
 
SELECT 
    c.first_name
    ,c.last_name
    ,c.email
FROM customer AS c
JOIN address AS a
    ON c.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id
WHERE co.country = "Canada";
 
 
-- Ejercicio 6 
-- Encontrar las películas protagonizadas por el actor que ha participado en más películas.
 
-- Actor más prolífico
SELECT 
    actor_id
    ,COUNT(film_id) AS number_of_films
FROM film_actor
GROUP BY actor_id
ORDER BY number_of_films DESC
LIMIT 1;
 
-- Películas de ese actor
SELECT 
    film_id
    ,title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
);
 
 
-- Ejercicio 7 
-- Encontrar las películas alquiladas por el cliente que más dinero ha gastado.
 
-- Cliente más rentable
SELECT 
    customer_id
    ,SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
ORDER BY total_paid DESC
LIMIT 1;
 
-- Películas que alquiló ese cliente
SELECT 
    film_id
    ,title
FROM film
WHERE film_id IN (
    SELECT i.film_id
    FROM inventory AS i
    JOIN rental AS r
        ON i.inventory_id = r.inventory_id
    WHERE r.customer_id = (
        SELECT customer_id
        FROM payment
        GROUP BY customer_id
        ORDER BY SUM(amount) DESC
        LIMIT 1
    )
);
 
 
-- Ejercicio 8 
-- Encontrar los clientes cuyo gasto total supera el gasto medio de todos los clientes.
 
-- Media del gasto total por cliente
SELECT AVG(total_spent)
FROM (
    SELECT SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals;
 
-- Clientes por encima de esa media
SELECT 
    customer_id AS client_id
    ,SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_amount_spent DESC;