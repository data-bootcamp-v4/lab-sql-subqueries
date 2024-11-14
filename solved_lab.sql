USE SAKILA;

-- 1
SELECT COUNT(i.inventory_id) AS num_copies FROM film AS f 
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

-- 2
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3
SELECT a.first_name, a.last_name FROM actor AS a
WHERE a.actor_id IN (SELECT fa.actor_id FROM film_actor AS fa WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));

-- 4 
SELECT f.title FROM film AS f
JOIN film_category AS fc 
ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Family';


