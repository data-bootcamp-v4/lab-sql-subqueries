USE sakila;

--- Write SQL queries to perform the following tasks using the Sakila database:

--- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS number_of_copies
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

--- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

--- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');