USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- Join inventory with film ON film_id

-- inventory.inventory_id - Number of copies (output)
-- inventory.film_id

-- film.film_id
-- film.title - Name of movie (output)

-- The output columns I want to show --
SELECT 
f.title,
COUNT(i.inventory_id) AS copies_in_inventory
FROM film as f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
title,
length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

-- * Join actor with film_actor on actor_id
-- * Join with film on film_id

-- actor.first_name
-- actor.last_name
-- actor.actor_id

-- film_actor.actor_id
-- film_actor.film_id

-- film.film_id
-- film.title

-- The output columns I want to show --
SELECT
a.first_name,
a.last_name
FROM actor AS a
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Alone Trip'));

-- 4. Identify all movies categorized as family films.

-- * Join category to film_category
-- * Join film_category to film

-- category.name
-- category.category_id

-- film_category.category_id
-- film_category.film_id

-- film.film_id
-- film.title

-- The output columns I want to show --
SELECT
f.title
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
WHERE fc.category_id IN (SELECT c.category_id FROM category AS c WHERE c.name = 'Family');

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

-- country.country
-- country.country_id
-- city.country_id
-- city.city_id
-- address.city_id
-- address.address_id
-- customer.address_id

-- The output columns I want to show --
SELECT
	c.first_name,
	c.last_name,
	c.email
FROM customer AS c
JOIN address AS a
	ON c.address_id = a.address_id
JOIN city AS ci
	ON a.city_id = ci.city_id
WHERE ci.country_id IN (SELECT country.country_id FROM country WHERE country.country = 'Canada');




