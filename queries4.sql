USE sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT * FROM inventory;
SELECT * FROM film;

SELECT 
    film.title,
    COUNT(inventory.inventory_id) AS number_of_copies
FROM film
JOIN inventory ON film.film_id = inventory.film_id 
WHERE film.title = 'Hunchback Impossible';

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT * FROM film;

SELECT 
    title,
    length
FROM film
WHERE length > (SELECT AVG(length)FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT 
   first_name,
   last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE
    film_actor.film_id = (
        SELECT 
            film.film_id
        FROM
            film
        WHERE
            film.title = 'Alone Trip'
    );

-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT * FROM category;

SELECT * FROM film_category;

SELECT 
   title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
WHERE
    film_category.category_id = (
        SELECT 
            category.category_id
        FROM
            category
        WHERE
            category.name = 'Family'
    );

-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

SELECT
   first_name,
   last_name,
   email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE
    city.country_id = (
        SELECT 
            country.country_id
        FROM
            country
        WHERE
            country.country = 'Canada'
    );
    
-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT * FROM film_actor;
SELECT * FROM actor;
SELECT
   film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE
    film_actor.actor_id = (SELECT actor.actor_id
                           FROM actor
                           JOIN film_actor ON actor.actor_id = film_actor.actor_id
                           GROUP BY actor.actor_id
                           ORDER BY COUNT(film_actor.film_id) DESC
                           LIMIT 1);
-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT * FROM payment;
SELECT * FROM customer;
SELECT * FROM film;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT
   film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id=rental.inventory_id
JOIN customer ON rental.customer_id=customer.customer_id
WHERE customer.customer_id = 
						  (SELECT customer.customer_id
                           FROM customer
                           JOIN payment ON customer.customer_id = payment.customer_id
                           GROUP BY customer.customer_id
                           ORDER BY SUM(payment.amount) DESC
                           LIMIT 1);
   
-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
SELECT 
    customer_id,
    total_amount_spent
FROM (
    SELECT 
        customer.customer_id,
        SUM(payment.amount) AS total_amount_spent
    FROM 
        customer
    JOIN 
        payment ON customer.customer_id = payment.customer_id
    GROUP BY 
        customer.customer_id
) AS customer_totals
WHERE 
    total_amount_spent > (
        SELECT 
            AVG(total_per_client.total_amount)
        FROM (
            SELECT 
                customer.customer_id,
                SUM(payment.amount) AS total_amount
            FROM 
                customer
            JOIN 
                payment ON customer.customer_id = payment.customer_id
            GROUP BY 
                customer.customer_id
        ) AS total_per_client
    );