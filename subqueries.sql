USE sakila;

-- 1

SELECT COUNT(i.film_id) AS num_film, f.title FROM sakila.inventory AS i
JOIN sakila.film AS f
ON i.film_id = f.film_id
GROUP BY f.title
HAVING  f.title = 'Hunchback Impossible';

-- 2

SELECT film_id, title FROM sakila.film
WHERE length > ( SELECT AVG(length) FROM sakila.film);

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.actor_id, a.first_name, a.last_name FROM actor AS a
JOIN film_actor AS fa
ON fa.actor_id = a.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');

-- 4

SELECT title FROM film 
WHERE film_id IN (SELECT fc.film_id FROM film_category AS fc
JOIN category AS c
ON c.category_id = fc.category_id
WHERE c.name = 'Family');

-- 5 Retrieve the name and email of customers from Canada

SELECT c.first_name, c.last_name, c.email FROM customer AS c
JOIN address AS a
ON a.address_id = c.address_id
JOIN city
ON city.city_id = a.city_id
WHERE city.country_id = (SELECT country_id FROM country WHERE country = 'Canada');

-- 6
SELECT title FROM film AS f
JOIN film_actor as fa
ON f.film_id = fa.film_id
WHERE fa.actor_id = 
(SELECT actor_id FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1);


-- 7
SELECT title FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE i.inventory_id IN
(SELECT inventory_id FROM rental
WHERE customer_id =
(SELECT customer_id FROM payment
GROUP BY customer_id
ORDER BY SUM(AMOUNT) DESC
LIMIT 1));

-- 8 

-- Retrieve the client_id and the total_amount_spent of those clients who spent more than 
-- the average of the total_amount spent by each client. 

SELECT customer_id, SUM(amount) AS  total_amount_spent FROM payment
GROUP BY customer_id
HAVING total_amount_spent > ( 
 SELECT AVG(customer_total)
    FROM (
        SELECT SUM(amount) AS customer_total
        FROM payment
        GROUP BY customer_id
    ) AS totals
)








