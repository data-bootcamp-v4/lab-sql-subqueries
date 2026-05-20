-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".
-- Bonus:

-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
	-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, 
	-- i.e., the customer who has made the largest sum of payments.
-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

use sakila;
select count(inventory_id) from inventory where film_id = (select film_id from film where title="Hunchback Impossible");
select title from film where length>(select avg(length) from film);
select first_name,last_name as actor from actor where actor_id in (select af.actor_id from film_actor as af inner join film as f on af.film_id=f.film_id where title="Alone Trip");  

select title from film where film_id in (select fc.film_id from film_category as fc inner join category as c on c.category_id=fc.category_id where name='Family') ;

select concat(first_name,' ' ,last_name), email from customer where address_id in 
(select distinct(a.address_id) from address as a inner join city as c on a.city_id=c.city_id inner join country as co on c.country_id=co.country_id where co.country='Canada');

select f.title from film as f inner join film_actor as fa on f.film_id=fa.film_id where fa.actor_id = (select actor_id from film_actor group by actor_id order by count(film_id) desc limit 1);

select f.title from film as f inner join inventory as i on f.film_id=i.film_id inner join rental as r on i.inventory_id=r.inventory_id 
where customer_id =(select customer_id from payment group by customer_id order by sum(amount) desc limit 1);

select sum(amount) as total_amount from payment group by customer_id;
select customer_id as client_id, sum(amount) as total_amount_spent from payment group by customer_id having sum(amount) > 
(select avg(total_amount) from (select sum(amount) as total_amount from payment group by customer_id) as tas);