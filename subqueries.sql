#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system

USE sakila;
SHOW TABLES;

DESCRIBE film;
DESCRIBE inventory;

SELECT * from film LIMIT 5;

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
); #Number of copies 6

#2 List all films whose length is longer than the average length of all the films in the Sakila database

DESCRIBE film;

SELECT AVG(length) AS average_length
FROM film; #The average as its own query

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

#3 Use a subquery to display all actors who appear in the film "Alone Trip"

DESCRIBE actor;
DESCRIBE film;
DESCRIBE film_actor;


SELECT * from film_actor LIMIT 35;

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
    )
);