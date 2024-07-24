-- Active: 1721290976264@@127.0.0.1@3306@sakila
USE sakila

--Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT title,COUNT(title)
FROM inventory AS i
JOIN film AS f
ON i.film_id = f.film_id
GROUP BY title
HAVING title = "Hunchback Impossible"


--List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT AVG(`length`)
FROM film AS f

SELECT f.title
FROM film AS f
WHERE length > (SELECT AVG(`length`)
                FROM film AS f)



--Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT f.film_id
FROM film AS f
WHERE title = "Alone Trip"

SELECT a.first_name,a.last_name
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE film_id = (SELECT f.film_id
FROM film AS f
WHERE title = "Alone Trip")


--Sales have been lagging among young families, and you want to target family movies for a promotion.
--Identify all movies categorized as family films.


SELECT *
FROM film_category

SELECT c.category_id
FROM category AS c
WHERE c.name = "Family"

SELECT f.title,f.film_id
FROM film AS f

SELECT f.title
FROM film_category AS fc
JOIN film AS f
ON fc.film_id = f.film_id
WHERE fc.category_id = (SELECT c.category_id
FROM category AS c
WHERE c.name = "Family")


--Retrieve the name and email of customers from Canada using both subqueries and joins.
--To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT co.country_id
FROM country AS co
WHERE country = "Canada"

SELECT c.first_name, c.last_name,c.email
FROM customer AS c
JOIN address AS a
ON c.address_id = a.address_id
JOIN city AS ci
ON a.city_id = ci.city_id
WHERE country_id = (SELECT co.country_id
FROM country AS co
WHERE country = "Canada")


--Determine which films were starred by the most prolific actor in the Sakila database.
--A prolific actor is defined as the actor who has acted in the most number of films.
--First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1

SELECT film_id
FROM film_actor
WHERE actor_id = 107

SELECT film.title 
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE actor_id = (SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1)


--Find the films rented by the most profitable customer in the Sakila database.
--You can use the customer and payment tables to find the most profitable customer,
--i.e., the customer who has made the largest sum of payments.

SELECT p.customer_id
FROM payment AS p
GROUP BY p.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 1


SELECT f.title
FROM rental AS r
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
JOIN film AS f
ON i.film_id = f.film_id
WHERE customer_id = (SELECT p.customer_id
FROM payment AS p
GROUP BY p.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 1)


--Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
--You can use subqueries to accomplish this.

SELECT AVG(amount)
FROM payment AS p

SELECT customer_id
FROM payment AS p
GROUP BY customer_id
HAVING AVG(amount) > (SELECT AVG(amount)
FROM payment AS p)


SELECT customer_id,SUM(amount) FROM payment AS p
WHERE customer_id IN (SELECT customer_id
FROM payment AS p
GROUP BY customer_id
HAVING AVG(amount) > (SELECT AVG(amount)
FROM payment AS p))
GROUP BY customer_id








