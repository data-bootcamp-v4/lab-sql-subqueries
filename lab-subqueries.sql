USE SAKILA;
SELECT * FROM inventory;

#1
SELECT title, COUNT(i.inventory_id) AS Number_of_Copies
FROM film f
JOIN inventory i
on f.film_id = i.film_id
WHERE f.title = 'HUNCHBACK IMPOSSIBLE';

#2
SELECT AVG(length)from film;

SELECT title, length FROM film
     WHERE length> (SELECT AVG(length)from film);
     
#3

SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM film_actor;


SELECT first_name, last_name FROM actor WHERE actor_id IN
(SELECT actor_id from film_actor 
WHERE film_id =(SELECT film_id from film WHERE title = "ALONE TRIP"));

#4
SELECT f.title AS "Family Film Title"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family'
ORDER BY f.title;

#5 

SELECT
    c.first_name,
    c.last_name,
    c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY c.last_name, c.first_name;









