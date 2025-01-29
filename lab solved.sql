use sakila;

select count(inventory_id)
from inventory
where (select inventory_id
		from film
		where title="HUNCHBACK IMPOSSIBLE");

select title, length
from film
where length > (select avg(length)
				from film
				group by "");

select first_name, last_name
from actor
where actor_id in (select actor_id
					from film_actor
					where film_id=(select film_id
									from film
									where title="ALONE TRIP"));

select title
from film
where film_id in (select film_id
				from film_category
				where category_id in (select category_id
									from category
									where name="Family"));
                                    
select first_name, last_name, email
from customer
where address_id in (select address_id
					from address
					where city_id in ( select city_id
										from city
										where country_id =(select country_id
															from country
                                                            where country="CANADA")));

select first_name, last_name
from actor
where actor_id =(select actor_id
				from film_actor
				group by actor_id
				order by count(actor_id) desc
				limit 1);


select title
from film
where film_id in (select film_id
				from inventory
                where inventory_id in (select inventory_id
										from rental
                                        where customer_id=(select customer_id
															from customer
															where customer_id=(select customer_id
																				from payment
																				group by customer_id
																				order by sum(amount) desc
																				limit 1))));
select customer_id, sum(amount)
from payment
group by customer_id
having sum(amount)>(select (select sum(amount)
							from payment 
							group by "")		/	count(customer_id)
					from payment);
                                            
                
                
                




