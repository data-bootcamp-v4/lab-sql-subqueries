-- sql subqueries lab

use sakila;

-- 1. number of copies of hunchback impossible in inventory
select 
    f.title,
    count(i.inventory_id) as num_copies
from film f
join inventory i on f.film_id=i.film_id
where f.title='Hunchback Impossible'
group by f.title;

-- 2. films longer than average length
select title,length
from film
where length > (select avg(length) from film)
order by length desc;

-- 3. actors in alone trip
select first_name,last_name
from actor
where actor_id in (
    select actor_id
    from film_actor
    where film_id=(
        select film_id
        from film
        where title='Alone Trip'
    )
);

-- bonus questions

-- 4. all family films
select title
from film
where film_id in (
    select film_id
    from film_category
    where category_id=(
        select category_id
        from category
        where name='Family'
    )
);

-- 5. customers from canada using subqueries
select first_name,last_name,email
from customer
where address_id in (
    select address_id
    from address
    where city_id in (
        select city_id
        from city
        where country_id=(
            select country_id
            from country
            where country='Canada'
        )
    )
);

-- 5. customers from canada using joins
select c.first_name,c.last_name,c.email
from customer c
join address a on c.address_id=a.address_id
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id
where co.country='Canada';

-- 6. films by most prolific actor
select title
from film
where film_id in (
    select film_id
    from film_actor
    where actor_id=(
        select actor_id
        from film_actor
        group by actor_id
        order by count(film_id) desc
        limit 1
    )
);

-- 7. films rented by most profitable customer
select f.title
from film f
join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
where r.customer_id=(
    select customer_id
    from payment
    group by customer_id
    order by sum(amount) desc
    limit 1
);

-- 8. clients who spent more than average
select customer_id,sum(amount) as total_spent
from payment
group by customer_id
having sum(amount) > (
    select avg(total)
    from (
        select sum(amount) as total
        from payment
        group by customer_id
    ) as customer_totals
)
order by total_spent desc;