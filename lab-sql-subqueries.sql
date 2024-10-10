use sakila;
show tables;

#1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(film_id)
from inventory where film_id = (select film_id
                             from film
							 where title='Hunchback Impossible');
		
#2. List all films whose length is longer than the average length of all the films in the Sakila database.

select title from film where length>(select avg(length) from film);

#3.Use a subquery to display all actors who appear in the film "Alone Trip".

select first_name, last_name from actor where actor_id in (select actor_id 
										                from film_actor 
														where film_id in (select film_id 
																	  from film 
																	  where title='Alone Trip'));
                                                        