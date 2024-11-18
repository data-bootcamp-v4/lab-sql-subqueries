use sakila;

select actor_id, count(film_id) as recuento
from film_actor
group by actor_id
order by recuento desc
limit 1;

select title
from film
where film_id in (select film_id from film_actor where actor_id = 107);
