/* Write SQL queries to perform the following tasks using the Sakila database:

Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
List all films whose length is longer than the average length of all the films in the Sakila database.
Use a subquery to display all actors who appear in the film "Alone Trip".
Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this. */

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

Select title, count(title) FROM sakila.inventory
INNER JOIN sakila.film on sakila.inventory.film_id = sakila.film.film_id and film.title LIKE "Hunchback Impossible"
GROUP BY film.title;

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT * FROM sakila.film
WHERE film.length > (SELECT avg(film.length) FROM sakila.film);


-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT title, first_name, last_name FROM sakila.actor 
JOIN sakila.film_actor ON sakila.actor.actor_id = sakila.film_actor.actor_id
JOIN sakila.film ON sakila.film_actor.film_id = sakila.film.film_id
AND film.title LIKE 'alone trip';


-- Identify all movies categorized as family films

SELECT title, category.name from sakila.film
JOIN sakila.film_category ON sakila.film.film_id = sakila.film_category.film_id
JOIN sakila.category on sakila.film_category.category_id = sakila.category.category_id
AND category.name LIKE 'family';

-- Retrieve the name and email of customers from Canada using both subqueries and joins.

SELECT first_name, last_name, email, country FROM sakila.customer
JOIN sakila.address ON sakila.customer.address_id = sakila.address.address_id
JOIN sakila.city on sakila.address.city_id = sakila.city.city_id
JOIN sakila.country on sakila.city.country_id = sakila.country.country_ID
AND country.country LIKE 'CANADA';

-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT actor_ID, count(film_id) FROM sakila.film_actor
GROUP BY actor_ID
ORDER BY count(film_ID) DESC
LIMIT 1;

-- actor ID = 107

SELECT title, actor_id FROM sakila.film_actor
JOIN sakila.film ON sakila.film_actor.film_id = sakila.film.film_id
WHERE actor_id = 107;

-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
                    
SELECT concat(first_name, ' ' , last_name), sum(amount) FROM sakila.customer
JOIN sakila.payment ON sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY concat(first_name, ' ' , last_name)
ORDER BY sum(amount) DESC
LIMIT 1;

-- Karl Seal is most profitable customer

SELECT customer_ID FROM sakila.customer
WHERE last_name like 'seal';

-- 526 is customer id

SELECT * from sakila.rental
WHERE customer_id = (SELECT customer_ID FROM sakila.customer
					WHERE last_name like 'seal');


-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this. */

SELECT concat(first_name, ' ' , last_name), (sum(amount)) FROM sakila.customer
JOIN sakila.payment ON sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY concat(first_name, ' ' , last_name)
ORDER BY (sum(amount)) DESC;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, SUM(amount) AS total_amount FROM sakila.customer
JOIN sakila.payment ON sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY full_name
HAVING SUM(amount) > 117
ORDER BY total_amount DESC



