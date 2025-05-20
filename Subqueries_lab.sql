#1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

/*
select f.film_id
from sakila.film as f
where title ="Hunchback Impossible";

select count(distinct inventory_id) as inventary
from sakila.inventory as i
where film_id = 439;
*/

#Subsituir la primera query en lloc del 439

select count(distinct inventory_id) as inventary
from sakila.inventory as i
where film_id = (select f.film_id
					from sakila.film as f
					where title ="Hunchback Impossible");

#2.List all films whose length is longer than the average length of all the films in the Sakila database. 

select 
	f.title,
    f.length
from sakila.film as f
where f.length > 
	(select avg(length) 
		from sakila.film);
        
#3. Use a subquery to display all actors who appear in the film "Alone Trip".

/*
select 
	a.first_name
from sakila.actor as a
join sakila.film_actor as fa
	on a.actor_id = fa.actor_id
join sakila.film as f
	on fa.film_id = f.film_id
where f.title = "Alone Trip";
*/

SELECT 
    first_name, last_name
FROM sakila.actor
WHERE actor_id IN (
    SELECT actor_id
    FROM sakila.film_actor
    WHERE film_id = (
        SELECT film_id 
        FROM sakila.film
        WHERE title = 'Alone Trip'
    )
);


