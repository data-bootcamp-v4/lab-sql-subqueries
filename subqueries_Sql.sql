# Write SQL queries to perform the following tasks using the Sakila database:

use sakila;
# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select * from inventory;
select * from film;

# without subquery 
select count(inventory_id) as num_of_copies 
from film f
inner join inventory i 
on f.film_id = i.film_id 
where f.title='Hunchback Impossible';

# with subquery 
select count(inventory_id) as num_of_copies 
from film f
inner join inventory i 
on f.film_id = i.film_id 
where f.film_id in (select film_id from film where title='Hunchback Impossible');

# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length as film_names from film where length > (select avg(length) from film);

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
select * from actor;
select * from film_actor;

select concat(a.first_name, ' ',a.last_name) as actor_name, f.title as film_name
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film f
on fa.film_id = f.film_id
where f.film_id = (select film_id from film where title='Alone Trip');

# 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
# Identify all movies categorized as family films.
select * from film;
select * from film_category;
select * from Category;

select f.title as Family_Movies from film f 
inner join film_category fl
on f.film_id = fl.film_id
inner join Category c
on fl.category_id = c.category_id
where c.name='Family';

# 5.Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, 
# you will need to identify the relevant tables and their primary and foreign keys.
select * from customer;
select * from address;
select * from country;

# using subquery
select concat(c.first_name, ' ', c.last_name) as Customer from customer c
where address_id in (select address_id from address where city_id in 
					(select city_id from city where country_id = 
					(select country_id from country where country = 'Canada')));
                    
# using join
select concat(c.first_name, ' ', c.last_name) as Customer from customer c
inner join address a
on c.address_id= a.address_id
inner join city ct
on a.city_id = ct.city_id
inner join country co
on ct.country_id = co.country_id
where co.country= 'Canada';