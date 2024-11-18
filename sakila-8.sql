use sakila;

select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id
having avg(amount) > (select avg(amount) from payment)
