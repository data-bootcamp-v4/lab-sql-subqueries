##  Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
# s1--> need film_id for the film "Hunchback Impossible" 
select film_id from sakila.film where title = 'Hunchback Impossible';
# s2
select count(inventory_id) as n_copy
from sakila.inventory
where film_id = (select film_id from sakila.film where title = 'Hunchback Impossible');




## List all films whose length is longer than the average length of all the films in the Sakila database.
# s1--> find the average length of all the films in the Sakila database
select avg(length) as avg_length from sakila.film;
# s2
select *
from sakila.film
where length > (select avg(length) as avg_length from sakila.film);




# display all actors who appear in the film "Alone Trip".
# s1--> find the film_id for the film Alone Trip
select film_id from sakila.film where title = 'Alone Trip';
# s2 --> find actor_id
with alongtrip_actors as(
select actor_id
from sakila.film_actor
where film_id = (select film_id from sakila.film where title = 'Alone Trip'))
# s3--> find actor names
select *
from sakila.actor as a
where exists (select 1 from alongtrip_actors where alongtrip_actors.actor_id = a.actor_id);




# Sales have been lagging among young families, and you want to target family movies for a promotion. 
# Identify all movies categorized as family films. 
with family_film_id as (
select film_id
from sakila.film_category
where category_id = (select category_id from sakila.category where name = 'Family'))

select *
from sakila.film as f
where exists (select 1 from family_film_id where family_film_id.film_id = f.film_id);




# Retrieve the name and email of customers from Canada 
# s1--> country id
select country_id from sakila.country where country = 'Canada';
# s2-->unique city ids
select city_id
from sakila.city
where country_id = (select country_id from sakila.country where country = 'Canada');
# s3-->unique address ids--- customers
with canada_address as (
select a.address_id
from (select city_id
	 from sakila.city
	 where country_id = (select country_id from sakila.country where country = 'Canada')) as c
inner join sakila.address as a
on c.city_id = a.city_id)

select concat(first_name,' ',last_name) as full_name,
       email
from sakila.customer as c
where exists (select 1 from canada_address where canada_address.address_id = c.address_id);




# Determine which films were starred by the most prolific actor in the Sakila database. 
# A prolific actor is defined as the actor who has acted in the most number of films. 
# s1--> find the most prolific actor_id 
# s2--> find films (id) starred by prolific actor  
with prolific_actor as (
						select actor_id,count(film_id) as film_count  
						from sakila.film_actor 
						group by actor_id
						order by film_count desc
						limit 1),

prolific_actor_film as(
							select film_id
							from sakila.film_actor
							where actor_id = (select actor_id from prolific_actor) )
# s3--> find titles of the films that are starred by prolific actor
select film_id,
	   title
from sakila.film
where exists (select 1 from prolific_actor_film where prolific_actor_film.film_id = film.film_id);




# Find the films rented by the most profitable customer in the Sakila database. 
# s1--> find the most profitable customer, i.e., the customer who has made the largest sum of payments.
select customer_id
from sakila.payment
group by customer_id
order by sum(amount) desc
limit 1;
# s2--> find the film rental_id and inventory_id of the most profitable customer
# s3--> find the film_id and film title 
with rental_inventory as(
select rental_id,inventory_id
from sakila.rental
where customer_id = (select customer_id
					from sakila.payment
					group by customer_id
					order by sum(amount) desc
					limit 1)),
rental_film as(
select distinct i.film_id
from rental_inventory as rt
left join sakila.inventory as i
on rt.inventory_id = i.inventory_id
)

select film_id,title
from film as f
where exists (select 1 from rental_film where rental_film.film_id = f.film_id);




# Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
# s1--> the average of the total_amount spent by each client
select avg(total_amount) as avg_total_amount
from (
		select customer_id,sum(amount) as total_amount
		from sakila.payment
		group by customer_id) as customer_total_amount;
# s2--> Retrieve the client_id and the total_amount_spent of those clients who spent more than avg_total_amount calculated in s1
select customer_id,sum(amount) as total_amount
from sakila.payment
group by customer_id
having sum(amount) > (select avg(total_amount) as avg_total_amount
						from (
							select customer_id,sum(amount) as total_amount
							from sakila.payment
							group by customer_id) as customer_total_amount)