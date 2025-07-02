Use sakila;

-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT film_id, title from sakila.film
WHERE title = "Hunchback Impossible";


SELECT COUNT(*) from sakila.inventory
WHERE film_id IN (SELECT film_id from sakila.film
WHERE title = "Hunchback Impossible");

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length from sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film);

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT film_id from sakila.film
WHERE title like 'Alone Trip';

SELECT first_name, last_name From sakila.actor as a
JOIN sakila.film_actor as fa
ON a.actor_id = fa.actor_id
WHERE film_id IN (SELECT film_id from sakila.film
WHERE title = 'Alone Trip');

-- 4 Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.

SELECT title from sakila.film
WHERE  film_id  IN (SELECT film_id FROM sakila.film_category
WHERE category_id IN (Select category_id from sakila.category
WHERE name like 'Family'));


-- 5 Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.


SELECT first_name , last_name ,email FROM sakila.customer
WHERE address_id IN ( 


SELECT a.address_id FROM sakila.address as a
WHERE city_id IN (

SELECT ci.city_id FROM sakila.city as ci
WHERE country_id IN (
SELECT DISTINCT c.country_id from sakila.city AS ci
JOIN sakila.country AS c
ON c.country_id = ci.country_id
WHERE country = 'Canada')));




