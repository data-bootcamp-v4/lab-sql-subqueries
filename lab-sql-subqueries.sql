USE sakila;

SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (
	SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);

SELECT title, length
FROM film
WHERE length > (
	SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;

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
)
ORDER BY last_name, first_name;

SELECT f.title
FROM film f
WHERE f.film_id IN (
	SELECT fc.film_id
    FROM film_category fc
    WHERE fc.category_id = (
		SELECT category_id
        FROM category
        WHERE name = 'Family'
	)
)
ORDER BY f.title;

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

SELECT actor_id, COUNT(*) AS num_films
FROM film_actor
GROUP BY actor_id
ORDER BY num_films DESC
LIMIT 1;

SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

SELECT DISTINCT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.customer_id = (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
	SELECT AVG(total_spent)
    FROM (
		SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
	) AS t
)
ORDER BY total_amount_spent DESC;