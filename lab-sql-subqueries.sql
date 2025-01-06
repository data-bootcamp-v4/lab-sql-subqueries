-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
USE sakila;
SELECT * FROM film;
SELECT * FROM inventory;
SELECT film.film_id, film.title, COUNT(inventory.inventory_id) AS number_copies FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
WHERE title ='Hunchback Impossible'
GROUP BY film.film_id;
-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT film.film_id, film.title, film.length, 
       (SELECT AVG(length) FROM film) AS avg_length
FROM film
WHERE film.length > (SELECT AVG(film.length) from film);
-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT actor.actor_id, actor.first_name, actor.last_name, film.title
FROM actor
INNER JOIN film_actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film
ON film.film_id = film_actor.film_id
WHERE film.title =  "Alone Trip";
-- Bonus:
-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT film.title, category.name
FROM category
INNER JOIN film_category
ON film_category.category_id = category.category_id
INNER JOIN film
ON film.film_id = film_category.film_id 
WHERE name = "Family"
ORDER BY title ASC;
-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT * FROM customer; 
SELECT * FROM country; 
SELECT * FROM store; 
SELECT * FROM city; 
SELECT * FROM address; 
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
WHERE customer.address_id IN (
    SELECT address.address_id
	FROM address
    INNER JOIN city ON address.city_id = city.city_id
    INNER JOIN country ON city.country_id = country.country_id
    WHERE country.country = "Canada"
);
-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;
SELECT film.title, actor.first_name, actor.last_name
FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
INNER JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);
-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
SELECT customer.first_name, customer.last_name, film.title
FROM customer
INNER JOIN rental ON rental.customer_id = customer.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
WHERE customer.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
LIMIT 0, 1000;


