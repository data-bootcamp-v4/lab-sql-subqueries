-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LAB | SQL Subqueries --

-- Setting the working database
USE sakila;
show tables;

-- Challenge -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write SQL queries to perform the following tasks using the Sakila database:

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select * from inventory;
select * from film;

select count(*)
from inventory
where film_id in (select film_id from film where title='Hunchback Impossible');

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

select film_id, title, length
from film
where length > (select avg(length) from film)
order by length desc;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

select * from actor;
select * from film_actor;
select * from film;

select *
from actor
where actor_id in (
select actor_id from film_actor where film_id in (
select film_id from film where title='Alone Trip'));

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Bonus:

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

select * from film;
select * from category;

select film_id, title
from film
where film_id in (
select film_id from film_category where category_id in (
select category_id from category where name = 'Family'));

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

select * from country;
select * from city;
select * from address;
select * from customer;

SELECT CONCAT(first_name,' ',last_name) AS nombre, email
 FROM customer 
  WHERE address_id IN (
	SELECT a.address_id FROM address a 
		INNER JOIN city c ON (a.city_id=c.city_id)
        INNER JOIN country p ON (c.country_id=p.country_id AND p.country='Canada'));

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films.
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

SELECT title
FROM film AS f
WHERE film_id IN(
SELECT film_id
FROM film_actor AS fa
WHERE fa.actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1));

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer,
-- i.e., the customer who has made the largest sum of payments.

SELECT film_id
FROM inventory AS f
WHERE f.inventory_id IN (
SELECT r.inventory_id
FROM rental AS r
WHERE r.customer_id = (
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1));

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
SELECT AVG(total_spent)
FROM (
SELECT SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id) AS customer_totals);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------