use sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT 
    f.title AS film_title,
    COUNT(i.inventory_id) AS number_of_copies
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Hunchback Impossible'
GROUP BY 
    f.title;
-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT 
    film_id,
    title,
    length
FROM 
    film
WHERE 
    length > (SELECT AVG(length) FROM film)
ORDER BY 
    length DESC;
-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name
FROM 
    actor a
WHERE 
    a.actor_id IN (
        SELECT 
            fa.actor_id
        FROM 
            film_actor fa
        JOIN 
            film f ON fa.film_id = f.film_id
        WHERE 
            f.title = 'Alone Trip'
    )
ORDER BY 
    a.last_name, a.first_name;
-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT 
    f.film_id,
    f.title,
    f.description,
    f.rating,
    f.length AS duration_minutes,
    CONCAT(FLOOR(f.length/60), 'h ', f.length%60, 'm') AS duration_formatted
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
WHERE 
    c.name = 'Family'
ORDER BY 
    f.title;
-- Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT 
    first_name, 
    last_name, 
    email
FROM 
    customer
WHERE 
    address_id IN (
        SELECT address_id
        FROM address
        WHERE city_id IN (
            SELECT city_id
            FROM city
            WHERE country_id = (
                SELECT country_id
                FROM country
                WHERE country = 'Canada'
            )
        )
    );
-- Determine which films were starred by the most prolific actor in the Sakila database.
-- A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- First find the most prolific actor, then get their films
WITH prolific_actor AS (
    SELECT 
        actor_id,
        COUNT(film_id) AS film_count
    FROM 
        film_actor
    GROUP BY 
        actor_id
    ORDER BY 
        film_count DESC
    LIMIT 1
)

SELECT 
    f.film_id,
    f.title,
    f.description,
    f.release_year,
    f.rating
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    prolific_actor pa ON fa.actor_id = pa.actor_id
ORDER BY 
    f.title;
-- Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
-- First find the most profitable customer, then get their rented films
WITH profitable_customer AS (
    SELECT 
        p.customer_id,
        SUM(p.amount) AS total_payments
    FROM 
        payment p
    GROUP BY 
        p.customer_id
    ORDER BY 
        total_payments DESC
    LIMIT 1
),

customer_rentals AS (
    SELECT 
        r.inventory_id
    FROM 
        rental r
    JOIN 
        profitable_customer pc ON r.customer_id = pc.customer_id
)

SELECT 
    f.film_id,
    f.title,
    f.description,
    f.rating,
    f.rental_rate
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    customer_rentals cr ON i.inventory_id = cr.inventory_id
ORDER BY 
    f.title;
-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.
WITH client_spending AS (
    SELECT 
        customer_id AS client_id,
        SUM(amount) AS total_amount_spent
    FROM 
        payment
    GROUP BY 
        customer_id
)

SELECT 
    cs.client_id,
    c.first_name,
    c.last_name,
    cs.total_amount_spent
FROM 
    client_spending cs
JOIN 
    customer c ON cs.client_id = c.customer_id
WHERE 
    cs.total_amount_spent > (
        SELECT AVG(total_amount_spent)
        FROM client_spending
    )
ORDER BY 
    cs.total_amount_spent DESC;