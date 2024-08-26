use sakila;


#Solution_1

select
	count(film_id)
from
	inventory
where film_id = (select film_id from film where title like "Hunchback Impossible");


#Solution_2

select 
	title,
    length
from
	film 
where 
	length > (select avg(length) from film);
    
    
#Solution_3

select 
	actor_id,
	first_name,
    last_name 
from
	actor 
where 
	actor_id in 
				(select 
					actor_id 
				from
					film_actor 
				where 
					film_id = 
								(select 
									film_id 
								from 
									film 
								where
									title = "Alone Trip"
								)
				);


select 
	actor_id,
	count(film.film_id)
from
	film_actor 
left join
	film on film.film_id = film_actor.film_id
group by 
	actor_id;
    
    
#Solution_8

select 
	customer_id,
    sum(amount)
from 
	payment
group by
	customer_id
having 
	sum(amount) > 
					(select 
						avg(total_amount) as normal_avg
					from
						(select
							customer_id,
							sum(amount) as total_amount
						from
							payment
						group by 
							customer_id) as clients);
                            
                            

    
