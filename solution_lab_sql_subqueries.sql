## Challenge
#Write SQL queries to perform the following tasks using the Sakila database:

#1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select 
		count(inventory_id) as num_copies
from inventory
where film_id= (select film_id
				from film
				where title = "Hunchback Impossible");

#2. List all films whose length is longer than the average length of all the films in the Sakila database.
select film_id, title, length
from film 
where length > (select avg(length) as avg_length
				from film
				 );
		
#3. Use a subquery to display all actors who appear in the film "Alone Trip".
select 	concat(first_name, " ",last_name) as completed_name
from actor
where actor_id in
(select actor_id
from film_actor
where film_id =(select film_id
from film 
where title = "Alone Trip"));

#**Bonus**:

#4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select title
from film
where film_id in
(select film_id
from film_category
where category_id = (select category_id
from category
where name = 'Family'));

#5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
#To use joins, you will need to identify the relevant tables and their primary and foreign keys.

## subqueries
select concat(first_name," ",last_name) as completed_name , email
from customer 
where address_id in	(select address_id
					from address
					where city_id in(select city_id
								from city
								where country_id = (select country_id
													from country
													where country = 'Canada')));
                                                    
## joins
select concat(c.first_name," ",c.last_name) as completed_name , c.email
from customer c 
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Canada';

#6. Determine which films were starred by the most prolific actor in the Sakila database. 
# A prolific actor is defined as the actor who has acted in the most number of films.
# First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
select title
from film f
join film_actor fi on f.film_id = fi.film_id 
where actor_id = (select actor_id
				from film_actor
				group by actor_id
				order by count(film_id)  desc
				limit 1);

#7. Find the films rented by the most profitable customer in the Sakila database. 
#You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

select concat(first_name, " ", last_name) as completed_name
from customer
where customer_id = (select customer_id
					from payment
					group by customer_id
					order by sum(amount) desc
					limit 1);

#8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
 #You can use subqueries to accomplish this.
 
 select customer_id, total_amount_spent
 from
	(select customer_id, sum(amount) as total_amount_spent
	from payment
	group by customer_id) as customer_totals
where total_amount_spent > 
						(select avg(total_amount_spent) from (
														select sum(amount) total_amount_spent
														from payment
														group by customer_id) as subquery_Totals);
