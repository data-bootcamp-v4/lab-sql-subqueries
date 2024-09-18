USE sakila;

-- This query counts the number of inventory records associated with the film titled "Hunchback Impossible".
SELECT 
    COUNT(i.inventory_id) AS number_of_copies
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Hunchback Impossible';

-- This query uses a subquery to calculate the average film length and retrieves films longer than that average.
SELECT 
    title, 
    length
FROM 
    film
WHERE 
    length > (SELECT AVG(length) FROM film);
    
    
-- This query uses a subquery to find all actors (actor_id) who have appeared in the film "Alone Trip".
SELECT 
    a.first_name, 
    a.last_name
FROM 
    actor a
WHERE 
    a.actor_id IN (
        SELECT fa.actor_id
        FROM film_actor fa
        JOIN film f ON fa.film_id = f.film_id
        WHERE f.title = 'Alone Trip'
    );

-- This query identifies all movies that fall under the "Family" category by joining the film, film_category, and category tables.
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

-- Retrieve the name and email of customers from Canada using both subqueries and joins
-- Subquery:
SELECT 
    first_name, 
    last_name, 
    email
FROM 
    customer
WHERE 
    address_id IN (
        SELECT a.address_id
        FROM address a
        JOIN city c ON a.city_id = c.city_id
        JOIN country co ON c.country_id = co.country_id
        WHERE co.country = 'Canada'
    );
    
-- Join:
SELECT 
    c.first_name, 
    c.last_name, 
    c.email
FROM 
    customer c
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id
WHERE 
    co.country = 'Canada';


-- Determine which films were starred by the most prolific actor
-- Step 1: Find the most prolific actor (actor with the most film appearances):
SELECT 
    fa.actor_id, 
    COUNT(fa.film_id) AS film_count
FROM 
    film_actor fa
GROUP BY 
    fa.actor_id
ORDER BY 
    film_count DESC
LIMIT 1;

-- Step 2: Use the actor_id from Step 1 to find the films they starred in:
SELECT 
    f.title
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
WHERE 
    fa.actor_id = (SELECT fa.actor_id
                   FROM film_actor fa
                   GROUP BY fa.actor_id
                   ORDER BY COUNT(fa.film_id) DESC
                   LIMIT 1);

-- Find the films rented by the most profitable customer
-- Step 1: Find the most profitable customer (customer who paid the most):
SELECT 
    p.customer_id, 
    SUM(p.amount) AS total_spent
FROM 
    payment p
GROUP BY 
    p.customer_id
ORDER BY 
    total_spent DESC
LIMIT 1;

-- Step 2: List the films rented by that customer:
SELECT 
    f.title
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    r.customer_id = (SELECT p.customer_id
                     FROM payment p
                     GROUP BY p.customer_id
                     ORDER BY SUM(p.amount) DESC
                     LIMIT 1);

-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client
SELECT 
    p.customer_id, 
    SUM(p.amount) AS total_amount_spent
FROM 
    payment p
GROUP BY 
    p.customer_id
HAVING 
    total_amount_spent > (SELECT AVG(total_spent)
                          FROM (SELECT SUM(amount) AS total_spent 
                                FROM payment 
                                GROUP BY customer_id) AS avg_spent);





