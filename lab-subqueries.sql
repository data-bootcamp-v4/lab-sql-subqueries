SELECT 
    COUNT(*) AS num_copies
FROM 
    inventory
WHERE 
    film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');
SELECT 
    title, length
FROM 
    film
WHERE 
    length > (SELECT AVG(length) FROM film);
SELECT 
    a.actor_id, a.first_name, a.last_name
FROM 
    actor a
WHERE 
    a.actor_id IN (
        SELECT fa.actor_id
        FROM film_actor fa
        JOIN film f ON fa.film_id = f.film_id
        WHERE f.title = 'Alone Trip'
    );
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
SELECT 
    first_name, last_name, email
FROM 
    customer
WHERE 
    address_id IN (
        SELECT address_id
        FROM address
        WHERE city_id IN (
            SELECT city_id
            FROM city
            WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')
        )
    );
SELECT 
    c.first_name, c.last_name, c.email
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
-- Step 1: Find the most prolific actor
SELECT 
    fa.actor_id, COUNT(fa.film_id) AS film_count
FROM 
    film_actor fa
GROUP BY 
    fa.actor_id
ORDER BY 
    film_count DESC
LIMIT 1;

-- Step 2: Use the actor_id to find the films
SELECT 
    f.title
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
WHERE 
    fa.actor_id = (SELECT actor_id 
                   FROM film_actor 
                   GROUP BY actor_id 
                   ORDER BY COUNT(film_id) DESC 
                   LIMIT 1);
-- Step 1: Find the most profitable customer
SELECT 
    customer_id, SUM(amount) AS total_spent
FROM 
    payment
GROUP BY 
    customer_id
ORDER BY 
    total_spent DESC
LIMIT 1;

-- Step 2: Use the customer_id to find rented films
SELECT 
    DISTINCT f.title
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    r.customer_id = (SELECT customer_id 
                     FROM payment 
                     GROUP BY customer_id 
                     ORDER BY SUM(amount) DESC 
                     LIMIT 1);
-- Step 1: Find the most profitable customer
SELECT 
    customer_id, SUM(amount) AS total_spent
FROM 
    payment
GROUP BY 
    customer_id
ORDER BY 
    total_spent DESC
LIMIT 1;

-- Step 2: Use the customer_id to find rented films
SELECT 
    DISTINCT f.title
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    r.customer_id = (SELECT customer_id 
                     FROM payment 
                     GROUP BY customer_id 
                     ORDER BY SUM(amount) DESC 
                     LIMIT 1);
SELECT 
    customer_id, 
    total_amount_spent
FROM (
    SELECT 
        customer_id, 
        SUM(amount) AS total_amount_spent
    FROM 
        payment
    GROUP BY 
        customer_id
) subquery
WHERE 
    total_amount_spent > (SELECT AVG(total_spent) 
                          FROM (
                              SELECT 
                                  SUM(amount) AS total_spent
                              FROM 
                                  payment
                              GROUP BY 
                                  customer_id
                          ) avg_subquery);
