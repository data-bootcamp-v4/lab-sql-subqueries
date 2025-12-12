use sakila;

# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(inventory_id) AS number_of_copies
FROM inventory
WHERE
    film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'HUNCHBACK IMPOSSIBLE'
    );

# 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > 
        (SELECT AVG(length)
        FROM film)
ORDER BY length DESC;

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
        SELECT actor_id
        FROM film_actor
        WHERE film_id = (
                SELECT film_id
                FROM film
                WHERE title = 'ALONE TRIP')
    );
    

# 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 

SELECT f.title
FROM film AS f
WHERE f.film_id IN (
        SELECT fc.film_id
        FROM film_category AS fc
        WHERE fc.category_id = (
                SELECT c.category_id
                FROM category AS c
                WHERE c.name = 'Family')
    );

# 5. Retrieve the name and email of customers from Canada using both subqueries and joins.

SELECT c.first_name, c.last_name, c.email
FROM customer AS c
INNER JOIN address AS a ON c.address_id = a.address_id
INNER JOIN city AS cy ON a.city_id = cy.city_id
INNER JOIN country AS co ON cy.country_id = co.country_id
WHERE co.country = 'Canada';

# 6. Determine which films were starred by the most prolific actor in the Sakila database.

SELECT f.title
FROM film AS f
INNER JOIN film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (

        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    );
 
# 7. Find the films rented by the most profitable customer in the Sakila database. 

SELECT DISTINCT f.title
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
        -- Subquery 1: Find the ID of the most profitable customer
        SELECT customer_id
        FROM payment
        GROUP BY customer_id
        ORDER BY SUM(amount) DESC
        LIMIT 1
    );
    
# 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 

 SELECT customer_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING
    SUM(amount) > (
        SELECT
            AVG(total_spent)
        FROM (
            SELECT
                SUM(amount) AS total_spent
            FROM payment
            GROUP BY customer_id) AS customer_totals
    )
ORDER BY total_amount_spent DESC;   
