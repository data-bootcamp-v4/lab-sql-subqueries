#lab 05 - subqueries
use sakila;
#challenge 1: Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(i.film_id)
from inventory i
where film_id = (select film_id from film where title='Hunchback Impossible');
#challenge 2: List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length 
from film
where length > (select avg(length) from film)
order by length asc; 
#challenge 3: Use a subquery to display all actors who appear in the film "Alone Trip".
select a.first_name, a.last_name
from actor a
where actor_id in (select actor_id from film_actor where film_id =(select film_id from film where title='Alone Trip'))