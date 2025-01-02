USE sakila;

# 1
SELECT film_id 
FROM film
WHERE title = "Hunchback Impossible";

SELECT COUNT(*) AS film_copies 
FROM inventory
WHERE film_id = (
	SELECT film_id 
	FROM film
	WHERE title = "Hunchback Impossible"
);

# 2

SELECT AVG(length) AS avg_length FROM film;

SELECT title, length 
FROM film
WHERE length > (SELECT AVG(length) AS avg_length FROM film);

# 3

SELECT * FROM actor;
SELECT * FROM film_actor;


SELECT film_id 
FROM film
WHERE title = "Alone Trip";


SELECT actor_id, film_id 
FROM film_actor
WHERE film_id = (
	SELECT film_id 
	FROM film
	WHERE title = "Alone Trip");


SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
	)
);

# 4

SELECT * FROM film_category;

SELECT category_id FROM category WHERE name = "Family";

SELECT film_id 
FROM film_category 
WHERE category_id = (
	SELECT category_id 
    FROM category 
    WHERE name = "Family");
    
SELECT title 
FROM film
WHERE film_id IN (
	SELECT film_id 
	FROM film_category 
	WHERE category_id = (
		SELECT category_id 
		FROM category 
		WHERE name = "Family")
        );
        
# 5

SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;



SELECT country_id FROM country WHERE country = "Canada";

SELECT city_id, country_id FROM city WHERE country_id = (SELECT country_id FROM country WHERE country = "Canada");

SELECT address_id 
FROM address
WHERE city_id IN (
	SELECT city_id
    FROM city 
    WHERE country_id = (
		SELECT country_id 
        FROM country 
        WHERE country = "Canada")
        );
        
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
			WHERE country = "Canada")
			));

# 6

SELECT * FROM film;
SELECT * FROM film_actor;

SELECT f.title
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);

# 7

SELECT * FROM customer;
SELECT * FROM payment;


SELECT customer_id, SUM(amount) AS total_payment 
FROM payment
GROUP BY customer_id
ORDER BY total_payment DESC
LIMIT 1;

SELECT first_name, last_name, email FROM customer
WHERE customer_id = (
	SELECT customer_id AS total_payment 
	FROM payment
	GROUP BY customer_id
	ORDER BY SUM(amount) DESC
	LIMIT 1)
;

# 8 

SELECT * FROM payment;
SELECT * FROM customer;


SELECT customer_id, SUM(amount) AS total_amount_spent 
FROM payment
GROUP BY customer_id;

SELECT AVG(total_amount_spent) 
FROM (
	SELECT customer_id, SUM(amount) AS total_amount_spent 
    FROM payment
	GROUP BY customer_id)
AS average_amount;


SELECT * FROM (
	SELECT customer_id, SUM(amount) AS total_amount_spent 
	FROM payment
	GROUP BY customer_id
    ) AS avg_per_customer
WHERE total_amount_spent > (
	SELECT AVG(total_amount_spent) 
	FROM (
	SELECT customer_id, SUM(amount) AS total_amount_spent 
    FROM payment
	GROUP BY customer_id)
	AS average_amount
    );