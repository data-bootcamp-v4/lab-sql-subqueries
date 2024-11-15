-- Challenge
-- Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT subquery.title AS "Hunchback Impossible", 
       subquery.number_of_copies
FROM (
    SELECT f.title, 
	COUNT(i.inventory_id) AS number_of_copies
    FROM inventory AS i
    JOIN film AS f
    ON i.film_id = f.film_id
    WHERE f.title = "Hunchback Impossible"
    GROUP BY f.title
) AS subquery
ORDER BY subquery.number_of_copies;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, AVG(length) AS 'Average' FROM film
GROUP BY title
HAVING Average > (SELECT ROUND(AVG(length),2) AS 'Average1' FROM film)
ORDER by Average desc;

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT subquery.first_name AS "first name", 
       subquery.last_name AS "last name"
FROM (
SELECT a.first_name, a.last_name
FROM film AS f
JOIN film_actor as fa
ON f.film_id = fa.film_id
JOIN actor as a
ON fa.actor_id = a.actor_id
WHERE f.title = "Alone Trip"
GROUP BY a.first_name, a.last_name
) AS subquery;

-- Bonus:
-- Sales have been lagging among young families, and you want to target family movies 
-- for a promotion. Identify all movies categorized as family films.
SELECT * FROM address;
SELECT * FROM film_category;
SELECT c.name AS category_name, COUNT(fm.film_id) As number_of_films FROM film_category AS fm
JOIN category as c
ON fm.category_id = c.category_id
WHERE c.name = "Family"
GROUP by c.name
ORDER by number_of_films;

-- Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);