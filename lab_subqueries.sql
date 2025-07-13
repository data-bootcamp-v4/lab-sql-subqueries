-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
USE sakila;

SELECT
count(i.inventory_id) as inventory,
f.title as film
FROM sakila.inventory as i
JOIN sakila.film as f
on i.film_id = f.film_id
WHERE title = 'Hunchback Impossible' 
group by film;


-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title FROM (
  SELECT title, AVG(length) AS 'Average' FROM sakila.film
  GROUP BY title
  HAVING Average > (SELECT ROUND(AVG(length),2) AS 'Average1' FROM sakila.film)
) AS s;

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor_id FROM sakila.film_actor 
WHERE film_id IN (
SELECT film_id FROM sakila.film
WHERE title = "Alone Trip"
);

-- BONUS
-- Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.

Select category_id from sakila.category
where name = "Family";

SELECT title from sakila.film
WHERE film_id in (select film_id from sakila.film_category)
having (Select category_id from sakila.category
where name = "Family");



-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.