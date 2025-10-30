use sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select f.title, count(*) from film f
join inventory i 
on f.film_id = i.film_id
where f.title like '%Hunchback Impossible%'
group by f.title;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

select f.film_id, f.title, f.length from film f 
where length > (select avg(length) as avg_length from film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

select f.title, a.first_name, a.last_name from film f
join film_actor fa 
on fa.film_id = f.film_id
join actor a 
on a.actor_id = fa.actor_id
where f.title = 'Alone Trip';


select a.first_name, a.last_name from actor a 
join film_actor fa
on fa.actor_id = a.actor_id
where fa.film_id = (
select film_id from film
where title = 'Alone Trip');

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. 

select f.title, c.name from film f 
join film_category fc 
on fc.film_id = f.film_id
join category c 
on c.category_id = fc.category_id
where c.name = 'Family' ;

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

-- country, city, address, customer

select cs.first_name, cs.last_name, cs.email from customer cs
join address ad 
on ad.address_id = cs.address_id 
join city ct 
on ct.city_id = ad.city_id
where ct.country_id =
(select c.country_id from country c 
where country = 'Canada');

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1; 


select f.title from film f 
join film_actor fa on fa.film_id = f.film_id
where fa.actor_id = (
select a.actor_id  from actor a 
join film_actor fa 
on fa.actor_id = a.actor_id
GROUP BY  a.actor_id
ORDER BY count(fa.film_id) DESC
LIMIT 1);


-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

select cs.customer_id, cs.first_name, cs.last_name, sum(p.amount) as profit from customer cs
join payment p 
on p.customer_id = cs.customer_id
group by cs.customer_id, cs.first_name, cs.last_name
order by profit desc
limit 1; 

-- film, inventory, store, customer

select f.title from film f 
join inventory i 
on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id 
join customer cs
on cs.customer_id = r.customer_id
where cs.customer_id = (
select cs.customer_id  from customer cs
join payment p 
on p.customer_id = cs.customer_id
group by cs.customer_id, cs.first_name, cs.last_name
order by sum(p.amount) desc
limit 1 )
group by f.title ;


-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.

select cs.customer_id, sum(p.amount) as total_amount_spent from customer cs
join payment p on p.customer_id = cs.customer_id
group by cs.customer_id
having total_amount_spent > (
SELECT AVG(total_spent) FROM 
( SELECT SUM(p.amount) AS total_spent
FROM payment p
GROUP BY p.customer_id ) AS subquery);


 
SELECT SUM(p.amount) AS total_spent
FROM payment p
GROUP BY p.customer_id;

SELECT AVG(total_spent) FROM 
( SELECT SUM(p.amount) AS total_spent
FROM payment p
GROUP BY p.customer_id ) AS subquery; 
