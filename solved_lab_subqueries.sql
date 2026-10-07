USE sakila;

-- 1
SELECT * FROM inventory;
SELECT * FROM film;

SELECT COUNT(i.inventory_id)
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";

-- 2
SELECT * FROM film;
SELECT AVG(length) FROM film;

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3
SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT film_id
FROM film
WHERE title = "Alone Trip";

SELECT actor_id
FROM film_actor;

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = "Alone Trip"));

-- 4
SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM film_category;

SELECT category_id
FROM category
WHERE name = "Family";

SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category
WHERE category_id = (SELECT category_id FROM category WHERE name = "Family"));

-- 5
SELECT * FROM customer;
SELECT * FROM country;
SELECT * FROM address;
SELECT * FROM city;

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address
WHERE city_id IN (SELECT city_id FROM city
WHERE country_id = (SELECT country_id FROM country
WHERE country = "Canada")));

SELECT c.first_name, c.last_name, c.email
FROM customer AS c
JOIN address AS a
ON c.address_id = a.address_id
JOIN city AS ci
ON a.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id
WHERE co.country = "Canada";

-- 6
SELECT * FROM film_actor;

SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

SELECT * FROM film;

SELECT title
FROM film
WHERE film_id IN(SELECT film_id
					FROM film_actor
					WHERE actor_id = (SELECT actor_id
										FROM film_actor
										GROUP BY actor_id
										ORDER BY COUNT(film_id) DESC
										LIMIT 1));

-- 7
SELECT * FROM payment;
SELECT * FROM customer;

SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

SELECT DISTINCT f.title
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (SELECT customer_id
						FROM payment
						GROUP BY customer_id
						ORDER BY SUM(amount) DESC
						LIMIT 1);

-- 8
SELECT * FROM payment;

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(total_spent)
FROM (SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id) AS customer_totals);


