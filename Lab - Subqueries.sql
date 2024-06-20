select * 
from inventory;

select *
from film;

select film_id
from film
where title = "Hunchback Impossible";

SELECT COUNT(film_id)
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

select avg(length)
from film;
          
select title, length
from film
where length > (select avg(length)
				from film)
order by length;

select title, film_id
from film
where title = 'Alone Trip';

select *
from actor;

select *
from film_actor;
                
select film_id,actor_id
from film_actor
where film_id in (select film_id
		from film
		where title = 'Alone Trip');
        
select *
from actor
where actor_id IN (select actor_id
					from film_actor
					where film_id = (
							select film_id
							from film
							where title = 'Alone Trip')
				);
                    
select film_id, actor_id
from film_actor
where film_id = 17;