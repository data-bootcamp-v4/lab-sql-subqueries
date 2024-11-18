use sakila;

select count(inventory_id) as recuento
from inventory
where film_id = (select film_id from film where title = 'HUNCHBACK IMPOSSIBLE')