/*
Bonus:

Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.*/

#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT film.title, COUNT(inventory.film_id) as copies
FROM film
INNER JOIN inventory
ON film.film_id=inventory.film_id
WHERE title= "Hunchback Impossible"
GROUP BY film.title; 

#List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT *
from sakila.film
WHERE length > (SELECT AVG(length) FROM  sakila.film);

#Use a subquery to display all actors who appear in the film "Alone Trip"

SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM actor
INNER JOIN film_actor
ON actor.actor_id=film_actor.actor_id
WHERE film_actor.film_id IN (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip');
