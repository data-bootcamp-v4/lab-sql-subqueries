-- 1
select count(*) as number_of_copie 
from film as f
join inventory as inv
on f.film_id = inv.film_id
where title = 'HUNCHBACK IMPOSSIBLE';

-- 2
select title, length
from film
where length > (select avg(length) from film);

SELECT f.title, f.length
FROM film AS f
JOIN (
    SELECT AVG(length) AS average_length
    FROM film
) AS avg_table
ON f.length > avg_table.average_length;

-- 3
select concat(first_name, ' ', last_name) as ALONE_TRIP_full_name_actor
from actor as a
where a.actor_id in (
	select fa.actor_id 
    from film_actor as fa
    where fa.film_id in (
		select f.film_id
        from film as f
        where f.title = 'ALONE TRIP'
        )
);

-- 4  identy all_families_mvies
select f.title, c.name
from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
where c.name in ('Children', 'Comedy', 'Family');

-- 5 name_email_customer_canada
select c.first_name, c.email 
from customer as c
join address as a on c.address_id = a.address_id
join city as ci on a.city_id = ci.city_id
where ci.country_id in (
			select co.country_id
            from country as co
            where co.country = 'Canada');

-- 6 film of the most prolific actor
select f.title
from film as f
join film_actor as fa on f.film_id = fa.film_id
where fa.actor_id = (
	select fa.actor_id
	from film_actor as fa
	group by fa.actor_id
	order by count(fa.actor_id) desc
    limit 1);


-- 7 customer + de payment - les films loués par lui 

select distinct(f.title)
from rental as r
join payment as p on r.customer_id = p.customer_id
join inventory as inv on r.inventory_id = inv.inventory_id
join film  as f on inv.film_id = f.film_id
where r.customer_id = (
	select p.customer_id
    from payment as p
    group by p.customer_id
    order by sum(p.amount) desc
    limit 1);


-- 8 client_id/amount_spent pour client > avg spent

select c.customer_id, sum(p.amount) as total_spent
from customer c
join payment p on c.customer_id = p.customer_id
group by 1
having sum(p.amount) > (
	select avg(customer_total)
    from (
		select sum(p.amount) as customer_total
        from payment p
        group by p.customer_id) as subquery
     )
     order by 2 desc;   




    
    

			














