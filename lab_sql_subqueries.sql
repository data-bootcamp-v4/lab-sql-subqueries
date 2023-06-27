Challenge

use sakila

Write SQL queries to perform the following tasks using the Sakila database:

Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select f.title, 
       (select COUNT(*) from inventory as inv
		join film as f on inv.film_id = f.film_id
		where f.title = 'Hunchback Impossible') as copy_count from film as f
where f.title = 'Hunchback Impossible';


List all films whose length is longer than the average length of all the films in the Sakila database.

select film_id, title, length from film
where length > (select avg(length) from film)
order by length asc;

Use a subquery to display all actors who appear in the film "Alone Trip".

select ac.actor_id, ac.first_name, ac.last_name from actor as ac
where ac.actor_id in (
  select fac.actor_id from film_actor as fac
  join film as f ON fac.film_id = f.film_id
  where f.title = 'Alone Trip');

Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

select f.film_id, f.title from film as f
join film_category as fca on f.film_id = fca.film_id
join category as ca on fca.category_id = ca.category_id
where ca.name = 'Family';

Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

-- Key Identification
-- customer
show create table customer; -- open value in viewer to see rules for create table
-- address
show create table address; -- open value in viewer to see rules for create table
-- city
show create table city; -- open value in viewer to see rules for create table
-- country
show create table country; -- open value in viewer to see rules for create table


select customer.first_name, customer.last_name, customer.email from customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join (select country_id from country
where country.country = 'Canada') as subquery on city.country_id = subquery.country_id;

Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in. 

select film.film_id, film.title
from film
join film_actor on film.film_id = film_actor.film_id
where film_actor.actor_id = (
  select actor_id from (select actor_id, COUNT(*) as film_count
    from film_actor
    group by actor_id
    order by film_count desc
	limit 1 ) as most_prolific_actor);

Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

select film.film_id, film.title from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join (select customer_id from payment
  group by customer_id
  order by SUM(amount) desc
  limit 1) as most_profitable_customer on rental.customer_id = most_profitable_customer.customer_id;

Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

select client_id, total_amount_spent from
	(select customer_id as client_id, SUM(amount) as total_amount_spent from payment
  group by customer_id) as client_amount_spent
where total_amount_spent > (select avg(total_amount_spent) from
    (select customer_id, sum(amount) as total_amount_spent from payment
    group by customer_id) as avg_amount_spent)
order by total_amount_spent desc;