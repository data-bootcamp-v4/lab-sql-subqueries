use sakila;

select title
from film
where film_id in (select film_id from film_category where  category_id = (select category_id from category where `name` = 'Family'))