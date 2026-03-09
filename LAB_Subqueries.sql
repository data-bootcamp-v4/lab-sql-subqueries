SELECT f.title, COUNT(i.inventory_id) AS copies
FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

SELECT title, length FROM sakila.film
WHERE length >  (SELECT ROUND(AVG(length)) AS 'Average' FROM sakila.film);

SELECT CONCAT(first_name, ' ', last_name) AS Actor
FROM sakila.actor
WHERE actor_id IN (
    SELECT actor_id
    FROM sakila.film_actor
    WHERE film_id = (
        SELECT film_id
        FROM sakila.film
        WHERE title = 'Alone Trip'));

#BONUS 

SELECT title
FROM sakila.film
WHERE film_id IN (
    SELECT film_id
    FROM sakila.film_category
    WHERE category_id = (
        SELECT category_id
        FROM sakila.category
        WHERE name = 'Family'
    ));
    
    
SELECT c.first_name, c.last_name, c.email
FROM sakila.customer c
JOIN sakila.address a ON c.address_id = a.address_id
JOIN sakila.city ci ON a.city_id = ci.city_id
JOIN sakila.country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT first_name, last_name, email
FROM sakila.customer
WHERE address_id IN (
    SELECT address_id
    FROM sakila.address
    WHERE city_id IN (
        SELECT city_id
        FROM sakila.city
        WHERE country_id = (
            SELECT country_id
            FROM sakila.country
            WHERE country = 'Canada'
        )
    )
);

SELECT title
FROM sakila.film
WHERE film_id IN (
    SELECT film_id
    FROM sakila.film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM sakila.film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
);

SELECT title
FROM sakila.film
WHERE film_id IN (
    SELECT film_id
    FROM sakila.inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM sakila.rental
        WHERE customer_id = (
            SELECT customer_id
            FROM sakila.payment
            GROUP BY customer_id
            ORDER BY SUM(amount) DESC
            LIMIT 1
        )
    )
);

SELECT customer_id AS client_id, SUM(amount) AS total_amount_spent
FROM sakila.payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM sakila.payment
        GROUP BY customer_id
    ) AS avg_table
);