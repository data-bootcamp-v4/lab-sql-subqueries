use sakila;

select customer_id, sum(amount) as total_amount
from payment
group by customer_id
order by total_amount desc
limit 1;

select title
from film
where film_id in (select film_id from inventory where inventory_id in (select inventory_id from rental where rental_id in (select rental_id from payment where customer_id = 526)));