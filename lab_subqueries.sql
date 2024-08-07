# LAB | SQL Subqueries
## Challenge
USE sakila;
#1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title, COUNT(inv.inventory_id) AS "Number of copies"
FROM film AS f
LEFT JOIN inventory AS inv ON f.film_id = inv.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

#2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT f.title AS 'Movies longer than average', f.length AS 'Length'
FROM film f
WHERE f.length > (SELECT AVG(f1.length) from film f1)
ORDER BY f.length;

#3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT CONCAT(a.first_name,' ',a.last_name) AS 'Actors Name from film Alone Trip'
FROM actor a
	WHERE a.actor_id IN (SELECT fa.actor_id FROM film_actor fa 
						WHERE fa.film_id = (SELECT f.film_id FROM film f WHERE f.title = ("Alone Trip")))
ORDER BY a.first_name; 

