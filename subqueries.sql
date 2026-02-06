USE sakila;
#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT count(*)
FROM inventory i
LEFT JOIN film f
ON i.film_id = f.film_id
WHERE title = "Hunchback Impossible"
GROUP BY title;
#2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT *
FROM film
WHERE length > (SELECT AVG(length) FROM film);

#3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT faf.actor_id, a.first_name, a.last_name
FROM (SELECT fa.actor_id, f.title FROM film_actor fa JOIN film f ON fa.film_id = f.film_id) AS faf
JOIN actor a
ON faf.actor_id = a.actor_id
WHERE faf.title = "Alone Trip";

#4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT cfc.film_id, f.title
FROM (SELECT fc.film_id, name FROM category c JOIN film_category fc ON c.category_id = fc.category_id) as cfc
JOIN film f
ON cfc.film_id = f.film_id
WHERE cfc.name = "Family";

#5 Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT mix.first_name, mix.last_name, mix.email
FROM (SELECT c.first_name, c.last_name, c.email,co.country
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id) as mix
WHERE mix.country = "Canada";

#6 Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT fa.film_id 
FROM film_actor fa
WHERE fa.actor_id = (SELECT top1.actor_id
					FROM (SELECT actor_id, COUNT(*) as number_films
							FROM film f
							JOIN film_actor fa
							ON f.film_id = fa.film_id
							GROUP BY actor_id
							ORDER BY number_films DESC
							LIMIT 1) as top1)
;

#7 Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT i.film_id, f.title
FROM (SELECT c.customer_id, SUM(amount)
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY SUM(amount) DESC
LIMIT 1) AS mix
JOIN rental r
ON mix.customer_id = r.customer_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON  i.film_id = f.film_id
;

#8 Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT customer_id as "client_id", SUM(amount) as "total_amount_spent"
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(total_amount)
FROM (SELECT SUM(amount) as total_amount
FROM payment p
GROUP BY customer_id) AS media);


SELECT AVG(total_amount)
FROM (SELECT SUM(amount) as total_amount
FROM payment p
GROUP BY customer_id) AS media;
