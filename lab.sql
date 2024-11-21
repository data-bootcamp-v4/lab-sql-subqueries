USE sakila;
SELECT count(*) as 'Hunchback_Impossible_count' FROM inventory 
WHERE film_id = (SELECT film_id FROM film WHERE title like('%Hunchback Impossible%'))
GROUP BY film_id;

SELECT title FROM film WHERE length > (SELECT AVG(length) AS media FROM film);

SELECT first_name, last_name FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERe film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'))

SELECT * FROM film WHERE film_id IN (SELECT film_id FROM film_category  WHERE category_id = (SELECT category_id FROM category WHERE name='Family'));

SELECT c.first_name, c.email FROM address AS a
JOIN customer AS c
ON c.address_id = a.address_id
WHERE city_id IN (SELECT city_id FROM city WHERE country_id = (SELECT country_id FROM Country WHERE country='CANADA'));

SELECT f.title FROM film_actor AS fa
JOIN film AS f
ON f.film_id = fa.film_id
WHERE fa.actor_id = (SELECT actor_id as total FROM film_actor
GROUP BY actor_id
ORDER BY total DESC LIMIT 1);

SELECT f.title FROM rental AS r
JOIN inventory AS i
JOIN film AS f
ON i.inventory_id = r.inventory_id AND f.film_id = i.film_id
WHERE customer_id = (
    SELECT customer_id FROM payment 
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    LIMIT 1);

SELECT * FROM inventory;

SHOW TABLES;
SELECT customer_id, SUM(amount) AS 'total_spend' FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment)
GROUP BY customer_id;