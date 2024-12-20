USE sakila;
-- 1
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');
-- 2
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
-- 3
SELECT a.first_name, a.last_name 
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id 
    FROM film_actor fa
    WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));
-- 4
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';
-- 5
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id
    FROM address
    WHERE city_id IN (SELECT city_id 
		FROM city
        WHERE country_id = (SELECT country_id 
			FROM country
            WHERE country = 'Canada')));
-- 6
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1);
-- 7
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY 
    SUM(amount) DESC
    LIMIT 1);
-- 8
SELECT customer_id, total_amount_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE total_amount_spent > (
    SELECT AVG(total_spent)
    FROM (
		SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id) AS total_spent);