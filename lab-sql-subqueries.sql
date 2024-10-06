USE sakila;

#1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT * FROM inventory; 
SELECT * FROM film; 

SELECT COUNT(film_id) as copies_of_hunchback_impossible
FROM inventory
WHERE film_id = (
	SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible');

#2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length 
FROM film
WHERE length > (
	SELECT AVG(length)FROM film);

#3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT * FROM film;
SELECT * FROM actor;

SELECT actor_id, first_name, last_name 
FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
    WHERE(SELECT film_id FROM film WHERE title = "Alone Trip"));