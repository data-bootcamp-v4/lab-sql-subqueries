# Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS number_copies
FROM inventory AS i
INNER JOIN film as f
USING (film_id)
WHERE f.title = 'Hunchback Impossible';

#List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title
FROM film
WHERE length > (SELECT AVG(length) FROM film);

#Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id=(SELECT film_id
                    FROM film
					WHERE title = 'Alone Trip'));

#Bonus:

#Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT f.title
FROM film f
WHERE film_id IN (SELECT film_id
				FROM film_category
				WHERE category_id=(SELECT category_id
				FROM category
				WHERE name = 'Family'));

#Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
#Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
#Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
#Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
