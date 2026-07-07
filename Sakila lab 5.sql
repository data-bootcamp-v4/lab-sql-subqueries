USE sakila;

SELECT COUNT(*) AS copies_in_inventory
FROM inventory
WHERE film_id = (
	SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

SELECT title, length
FROM film
WHERE length > (
	SELECT AVG(length)
    FROM film
);

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);

SELECT title
FROM film
WHERE film_id IN (
	SELECT fc.film_id
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Family'
);

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
	SELECT a.address_id
    FROM address a
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    WHERE co.country = 'Canada'
);

SELECT
	cu.first_name,
    cu.last_name,
    email
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
	SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);

SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

SELECT
	customer_id AS client_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
	SELECT AVG(customer_total)
    FROM (
		SELECT SUM(amount) AS customer_total
        FROM payment
        GROUP BY customer_id
	) AS customer_totals
);