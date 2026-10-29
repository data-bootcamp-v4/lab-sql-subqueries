USE sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(*) as No_of_copies from inventory where film_id in 
(select film_id from film where title = "Hunchback Impossible");

-- List all films whose length is longer than the average length of all the films in the Sakila database.
select film_id, length from film 
where length > (select avg(length) from film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

select concat( first_name,' ',last_name) as Actor_name from actor
where actor_id in 
(select actor_id from film_actor
where film_id in (select film_id from film where title = "Alone Trip"));

-- Bonus:
-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

select title as Family_movies from film where film_id in (
select film_id from film_category where category_id in 
(select category_id from category where name = "Family"));

-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

select concat(first_name," ",last_name) as Customer_name, email from customer
where address_id in 
(
select a.address_id
from address as a join city as c
on a.city_id = c.city_id
join
country as co
on c.country_id = co.country_id
where co.country = "Canada");

-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

select distinct title from film where film_id in 
(
select film_id from film_actor
where actor_id in
(
select actor_id from actor 
where actor_id = (select fa.actor_id as Actor_id 
from film as f 
join film_actor as fa
on f.film_id = fa.film_id
group by Actor_id 
order by count(f.film_id)  desc 
limit 1)));

-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.


SELECT DISTINCT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;













