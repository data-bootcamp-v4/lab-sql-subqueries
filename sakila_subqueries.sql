USE SAKILA;
SHOW TABLES;

SELECT *
FROM inventory;

SELECT *
FROM film;



SELECT COUNT(film_id) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);


# List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT
title,
length
FROM film
WHERE length > (SELECT AVG(length)
FROM film);


# Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT *
FROM film_list;

SELECT *
FROM film_actor;

SELECT
actors
FROM film_list
WHERE title = "Alone Trip";


SELECT
first_name,
last_name
FROM actor
WHERE actor_id IN (
SELECT actor_id
FROM film_actor 
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = "Alone Trip"));


# Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT *
FROM film_list;

SELECT *
FROM category;

SELECT
title,
category
FROM film_list
WHERE category = "Family";

SELECT
title
FROM film
WHERE film_id IN (
SELECT film_id
FROM film_category
WHERE category_id = (
SELECT category_id
FROM category
WHERE name = 'Family' ));

# Retrieve the name and email of customers from Canada using both subqueries and joins. 
# To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT *
FROM customer;

SELECT *
FROM address;

SELECT *
FROM city;

SELECT *
FROM country;


SELECT
c.first_name,
c.last_name,
c.email
FROM customer AS c
LEFT JOIN address AS a
ON a.address_id = c.address_id
LEFT JOIN city as ci
ON ci.city_id = a.city_id
WHERE country_id IN (
SELECT country_id 
FROM country 
WHERE country = 'Canada');


# Determine which films were starred by the most prolific actor in the Sakila database. 
# A prolific actor is defined as the actor who has acted in the most number of films. 
# First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SHOW TABLES;

SELECT *
FROM film;

SELECT *
FROM film_actor;

SELECT *
FROM actor;

SELECT *
FROM actor_info;


SELECT 
title
FROM film
WHERE film_id IN (
SELECT film_id
FROM film_actor
WHERE actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1));


SELECT 
f.title,
fa.actor_id,
a.first_name,
a.last_name
FROM film AS f
LEFT JOIN film_actor AS fa
ON  fa.film_id = f.film_id
LEFT JOIN actor AS a
ON a.actor_id = fa.actor_id
WHERE fa.actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1);


# Find the films rented by the most profitable customer in the Sakila database. 
# You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.


SELECT *
FROM film;

SELECT *
FROM inventory;

SELECT *
FROM rental;

SELECT *
FROM customer;

SELECT *
FROM payment;

SELECT
f.title,
c.customer_id,
c.first_name,
c.last_name
FROM film as f
LEFT JOIN inventory AS i
ON i.film_id = f.film_id
LEFT JOIN rental AS r
ON r.inventory_id = i.inventory_id
LEFT JOIN customer AS c
ON c.customer_id = r.customer_id
WHERE c.customer_id = (
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1);


