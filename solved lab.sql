use sakila; 

select count(*) from inventory
left join film on film.film_id = inventory.film_id
where film.title LIKE "Hunchback Impossible";

select title, length
from film
where length > (SELECT AVG(length) from film);

select film.title, actor.first_name, actor.last_name
from actor
left join film_actor on film_actor.actor_id = actor.actor_id
left join film on film.film_id = film_actor.film_id
where film.title like "ALONE TRIP";

select film.title, category.name
from film
left join film_category on film_category.film_id = film.film_id
left join category on film_category.category_id = category.category_id
where category.name LIKE "Family";


select count(film.title) as "prolificity", actor.actor_id, actor.first_name, actor.last_name
from actor
left join film_actor on film_actor.actor_id = actor.actor_id
left join film on film.film_id = film_actor.film_id
group by actor.actor_id, actor.first_name, actor.last_name
order by count(film.title) DESC;

select film_actor.actor_id, film.title
from film
left join film_actor ON film_actor.film_id = film.film_id
left join actor ON film_actor.actor_id = actor.actor_id
where film_actor.actor_id = 107;

select customer.customer_id, sum(amount), customer.last_name
from payment
left join customer on customer.customer_id = payment.customer_id
group by customer.customer_id, customer.last_name
order by sum(amount) DESC;

select rental.customer_id, film.title
from rental
left join inventory on rental.inventory_id = inventory.inventory_id
left join film on film.film_id = inventory.film_id
where customer_id = 526;

select customer_id, SUM(amount) as "total amount spent"
from payment
group by customer_id
HAVING SUM(amount) > (SELECT AVG(amount) from payment);

