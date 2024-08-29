USE sakila;

-- Determine the Number of Copies of the Film "Hunchback Impossible" in the Inventory
SELECT 
    COUNT(*) AS number_of_copies
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Hunchback Impossible';

-- List All Films Whose Length Is Longer Than the Average Length of All Films
SELECT 
    f.title, 
    f.length
FROM 
    film f
WHERE 
    f.length > (SELECT AVG(length) FROM film);

-- Use a Subquery to Display All Actors Who Appear in the Film "Alone Trip"
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

-- Identify All Movies Categorized as Family Films (Bonus)
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

-- Retrieve the Name and Email of Customers from Canada Using Both Subqueries and Joins (Bonus)
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

-- Determine Which Films Were Starred by the Most Prolific Actor in the Sakila Database (Bonus)
SELECT 
    f.title
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
WHERE 
    fa.actor_id = (
        SELECT fa.actor_id 
        FROM film_actor fa
        GROUP BY fa.actor_id
        ORDER BY COUNT(fa.film_id) DESC
        LIMIT 1
    );

-- Find the Films Rented by the Most Profitable Customer in the Sakila Database (Bonus)
SELECT 
    f.title
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
WHERE 
    p.customer_id = (
        SELECT p.customer_id 
        FROM payment p
        GROUP BY p.customer_id
        ORDER BY SUM(p.amount) DESC
        LIMIT 1
    );

-- Retrieve the Client ID and the Total Amount Spent by Clients Who Spent More Than the Average Amount (Bonus)
SELECT 
    p.customer_id, 
    SUM(p.amount) AS total_amount_spent
FROM 
    payment p
GROUP BY 
    p.customer_id
HAVING 
    SUM(p.amount) > (
        SELECT AVG(total_amount) 
        FROM (
            SELECT SUM(amount) AS total_amount 
            FROM payment 
            GROUP BY customer_id
        ) AS avg_total
    );