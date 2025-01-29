/*day3 lab subqueries*/

/*challenge task1*/
select count(inventory_id) as number_of_copies
from inventory
where film_id in (select film_id
					from film
					where title like 'Hunchback Impossible');

/*challenge task2*/
select title
from film
where length > (select avg(length)
				from film);

/*challenge task3*/
select first_name, last_name
from actor
where actor_id in (select actor_id
					from film_actor
					where film_id = (select film_id
										from film
										where title like 'Alone Trip'));
