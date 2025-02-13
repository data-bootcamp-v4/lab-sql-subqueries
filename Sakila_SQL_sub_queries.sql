USE sakila;

-- Determine the number of copies of the film "Hunchback Impossible" in the inventory system
SELECT 
    COUNT(*) AS number_of_copies 
FROM 
    inventory 
WHERE 
    film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');


-- List all films whose length is longer than the average length of all the films in the Sakila database

SELECT 
    title, 
    length 
FROM 
    film 
WHERE 
    length > (SELECT AVG(length) FROM film);


-- Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT 
    first_name, 
    last_name 
FROM 
    actor 
WHERE 
    actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));


-- Identify all movies categorized as family films

SELECT 
    f.title 
FROM 
    film f 
WHERE 
    f.film_id IN (SELECT fc.film_id FROM film_category fc JOIN category c ON fc.category_id = c.category_id WHERE c.name = 'Family');


-- Retrieve the name and email of customers from Canada using both subqueries and joins
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


-- Using a subquery:
SELECT 
    first_name, 
    last_name, 
    email 
FROM 
    customer 
WHERE 
    address_id IN (SELECT address_id FROM address WHERE city_id IN (SELECT city_id FROM city WHERE country_id IN (SELECT country_id FROM country WHERE country = 'Canada')));



-- Determine which films were starred by the most prolific actor in the Sakila database
-- Find the most prolific actor
SELECT 
    actor_id 
FROM 
    film_actor 
GROUP BY 
    actor_id 
ORDER BY 
    COUNT(film_id) DESC 
LIMIT 1;

-- Retrieve the films for that actor
SELECT 
    f.title 
FROM 
    film f 
WHERE 
    f.film_id IN (SELECT film_id FROM film_actor WHERE actor_id = (SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(film_id) DESC LIMIT 1));


-- Find the films rented by the most profitable customer in the Sakila database

-- Find the most profitable customer
SELECT 
    customer_id 
FROM 
    payment 
GROUP BY 
    customer_id 
ORDER BY 
    SUM(amount) DESC 
LIMIT 1;

-- Retrieve the films rented by this customer
SELECT 
    f.title 
FROM 
    film f 
WHERE 
    f.film_id IN (SELECT i.film_id FROM rental r JOIN inventory i ON r.inventory_id = i.inventory_id WHERE r.customer_id = (SELECT customer_id FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 1));


-- Retrieve the client_id and total_amount_spent of clients who spent more than the average total_amount spent by each client
SELECT 
    customer_id, 
    SUM(amount) AS total_amount_spent
FROM 
    payment
GROUP BY 
    customer_id
HAVING 
    total_amount_spent > (SELECT AVG(total_amount) FROM (SELECT SUM(amount) AS total_amount FROM payment GROUP BY customer_id) AS subquery);



