USE sakila;

#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) FROM
(SELECT i.film_id from inventory i 
join film f on 
i.film_id = f.film_id
where f.title = "Hunchback Impossible") as hb;

#List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title FROM film
WHERE length > (SELECT AVG(length) from film);

#Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.Last_name
from actor a 
JOIN film_actor f
ON f.actor_id = a.actor_id
JOIN film g ON
f.film_id = g.film_id
WHERE g.film_id =
(SELECT film_id FROM film
WHERE title = "Alone Trip");
#Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT f.film_id, g.title, c.name
FROM film g
JOIN film_category f ON g.film_id = f.film_id
WHERE f.category_id = (
    SELECT category_id
    FROM category
    WHERE name = 'Family'
);


#Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT c.first_name, c.last_name, c.email from customer  c
join address v on 
c.address_id = v.address_id
JOIN city d on 
d.city_id = v.city_id
JOIN country x on 
v.city_id = x.country_id
WHERE x.country_id = (SELECT country_id from country where country = "Canada");


#Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT first_name, last_name from actor
where actor_id = (SELECT actor_id from film_actor GROUP BY actor_id ORDER BY COUNT(film_id) LIMIT 1);


#Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
SELECT title from film f
join inventory i on
f.film_id = i.film_id
JOIN rental r on
r.inventory_id = i.inventory_id
where customer_id = (SELECT customer_id from payment GROUP BY customer_id ORDER BY COUNT(payment_id) LIMIT 1);

#Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
SELECT customer_id, total_amount_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE total_amount_spent > (
    SELECT AVG(total_amount_spent)
    FROM (
        SELECT SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS average_query
);
