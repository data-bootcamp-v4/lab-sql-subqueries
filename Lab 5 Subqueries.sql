USE sakila;

SELECT *
FROM inventory;

SELECT *
FROM film
WHERE title = "Hunchback Impossible";

SELECT film_id, COUNT(inventory_id)
FROM inventory
GROUP BY film_id;

SELECT COUNT(inventory_id), title
FROM film f 
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossilbe";

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);


SELECT title, first_name, last_name
FROM film f 
INNER JOIN film_actor a 
ON f.film_id = a.film_id
INNER JOIN actor aa
ON a.actor_id = aa.actor_id
WHERE title = "Alone Trip";

SELECT first_name, last_name 
FROM sakila.actor 
WHERE actor_id IN (SELECT actor_id FROM sakila.film_actor WHERE film_id = (SELECT film_id FROM sakila.film WHERE title = 'Alone Trip'));

SELECT *
FROM category;

SELECT DISTINCT title, name
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
INNER JOIN film f                                                            
ON fc.film_id = fc.film_id
WHERE name = "family";                                                                                                                                                                                                                                      

SELECT first_name, last_name, email, country
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ci
ON ci.city_id = a.city_id
INNER JOIN country co
ON co.country_id = ci.country_id
WHERE country = "Canada";		

SELECT *
FROM film_actor;


SELECT actor_id, COUNT(*) AS actor_count
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
GROUP BY actor_id
ORDER BY actor_count DESC;
	
SELECT actor_id, title
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
WHERE actor_id = "107";

SELECT p.customer_id, amount, film_id
FROM payment p
INNER JOIN rental r
ON p.customer_id = r.customer_id
INNER JOIN inventory i
ON r.inventory_id = i.inventory_id;

SELECT customer_id, SUM(amount) as SUM
FROM payment
GROUP BY customer_id
ORDER BY SUM DESC;

SELECT customer_id, SUM(amount) as Sum
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment)
GROUP BY customer_id;

