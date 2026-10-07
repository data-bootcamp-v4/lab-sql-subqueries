use sakila;

SELECT * FROM film;

SELECT * FROM inventory;

SELECT film_id FROM inventory;

SELECT film_id, title FROM film
WHERE title = "Hunchback Impossible"
;

SELECT COUNT(*) 
FROM inventory AS i
JOIN film AS f 
ON i.film_id = f.film_id
WHERE title = "Hunchback Impossible";

SELECT * FROM actor;

SELECT title, length FROM film
Where length > (SELECT AVG(length) FROM film);

SELECT film_id FROM film WHERE title = 'Alone Trip';

SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');


SELECT first_name, last_name FROM actor 
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));

SELECT * FROM film;

SELECT * FROM film_category;

SELECT * FROM film_text;

SELECT * FROM category;

SELECT f.title
FROM film AS f
JOIN film_category AS c
  ON f.film_id = c.film_id
JOIN category AS ca
  ON c.category_id = ca.category_id
WHERE ca.name = 'Family';