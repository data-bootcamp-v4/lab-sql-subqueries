USE sakila;

-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*)
FROM inventory
WHERE inventory.film_id = (SELECT film.film_id
                        FROM film
                        WHERE film.title = "Hunchback Impossible")
GROUP BY inventory.film_id;

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT *
FROM film
WHERE film.length > (SELECT AVG(film.length)
                    FROM film);

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor.first_name, actor.last_name
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_id = (SELECT film.film_id
                FROM film
                WHERE film.title = "Alone Trip");
-- 4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT film.title
FROM film
LEFT JOIN film_category on film.film_id = film_category.film_id
WHERE film_category.category_id = (SELECT category_id
                                    FROM category
                                    WHERE name = "Family");

-- 5 Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT customer.first_name, customer.last_name, customer.email, city.city
FROM customer
LEFT JOIN address ON customer.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id
WHERE city.country_id IN (SELECT country_id
                            FROM country
                            WHERE country = 'Canada');


-- 6 Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT film.title 
FROM film
LEFT JOIN film_actor ON film_actor.film_id = film.film_id
WHERE film_actor.actor_id = (SELECT actor.actor_id
                            FROM actor
                            LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
                            GROUP BY actor.actor_id
                            ORDER BY COUNT(*) DESC
                            LIMIT 1);

-- 7 Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
SELECT film.title
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN store ON inventory.store_id = store.store_id
LEFT JOIN customer ON store.store_id = customer.store_id
WHERE customer.customer_id = (SELECT customer.customer_id
                            FROM customer
                            LEFT JOIN payment ON customer.customer_id = payment.customer_id
                            GROUP BY customer.customer_id
                            ORDER BY SUM(payment.amount) DESC
                            LIMIT 1);

-- 8 Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
SELECT customer.customer_id
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
HAVING SUM(payment.amount) > (SELECT AVG(subquery.total_client_spend) AS avg_total_amount_spent
                            FROM (SELECT SUM(payment.amount) AS total_client_spend
                                    FROM customer
                                    LEFT JOIN payment ON customer.customer_id = payment.customer_id
                                    GROUP BY customer.customer_id
                                    ORDER BY SUM(payment.amount) DESC) AS subquery);
