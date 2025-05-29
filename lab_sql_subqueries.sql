use sakila;

#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(*) as num_copies_HI
from
(select i.film_id,
f.title
from inventory i
left join film f
on i.film_id = f.film_id
where f.title = 'Hunchback Impossible') as t1;

#List all films whose length is longer than the average length of all the films in the Sakila database.
select title
from film 
where length >
(select avg(length)
from film);

#Use a subquery to display all actors who appear in the film "Alone Trip".
select a.first_name,
a.last_name
from film_actor fa
left join actor a
on fa.actor_id = a.actor_id
where fa.film_id = (select film_id
				from film
				where title = 'Alone Trip');