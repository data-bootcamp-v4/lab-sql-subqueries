#Write SQL queries to perform the following tasks using the Sakila database:
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
#List all films whose length is longer than the average length of all the films in the Sakila database.
#Use a subquery to display all actors who appear in the film "Alone Trip"
#1
select count(*) as number_of_copies
from inventory
where film_id = (select film_id
				from film
                where title = 'hunchback impossible');
                
#2
select title, length
from film
where length > (select avg(length) from film)
order by length desc;

#3 Use a subquery to display all actors who appear in the film "Alone Trip


select first_name, last_name
from actor
where actor_id in (select actor_id
				   from film_actor
				   where film_id = (select film_id
									from film
                                    where title = 'Alone Trip'));
