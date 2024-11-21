USE sakila;
#Write SQL queries to perform the following tasks using the Sakila database:
# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(film_id) AS number_of_copies
FROM inventory
where film_id IN (SELECT film_id
                 FROM film
                 WHERE title = "Hunchback Impossible");

# List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
                FROM film);

# Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name
FROM actor
WHERE actor_id IN (SELECT actor_id
                  FROM film_actor
                  WHERE film_id IN (SELECT film_id 
                                   FROM film
                                   WHERE title = 'Alone Trip'));

# Find the films rented by the most profitable customer in the Sakila database. 
# You can use the customer and payment tables to find the most profitable customer, 
#i.e., the customer who has made the largest sum of payments.
                     
SELECT title 
FROM film
WHERE film_id IN (SELECT film_id
			      FROM inventory
                  WHERE inventory_id IN (SELECT inventory_id
										 FROM  rental
                                         WHERE customer_id = (SELECT customer_id
										                      FROM  payment
                                                              GROUP BY customer_id
                                                              ORDER by SUM(amount) DESC
										                      LIMIT 1)));                   



#Retrieve the client_id and the total_amount_spent of those clients 
# who spent more than the average of the total_amount spent by each client. 
# You can use subqueries to accomplish this.

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(total_pc)
                             FROM (SELECT customer_id, SUM(amount) AS total_pc
								   FROM payment
								   GROUP BY customer_id) AS ta);
                                