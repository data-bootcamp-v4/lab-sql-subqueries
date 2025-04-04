-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory.film_id),
film.title
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'HUNCHBACK IMPOSSIBLE'
GROUP BY film.title;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT AVG(film.length) FROM film;

SELECT film.title, film.length
FROM film
WHERE film.length > (SELECT AVG(film.length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT CONCAT(first_name, ' ', last_name) AS actor
FROM actor
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor 
    WHERE film_id = (
        SELECT film_id FROM film WHERE title = 'ALONE TRIP'
    )
);

    
    
Bonus:

Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.