-- Active: 1721290976752@@127.0.0.1@3306@sakila
USE sakila;


-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system --
SELECT f.title AS film_name , COUNT(i.film_id) AS number_of_copies
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";


-- List all films whose length is longer than the average length of all the films in the Sakila database.--

SELECT f.title AS film_name, f.length 
FROM film AS f
WHERE f.length > (SELECT AVG(f2.length)
        FROM film AS f2)
ORDER BY f.length DESC;


-- Use a subquery to display all actors who appear in the film "Alone Trip".--

SELECT a.actor_id, CONCAT(a.first_name," ",a.last_name) AS actor_full_name
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.film_id = (
    SELECT f.film_id
    FROM film AS f
    WHERE f.title = 'Alone Trip'
);
Bonus:

--Sales have been lagging among young families, and you want to target family movies for a promotion. 
--Identify all movies categorized as family films.

SELECT f.title AS film_name, c.name AS film_category
FROM film_category AS fc
JOIN film as f
ON f.film_id = fc.film_id
JOIN category AS c
WHERE c.category_id = 
            (SELECT c.category_id
            FROM category AS c
            WHERE c.name = "Family");
            
--Retrieve the name and email of customers from Canada using both subqueries and joins. 
--To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, c.email
FROM customer AS c
WHERE c.address_id IN (
    SELECT a.address_id
    FROM address AS a
    JOIN city AS ci ON a.city_id = ci.city_id
    JOIN country AS co ON ci.country_id = co.country_id
    WHERE co.country = 'Canada'
);


--Determine which films were starred by the most prolific actor in the Sakila database. 
--A prolific actor is defined as the actor who has acted in the most number of films. 
--First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT f.title
FROM film AS f
JOIN film_actor AS fa 
ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT a.actor_id
    FROM actor AS a
    JOIN film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
    ORDER BY COUNT(fa.film_id) DESC
    LIMIT 1);

--Find the films rented by the most profitable customer in the Sakila database. 
--You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT f.title
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
WHERE p.customer_id = (
    SELECT c.customer_id
    FROM customer AS c
    JOIN payment AS p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
    ORDER BY SUM(p.amount) DESC
    LIMIT 1);

--Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
--You can use subqueries to accomplish this.

-- Retrieve client_id and total_amount_spent of clients who spent more than the average amount
SELECT c.customer_id AS client_id, SUM(p.amount) AS total_amount_spent
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING SUM(p.amount) > (
    -- Subquery to calculate the average spending
    SELECT AVG(total_spent)
    FROM (
        -- Subquery to calculate total spending for each client
        SELECT c.customer_id, SUM(p.amount) AS total_spent
        FROM customer AS c
        JOIN payment AS p ON c.customer_id = p.customer_id
        GROUP BY c.customer_id
    ) AS subquery
);
