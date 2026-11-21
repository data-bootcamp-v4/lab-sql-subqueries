Use sakila;

SELECT
film_id
 ,title
  , description
FROM film
WHERE TRUE 
    AND title = "Hunchback Impossible"
    AND film_id = "439";
    
-- 1. Determine o numreo de copia do filme 

SELECT 
    COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id in (
    SELECT film_id 
    FROM film
    WHERE title = "Hunchback Impossible"
);

-- 2. Liste todos os filmes cujo comprimento é maior 
SELECT AVG(length) AS duração_media
FROM film;

SELECT title
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- 3. Atores do filme "Alone Trip"
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

-- Bonus 
-- 4. Filmes da categoria Family
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
);

-- 5. Clientes do Canadá
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

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- 6. Ator mais prolífico do Sakila
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS total_filmes
FROM actor a
JOIN film_actor fa
    ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_filmes DESC
LIMIT 1;

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
        LIMIT 1
    )
);

-- 7. Filmes alugados pelo cliente mais rentável
SELECT
    customer_id,
    SUM(amount) AS total_gasto
FROM payment
GROUP BY customer_id
ORDER BY total_gasto DESC
LIMIT 1;

-- Encontraros filmes alugadas
SELECT DISTINCT f.title
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- 8. Clientes que gastaram acima da média   
SELECT
    customer_id AS client_id,
    SUM(amount) AS total_amount_spend
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_gasto)
    FROM (
        SELECT SUM(amount) AS total_gasto
        FROM payment
        GROUP BY customer_id
    ) AS gastos_clientes
)
ORDER BY total_amount_spend DESC;


