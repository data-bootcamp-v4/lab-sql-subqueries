USE sakila;
/*
Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
List all films whose length is longer than the average length of all the films in the Sakila database.
Use a subquery to display all actors who appear in the film "Alone Trip".
*/

select count(*) as number_of_copies 
from 
(select i.film_id from sakila.inventory as i where i.film_id in 
(select f.film_id from sakila.film as f where f.title = 'Hunchback Impossible')
) as hi;

select f.title, f.length from sakila.film as f where f.length > (
select round(avg(f.length), 2) as 'average_length' from sakila.film as f);

select a.first_name, a.last_name from sakila.actor as a where a.actor_id in (select fa.actor_id from sakila.film_actor as fa where fa.film_id =(select f.film_id from sakila.film as f where f.title = 'Alone Trip'));
