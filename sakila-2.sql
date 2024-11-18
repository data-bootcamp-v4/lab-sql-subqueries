use sakila;

select title
from film
where `length` > (select avg(`length`) from film);

