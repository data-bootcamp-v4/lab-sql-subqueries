-- Subqueries allow you to retrieve data from one or more tables and use that data in a separate query to retrieve more specific information.

-- Challenge using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

USE sakila;
SELECT 
    COUNT(*) AS total_copies
FROM
    inventory i
        JOIN
    film f ON i.film_id = f.film_id
WHERE
    f.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
    *
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

-- joins
SELECT 
    a.first_name, a.last_name
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film f ON fa.film_id = f.film_id
WHERE
    f.title = 'Alone Trip';
 
 -- subqueries
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            fa.actor_id
        FROM
            film_actor fa
        WHERE
            fa.film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
                    
-- Bonus:

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

-- joins
SELECT 
    f.title
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name = 'Family';

-- subqueries
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id = (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'));

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

-- joins
SELECT 
    c.first_name, c.last_name, c.email
FROM
    customer c
        JOIN
    address a ON c.address_id = a.address_id
        JOIN
    city ON a.city_id = city.city_id
        JOIN
    country ON city.country_id = country.country_id
WHERE
    country.country = 'Canada';

-- subqueries
SELECT 
    first_name, last_name, email
FROM
    customer
WHERE
    address_id IN (SELECT 
            a.address_id
        FROM
            address a
                JOIN
            city ON a.city_id = city.city_id
                JOIN
            country ON city.country_id = country.country_id
        WHERE
            country.country = 'Canada');

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT 
    f.title
FROM
    film f
        JOIN
    film_actor fa ON f.film_id = fa.film_id
WHERE
    fa.actor_id = (SELECT 
            fa.actor_id
        FROM
            film_actor fa
        GROUP BY fa.actor_id
        ORDER BY COUNT(fa.film_id) DESC
        LIMIT 1);

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT p.customer_id
    FROM payment p
    GROUP BY p.customer_id
    ORDER BY SUM(p.amount) DESC
    LIMIT 1
);

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT customer_id, total_spent
FROM (
    SELECT p.customer_id, SUM(p.amount) AS total_spent 
    FROM payment p
    GROUP BY p.customer_id
) AS customer_totals
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS avg_totals
);