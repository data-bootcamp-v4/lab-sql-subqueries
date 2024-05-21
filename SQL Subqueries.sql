USE sakila;

-- Number one -- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS copies_of_hunchback
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

-- Number two -- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length FROM film WHERE length > (SELECT AVG(length) FROM film);

-- Number three -- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));


-- Bonus -- four -- Identify all movies categorized as family films. 
SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = 'Family'));

-- Bonus -- five -- subqueries -- Retrieve the name and email of customers from Canada 

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN (SELECT city_id FROM city WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')));

-- Bonus - five -- joins --  Retrieve the name and email of customers from Canada 

SELECT c.first_name,c.last_name,c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- Bonus - six -- Determine which films were starred by the most prolific actor in the Sakila database.

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN (SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(film_id) DESC LIMIT 1) most_prolific_actor ON fa.actor_id = most_prolific_actor.actor_id;

-- Bonus - seven -- Find the films rented by the most profitable customer in the Sakila database.

SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN (SELECT customer_id FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 1) 
most_profitable_customer ON r.customer_id = most_profitable_customer.customer_id;

-- Bonus - eight -- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

SELECT customer_id,SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(total_amount_spent)
FROM (SELECT SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id) AS avg_amount_spent);

