-- Select the database
USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS copies_number
FROM inventory AS i
WHERE i.film_id = (SELECT film_id
FROM film AS f
WHERE f.title = "Hunchback Impossible");

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title
FROM film AS f
WHERE f.length > (SELECT AVG(length)
FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT f.name
FROM film AS f
WHERE f.name = 'Alone Trip'