use sakila;


    -- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
    
select count(inventory_id)
from inventory
where film_id in 
(select film_id
from film
where title = "Hunchback Impossible");


    -- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
HAVING length > (SELECT ROUND(AVG(length),2) FROM film);

    -- Use a subquery to display all actors who appear in the film "Alone Trip". CONTINUAR
    

select first_name, last_name
from actor
where actor_id in (
select actor_id
from film_actor
where film_id in (select film_id
from film
where title = "Alone Trip"));

