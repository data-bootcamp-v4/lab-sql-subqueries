USE sakila;

# Write SQL queries to perform the following tasks using the Sakila database:
# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
/*#get info from hunchback
SELECT *
FROM film
WHERE title = "Hunchback Impossible";

#count the number of copies per film_id
SELECT film_id,
		COUNT(film_id) AS number_of_copies 
FROM inventory as i
GROUP BY film_id;*/

# gather everything in a single table
SELECT title,
		number_of_copies
FROM film f
INNER JOIN (SELECT film_id,
		COUNT(film_id) AS number_of_copies 
		FROM inventory as i
		GROUP BY film_id) AS cop
ON f.film_id = cop.film_id
WHERE title = "Hunchback Impossible";

# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
#get the average length of all films
SELECT AVG(length) AS avg_length
FROM film;

SELECT title,
		length
FROM film
WHERE length > (SELECT AVG(length) AS avg_length FROM film)
ORDER BY length DESC;


# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
/*# get the info from "Alone Trip"
SELECT * 
FROM film f
WHERE title = "Alone Trip";

# get the actors id for "Alone Trip"
SELECT 	f.film_id,  
		f.title,
		alone.actor_id
FROM film f
INNER JOIN (SELECT * 
			FROM film_actor as fa
			) AS alone
ON f.film_id = alone.film_id
WHERE title = "Alone Trip") AS actors
*/

SELECT a.actor_id AS actor_id,
		CONCAT(a.first_name,' ', a.last_name) AS name,
        actors.title AS title
FROM actor a
INNER JOIN (SELECT 	f.film_id,  
			f.title,
			alone.actor_id
		FROM film f
		INNER JOIN (SELECT * 
				FROM film_actor as fa
				) AS alone
		ON f.film_id = alone.film_id
		WHERE title = "Alone Trip") AS actors
ON a.actor_id = actors.actor_id;
 
#Bonus:
#4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
#5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
#6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
#7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
#8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.