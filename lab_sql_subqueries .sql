USE sakila;

SELECT *
FROM sakila.inventory;

SELECT *
FROM sakila.film;

SELECT COUNt(*) AS num_copies
FROM sakila.inventory
WHERE film_id=(
SELECT film_id
FROM sakila.film
WHERE title="Hunchback Impossible");

SELECT * FROM sakila.film
WHERE length>(SELECT AVG(length) AS 'Average_length' FROM sakila.film);

SELECT *
FROM sakila.actor;

SELECT *
FROM sakila.film_actor;

SELECT *
FROM sakila.film;

SELECT * 
FROM sakila.actor
WHERE actor_id IN (
 SELECT actor_id
 FROM sakila.film_actor
 WHERE film_id=(
   SELECT film_id
   FROM sakila.film
   WHERE title="Alone Trip")
   );
   
SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT *
FROM sakila.film
WHERE film_id IN(
  SELECT film_id
  FROM sakila.film_category
  WHERE category_id IN (
    SELECT category_id
    FROM sakila.category
    WHERE name="Family")
);

SELECT *
FROM sakila.customer; 

SELECT *
FROM sakila.address;

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

SELECT actor_id,COUNT(film_id) AS film_count
FROM sakila.film_actor
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;

SELECT actor_id, first_name, last_name
FROM sakila.actor
WHERE actor_id = 107;

SELECT f.title
FROM sakila.film f
JOIN sakila.film_actor fa ON f.film_id=fa.film_id
WHERE fa.actor_id=107;

SELECT f.title
FROM sakila.film f
JOIN sakila.film_actor fa ON f.film_id=fa.film_id
WHERE fa.actor_id=(
SELECT actor_id
FROM sakila.film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1
);

SELECT customer_id, SUM(amount) AS total_paid
FROM sakila.payment
GROUP BY customer_id
ORDER BY total_paid DESC
LIMIT 1;

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM sakila.payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_amount)
    FROM (
        SELECT customer_id, SUM(amount) AS total_amount
        FROM sakila.payment
        GROUP BY customer_id
    ) AS customer_totals
);

   
