USE sakila;

# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
# I find it easier to do it with JOIN instead of a subquery
SELECT 
	COUNT(inventory.film_id) AS number_copies
FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible';

# here with subquery
SELECT COUNT(film_id) AS number_copies
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible');

# List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title,
	length AS length_in_min
FROM film
WHERE length > 
	(SELECT ROUND(AVG(film.length), 0) 
    FROM film);

# Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT actor.first_name,
	actor.last_name
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = (
    SELECT title 
    FROM film 
    WHERE title = 'Alone Trip');

# Bonus:
# Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
# Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
# Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
# Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
# Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.