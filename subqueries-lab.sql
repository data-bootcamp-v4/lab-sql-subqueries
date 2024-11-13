USE Sakila;
-- EXERCISE 1
SELECT COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';
-- EXERCISE 2
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
-- EXERCISE 3
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');
-- BONUS
-- EXERCISE 4
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';
-- EXERCISE 5
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN 
                     (SELECT city_id FROM city WHERE country_id = 
                      (SELECT country_id FROM country WHERE country = 'Canada')));

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
-- EXERCISE 6
-- STEP 1
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;
-- STEP 2
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = [most_prolific_actor_id];
-- EXERCISE 7
-- STEP 1
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;
-- STEP 2
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = [most_profitable_customer_id];
-- EXERCISE 8
SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(total_amount) FROM (SELECT customer_id, SUM(amount) AS total_amount FROM payment GROUP BY customer_id) AS client_totals);