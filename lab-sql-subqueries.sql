-- =====================================================================
-- Lab | SQL Subqueries (base de datos sakila)
-- Una subconsulta es una consulta dentro de otra, entre paréntesis.
-- Se ejecuta primero la de dentro y su resultado lo usa la de fuera.
-- Truco para escribirlas: primero escribo y pruebo la consulta de dentro sola,
-- y cuando devuelve lo que espero, la meto en la de fuera.
-- =====================================================================
USE sakila;


-- ---------------------------------------------------------------------
-- 1. Copias de "Hunchback Impossible" en el inventario
-- ---------------------------------------------------------------------
-- Dentro: busco el film_id a partir del título. Fuera: cuento las filas de inventory con ese film_id.
-- Uso = porque la subconsulta devuelve un único valor (el título es único).
-- Resultado: 6 copias.
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);


-- ---------------------------------------------------------------------
-- 2. Películas más largas que la duración media
-- ---------------------------------------------------------------------
-- No puedo escribir WHERE length > AVG(length): AVG es una función de agregación y
-- no se puede usar directamente en WHERE. La subconsulta calcula la media (115.27) aparte.
-- Resultado: 489 películas.
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;


-- ---------------------------------------------------------------------
-- 3. Actores de la película "Alone Trip" (con subconsulta)
-- ---------------------------------------------------------------------
-- Dos niveles: el título da el film_id; el film_id da los actor_id en film_actor;
-- y con esos actor_id saco los nombres de actor.
-- Uso IN y no = porque la subconsulta de film_actor devuelve varios actores.
-- Resultado: 8 actores.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
    )
);


-- =====================================================================
-- BONUS
-- =====================================================================

-- ---------------------------------------------------------------------
-- 4. Películas de la categoría Family
-- ---------------------------------------------------------------------
-- Categoría -> category_id -> film_id en film_category -> títulos en film. Resultado: 69 películas.
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
)
ORDER BY title;


-- ---------------------------------------------------------------------
-- 5. Nombre y email de los clientes de Canadá (con subconsultas y con joins)
-- ---------------------------------------------------------------------
-- Camino de tablas: customer -> address -> city -> country.

-- 5a. Con subconsultas: cada nivel devuelve los ids que necesita el siguiente.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);

-- 5b. Con joins: el mismo camino, uniendo las tablas y filtrando al final.
-- Las dos dan el mismo resultado (5 clientes). Con joins es más fácil añadir columnas
-- de las otras tablas (por ejemplo, la ciudad); con subconsultas se lee como una
-- serie de preguntas encadenadas.
SELECT cu.first_name, cu.last_name, cu.email
FROM customer AS cu
JOIN address AS a  ON cu.address_id = a.address_id
JOIN city    AS ci ON a.city_id      = ci.city_id
JOIN country AS co ON ci.country_id  = co.country_id
WHERE co.country = 'Canada';


-- ---------------------------------------------------------------------
-- 6. Películas del actor más prolífico
-- ---------------------------------------------------------------------
-- Paso 1 (dentro): el actor con más películas. Agrupo film_actor por actor, ordeno por
-- número de películas y me quedo con el primero con LIMIT 1.
-- Resultado de este paso: actor_id 107 (GINA DEGENERES), con 42 películas.
SELECT actor_id, COUNT(*) AS number_of_films
FROM film_actor
GROUP BY actor_id
ORDER BY number_of_films DESC
LIMIT 1;

-- Paso 2 (fuera): las películas de ese actor.
-- Nota técnica: MySQL no permite LIMIT dentro de una subconsulta usada con IN, pero sí con =,
-- y aquí la subconsulta devuelve un único actor_id, así que uso =.
SELECT f.title
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.title;


-- ---------------------------------------------------------------------
-- 7. Películas alquiladas por el cliente más rentable
-- ---------------------------------------------------------------------
-- Paso 1 (dentro): el cliente con la mayor suma de pagos.
-- Resultado de este paso: customer_id 526 (KARL SEAL), 221.55 $.
-- Paso 2 (fuera): sus alquileres -> copias -> títulos. DISTINCT por si alquiló
-- la misma película más de una vez.
SELECT DISTINCT f.title
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film      AS f ON i.film_id      = f.film_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;


-- ---------------------------------------------------------------------
-- 8. Clientes que gastaron más que la media de gasto por cliente
-- ---------------------------------------------------------------------
-- Ojo: "la media del total gastado por cada cliente" no es AVG(amount) (media por pago),
-- sino la media de los totales por cliente. Por eso hay dos niveles:
--   - dentro del todo: el total de cada cliente (SUM ... GROUP BY customer_id);
--   - encima: la media de esos totales (≈ 112.55 $).
-- MySQL exige un alias (customer_totals) para una subconsulta usada en FROM.
-- HAVING porque filtro sobre un valor agregado, SUM(amount).
-- Resultado: 285 clientes.
SELECT customer_id                AS client_id,
       ROUND(SUM(amount), 2)      AS total_amount_spent
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
