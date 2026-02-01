USE sakila;

-- ejecicio 1
SELECT 
title,
COUNT(inventory_id) AS número_copias
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id = i.film_id
WHERE title = 'Hunchback Impossible';

-- ejercicio 2
SELECT 
title, 
length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- ejercicio 3
SELECT 
first_name, 
last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id
        FROM film
        WHERE title = 'Alone Trip')
);

-- ejercicio 4

SELECT 
f.title,
c.name AS categoria
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- ejercicio 5

SELECT 
c.first_name, 
c.last_name,
c.email
FROM customer AS c
INNER JOIN address AS a
ON c.address_id = a.address_id
INNER JOIN city AS ci
ON a.city_id = ci.city_id
WHERE ci.country_id = (
    SELECT country_id 
    FROM country 
    WHERE country = 'Canada'
);

-- ejercicio 6

SELECT 
f.actor_id,
a.first_name
FROM film_actor AS f
INNER JOIN actor AS a 
ON f.actor_id=a.actor_id
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

SELECT 
f.title,
a.first_name,
a.last_name
FROM film AS f
INNER JOIN film_actor AS fa 
ON f.film_id = fa.film_id
LEFT JOIN actor AS a
ON a.actor_id= fa.actor_id
WHERE fa.actor_id = (
	SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);

-- ejercicio 7

SELECT 
DISTINCT f.title,
c.first_name,
c.last_name
FROM film AS f
LEFT JOIN inventory AS i 
ON f.film_id = i.film_id
LEFT JOIN rental AS r 
ON i.inventory_id = r.inventory_id
LEFT JOIN customer AS c
ON c.customer_id = r.customer_id
WHERE r.customer_id = (
    SELECT 
    customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- ejercicio 8
SELECT 
p.customer_id,
c.first_name,
c.last_name,
SUM(amount) AS dinero_gastado
FROM payment AS p
LEFT JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY 
p.customer_id,
c.first_name,
c.last_name
HAVING dinero_gastado > (
    SELECT AVG(total_cliente)
    FROM (
        SELECT SUM(amount) AS total_cliente
        FROM payment
        GROUP BY customer_id
    ) AS saber_promedio
)
ORDER BY dinero_gastado DESC;





