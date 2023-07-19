/*
    1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
*/
SELECT film_id, title
FROM sakila.film
WHERE title = 'Hunchback Impossible';

SELECT film_id, COUNT(*) AS total_copies
FROM sakila.inventory
WHERE inventory.film_id = (SELECT film_id
							FROM sakila.film
							WHERE title = 'Hunchback Impossible')
GROUP BY inventory.film_id;

/*
    2. List all films whose length is longer than the average length of all the films in the Sakila database.
*/
SELECT AVG(length)
FROM sakila.film;

SELECT title, length
FROM sakila.film
WHERE film.length > (SELECT AVG(length) FROM sakila.film);

/*
    3. Use a subquery to display all actors who appear in the film "Alone Trip".
*/
SELECT film_actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name) AS full_name
FROM sakila.film_actor
INNER JOIN (SELECT film_id
			FROM sakila.film
			WHERE title = 'Alone Trip') AS alone
ON film_actor.film_id = alone.film_id
INNER JOIN sakila.actor
ON film_actor.actor_id = actor.actor_id;

/*
    4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
    Identify all movies categorized as family films.
*/
CREATE TEMPORARY TABLE sakila.family_film
SELECT film_category.film_id
FROM sakila.film_category
WHERE film_category.category_id = (SELECT category.category_id
									FROM sakila.category
									WHERE category.name = 'Family');
SELECT *
FROM sakila.family_film;

SELECT *
FROM sakila.film
INNER JOIN sakila.family_film
ON film.film_id = family_film.film_id;

/*
    5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
    To use joins, you will need to identify the relevant tables and their primary and foreign keys.
*/
SELECT *
FROM sakila.city;

SELECT *
FROM sakila.address
INNER JOIN sakila.customer
ON address.address_id = customer.address_id;

SELECT country_id
FROM sakila.country
WHERE country = 'Canada';

SELECT customer.first_name, customer.last_name, customer.email, address.city_id, city.country_id
FROM sakila.address
INNER JOIN sakila.customer
ON address.address_id = customer.address_id
INNER JOIN sakila.city
ON address.city_id = city.city_id
WHERE city.country_id = (SELECT country_id
							FROM sakila.country
							WHERE country = 'Canada');

/*
    6. Determine which films were starred by the most prolific actor in the Sakila database. 
    A prolific actor is defined as the actor who has acted in the most number of films. 
    First, you will need to find the most prolific actor and then use that actor_id to find 
    the different films that he or she starred in.
*/


SELECT film_id, prolific_actors.actor_id, num_films
FROM sakila.film_actor
INNER JOIN
		(SELECT actor_id, COUNT(*) AS num_films
		FROM sakila.film_actor
		GROUP BY actor_id
		ORDER BY num_films DESC) AS prolific_actors
ON film_actor.actor_id = prolific_actors.actor_id;

/*    
    7. Find the films rented by the most profitable customer in the Sakila database. 
    You can use the customer and payment tables to find the most profitable customer, i.e., 
    the customer who has made the largest sum of payments.
*/

SELECT customer_id, SUM(payment.amount) AS total_spent
FROM sakila.payment
GROUP BY payment.customer_id
ORDER BY total_spent DESC;

CREATE TEMPORARY TABLE sakila.spent_by_customer
SELECT customer_id, SUM(payment.amount) AS total_spent
FROM sakila.payment
GROUP BY payment.customer_id
ORDER BY total_spent DESC;

SELECT *
FROM sakila.spent_by_customer;

SELECT MAX(total_spent) AS max_spent FROM sakila.spent_by_customer;

SELECT *
FROM sakila.spent_by_customer
WHERE total_spent = (SELECT MAX(sakila.spent_by_customer.total_spent) FROM sakila.spent_by_customer);


/*
    8. Retrieve the client_id and the total_amount_spent of those clients who 
    spent more than the average of the total_amount spent by each client. 
    You can use subqueries to accomplish this.
*/

SELECT AVG(total_spent)
FROM	(SELECT customer_id, SUM(payment.amount) AS total_spent
		FROM sakila.payment
		GROUP BY payment.customer_id
		ORDER BY total_spent DESC) AS f;

SELECT customer_id, SUM(payment.amount) AS total_spent
FROM sakila.payment
GROUP BY payment.customer_id
WHERE total_spent > (
				SELECT AVG(total_spent)
				FROM	(SELECT customer_id, SUM(payment.amount) AS total_spent
						FROM sakila.payment
						GROUP BY payment.customer_id
						ORDER BY total_spent DESC) AS f
        );
#ORDER BY total_spent DESC;
