USE sakila;
# Challenge
# Write SQL queries to perform the following tasks using the Sakila database:

# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(inventory_id)
FROM inventory
WHERE film_id =
				(SELECT film_id
				FROM film
				WHERE title = "Hunchback Impossible");


# 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) AS avg_lenght
				FROM film);

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name, last_name
FROM actor WHERE actor_id IN ( 
				SELECT actor_id
				FROM film_actor
				WHERE film_id = 
					(SELECT film_id
					FROM film
					WHERE title = "alone trip"));

# 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
# Identify all movies categorized as family films.

SELECT film.title
FROM FILM
WHERE film_id IN 
				(SELECT film_id
				FROM film_category
				WHERE category_id = 
					(SELECT category_id
					FROM category
					WHERE category.name = "family"));

# 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
# To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
INNER JOIN address
USING (address_id)
INNER JOIN city
USING (city_id)
WHERE city_id IN 
				(SELECT city_id
				FROM city
                WHERE country_id = 
					(SELECT country_id
					FROM country
					WHERE country = "Canada"));

# 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined 
# as the actor who has acted in the most number of films. First, you will need to find the 
# most prolific actor and then use that actor_id to find the different films that he or she starred in.

# find the most prolific actor

SELECT film.title
FROM film
INNER JOIN film_actor
USING (film_id)
WHERE actor_id = 
				(SELECT actor_id
				FROM film_actor
				GROUP BY actor_id
				ORDER BY COUNT(film_id) DESC
				LIMIT 1);

#  7. Find the films rented by the most profitable customer in the Sakila database. 
# You can use the customer and payment tables to find the most profitable customer, i.e., 
# the customer who has made the largest sum of payments.

SELECT film.title
FROM film
INNER JOIN inventory
USING (film_id)
INNER JOIN rental
USING (inventory_id)
WHERE customer_id =
					(SELECT customer_id
                    FROM payment
                    GROUP BY customer_id
                    ORDER BY SUM(payment.amount)
                    LIMIT 1);

# 8. Retrieve the client_id and the total_amount_spent of those clients who spent more 
# than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT customer_id, SUM(amount) AS amount_spent
FROM payment
GROUP BY customer_id
HAVING amount_spent > (
						SELECT AVG(table1.total_amount)
                        FROM (SELECT SUM(amount) as total_amount
                        FROM payment
                        GROUP BY customer_id) AS table1);



