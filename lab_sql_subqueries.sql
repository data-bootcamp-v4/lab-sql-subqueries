-- Write SQL queries to perform the following tasks using the Sakila database:

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(inventory.film_id) from inventory
	inner join film
		on inventory.film_id = film.film_id
	where film.title like "Hunchback Impossible"
    ;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
select film.title, film.length from film 
where film.length > (select avg(length) from film)
order by film.length desc;

-- Use a subquery to display all actors who appear in the film "Alone Trip".
select actor.first_name, actor.last_name from actor
inner join film_actor
	on actor.actor_id = film_actor.actor_id
inner join film
	on film_actor.film_id = film.film_id
where (select film.title = 'Alone Trip' )
;

-- Bonus:

-- Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
select film.title, category.name from film
inner join film_category 
	on film.film_id = film_category.film_id
inner join category
	on film_category.category_id = category.category_id
where (select category.name like "Family")
;
-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, 
-- you will need to identify the relevant tables and their primary and foreign keys.
select customer.first_name, customer.last_name, email, country.country from customer
inner join address
	on customer.address_id = address.address_id
inner join city
    on address.city_id = city.city_id
inner join country
    on city.country_id = country.country_id
where (select country.country = "Canada")
;
-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is 
-- defined as the actor who has acted in the most number of films. First, you will need to find the most prolific 
-- actor and then use that actor_id to find the different films that he or she starred in.
select film.title, film_actor.actor_id from film
inner join film_actor
	on film.film_id = film_actor.film_id
where actor_id = (select max(actor_id) from film_actor)

;

-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and 
-- payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
-- select film.title from film;

-- select film.title from film
-- 	inner join inventory
-- 		on film.film_id = inventory.film_id
-- 	inner join rental
-- 		on inventory.inventory_id = rental.inventory_id
-- 	inner join payment
-- 		on rental.rental_id = payment.rental_id
-- 	where payment.customer_id = (select customer_id, sum(amount) from payment
--     group by customer_id
--     order by sum(amount) desc limit 1)
-- ;

-- select inventory_id from rental 
-- 	inner join payment
-- 		on rental.rental_id = payment.rental_id
-- where rental.customer_id = (select customer_id from payment
--     where sum(amount) = (select max(sum(amount)))
-- ;

-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the 
-- total_amount spent by each client. You can use subqueries to accomplish this.

