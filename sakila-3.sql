use sakila;

select concat(first_name, ' ', last_name) as actors_in_alone_trip
from actor
where actor_id in (select actor_id from film_actor where film_id = (select film_id from film where title = 'ALONE TRIP'))