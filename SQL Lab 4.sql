-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".
use sakila;

-- film_id in film attaches to inventory_id in inventory which can get back the title "Hunchback Impossible"
SELECT f.film_id, i.inventory_id, f.title
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE i.inventory_id IN
	(SELECT inventory_id	
    FROM inventory
    WHERE title LIKE 'Hunchback Impossible');

SELECT COUNT(*) AS num_copies
FROM (
    SELECT i.inventory_id
    FROM inventory AS i
    JOIN film AS f ON i.film_id = f.film_id
    WHERE f.title = 'Hunchback Impossible'
) AS copies_of_hunchback;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film AS f
WHERE length > (SELECT AVG(f.length) 
				FROM film AS f);

-- Use a subquery to display all actors who appear in the film "Alone Trip"
-- actor_id in actor to pull out names, actor_id in film_actor to connect to film_id in film & film title "Alone Trip"
SELECT title
FROM film
WHERE title = 'Alone Trip';

SELECT fa.actor_id, a.first_name, a.last_name
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id
		FROM film
		WHERE title = 'Alone Trip');


-- Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
select name
from category;

-- category id, film id, category name, film name
SELECT title
from film as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON c.category_id = fc.category_id
WHERE f.title IN
	(SELECT name
	FROM category as c
	WHERE name = 'Family');

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
);


-- Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

#name and email in customer table
#customer table connects to address table through address_id
#address table has city_id
#city_id is in city table which connects to country table through country id
#country table has country where i can find Canada

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN 
 (SELECT address_id
  FROM address
  WHERE city_id IN
	(SELECT city_id
    FROM city
    WHERE country_id =
		(SELECT country_id
		FROM country
		WHERE country = 'Canada')));
        

-- Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.







