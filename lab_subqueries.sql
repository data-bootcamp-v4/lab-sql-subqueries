/*
Write SQL queries to perform the following tasks using the Sakila database:

Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
List all films whose length is longer than the average length of all the films in the Sakila database.
Use a subquery to display all actors who appear in the film "Alone Trip".



*/

use sakila;


#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(inventory_id) 
from inventory 
where film_id in  (select film_id from film 
						where title like "%Hunchback Impossible%");

#List all films whose length is longer than the average length of all the films in the Sakila database.

select title, length from film 
where length > (select avg(length) from film);

#Use a subquery to display all actors who appear in the film "Alone Trip"


select concat(first_name,' ',last_name) as name from actor
where actor_id in (select actor_id 
					from film_actor
                    where film_id in (select film_id from film 
										where title like '%Alone Trip%' ) );