USE sakila;

-- 1

SELECT COUNT(*) AS numero_de_copias
FROM inventory i 
JOIN film f ON i.film_id = f.film_id
WHERE f.title = "Hunchback Impossible" ;

-- 2

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3 

SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip');

-- Bono 1

SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';


-- Bono 2 

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- Bono 3

SELECT actor_id, COUNT(film_id) AS numero_de_películas
FROM film_actor
GROUP BY actor_id
ORDER BY numero_de_películas DESC
LIMIT 1;

-- BONO 4






-- 5

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(total_amount) FROM (SELECT SUM(amount) AS total_amount FROM payment GROUP BY customer_id) AS subquery);
