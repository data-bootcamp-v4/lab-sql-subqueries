use sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select f.title, count(i.inventory_id) as inventory_count
from sakila.film f
join sakila.inventory i on f.film_id = i.film_id
where f.title = "Hunchback Impossible"
group by f.title;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

select avg(length) from sakila.film;

select f.title, f.length
from sakila.film f
where f.length > (select avg(length) from sakila.film)
order by f.length desc;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
select a.first_name, a.last_name
from sakila.actor a 
join sakila.film_actor fa on a.actor_id = fa.actor_id
where fa.film_id = (select f.film_id from sakila.film f 
where f.title = "Alone Trip"); 

-- bónus 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

select f.title
from sakila.film f 
join film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
where c.name = 'Family';

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

select c.first_name, c.last_name, c.email
from sakila.customer c 
join sakila.address a on c.address_id = a.address_id
join sakila.city ci on a.city_id = ci.city_id
join sakila.country co on ci.country_id = co.country_id
where co.country = 'Canada';

-- as subquerie:

select c.first_name, c.last_name, c.email
from sakila.customer c 
where address_id in (
select address_id
from sakila.address
where city_id in (
select city_id from sakila.city
where country_id = (
select country_id from sakila.country
where country = 'Canada')));

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

-- identify actor_id
select actor_id 
from sakila.film_actor
group by actor_id
order by count(film_id) desc
limit 1;

-- films by actor
select f.title
from sakila.film f
join sakila.film_actor fa on f.film_id = fa.film_id
where fa.actor_id = 107;

-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

select p.customer_id
from sakila.payment p 
group by p.customer_id
order by sum(p.amount) desc
limit 1;

select f.title
from sakila.rental r
join sakila.inventory i on r.inventory_id = i.inventory_id
join sakila.film f on i.film_id = f.film_id
where r.customer_id = 526;

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.

select p.customer_id as client_id, sum(p.amount) as total_amount_spent
from sakila.payment p
group by p.customer_id
having sum(p.amount) > (select avg(total_spent)
from (select customer_id, sum(amount) as total_spent
from sakila.payment
group by customer_id) as subquery);


