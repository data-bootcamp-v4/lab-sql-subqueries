USE SAKILA;
--- 1
SELECT film_id
FROM film
WHERE title = 'Jorobado: Imposible';

SELECT COUNT(*) AS cantidad_copias
FROM inventory
WHERE film_id = (
SELECT film_id 
FROM film 
WHERE title = 'Jorobado: Imposible');

--- 2
SELECT AVG(length)
FROM film; 

SELECT title, length 
FROM film
WHERE length > (
SELECT AVG(length)
FROM film);

--- 3 actor_id, film_id
SELECT film_id
FROM film
WHERE title = 'Alone Trip';

SELECT actor_id
FROM film_actor
WHERE film_id = '17';

SELECT first_name, last_name
FROM actor
WHERE actor_id IN(
SELECT actor_id
FROM film_actor
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = 'Alone Trip'));

--- 4
SELECT category_id
FROM category
WHERE name = 'Family';

SELECT film_id
FROM film_category
WHERE category_id = '8';

SELECT title
FROM film
WHERE film_id IN(
SELECT film_id
FROM film_category
WHERE category_id = (
SELECT category_id
FROM category
WHERE name = 'Family'));

--- 5

SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, c.email
FROM customer as c
JOIN address as a ON c.address_id = a.address_id
JOIN city as ci ON a.city_id = ci.city_id
JOIN country as co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

--- 6 actor que ha actuado en la mayor cantidad de películas. 
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

SELECT title
FROM film AS f
WHERE film_id IN(
SELECT film_id
FROM film_actor AS fa
WHERE fa.actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1));

--- 7
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

SELECT f.title
FROM film AS f
WHERE f.film_id IN (
SELECT r.film_id
FROM rental AS r
WHERE r.customer_id = (
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1));

--- 8
SELECT SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id;

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
SELECT AVG(total_spent)
FROM (
SELECT SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id) AS customer_totals);