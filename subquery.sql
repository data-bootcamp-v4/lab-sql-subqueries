USE sakila;
#1
select count(*)as number_of_copies from inventory as i
join film f
on f.film_id=i.film_id
where title="Hunchback Impossible";
#2
select title from film
where length >(
select avg(length) as avg from film) ;
#3

select a.first_name,a.last_name,f.title from actor as a
join film_actor as fc
on a.actor_id=fc.actor_id
join (select film_id,title from film
where title= "Alone Trip") as f
on fc.film_id=f.film_id;

#bonus
#1
select category_id,name from category
where name="Family";
select f.title,c.name from film as f
join film_category as fc
on f.film_id=fc.film_id
join (select category_id,name from category
where name="Family") as c
on c.category_id=fc.category_id;

#2

select c.first_name,c.last_name,c.email,co.country from customer as c
join address as a
on c.address_id=a.address_id
join city as ci
on a.city_id=ci.city_id
join (select country_id,country from country
where country="canada") co
on co.country_id=ci.country_id;

#3
select a.actor_id,a.first_name,a.last_name,count(fc.film_id) as number_of_films from actor as a
join film_actor as fc
on a.actor_id=fc.actor_id
join film f
on f.film_id=fc.film_id
group by a.actor_id,a.first_name,a.last_name
order by number_of_films desc
limit 1;
select f.title,top_actor.first_name,top_actor.last_name from(
select a.actor_id,a.first_name,a.last_name,count(fc.film_id) as number_of_films from actor as a
join film_actor as fc
on a.actor_id=fc.actor_id
join film f
on f.film_id=fc.film_id
group by a.actor_id,a.first_name,a.last_name
order by number_of_films desc
limit 1) as top_actor
join film_actor fc
on top_actor.actor_id=fc.actor_id
join film f
on fc.film_id=f.film_id;

#3
select c.customer_id,c.first_name,c.last_name,sum(p.amount) as total_payment from customer c
join payment p
on p.customer_id=c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by total_payment desc
limit 1;
select ft.title,top_customer.first_name from rental as r
join inventory i
on i.inventory_id=r.inventory_id
join film_text as ft
on ft.film_id=i.film_id
join (select c.customer_id,c.first_name,c.last_name,sum(p.amount) as total_payment from customer c
join payment p
on p.customer_id=c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by total_payment desc
limit 1) as top_customer
on top_customer.customer_id=r.customer_id;

#4
select round(avg(total),2) as total_amount from(
select c.customer_id as cilent_id,sum(p.amount) as total from customer as c
join payment p
on p.customer_id=c.customer_id
group by c.customer_id)t;
select c.customer_id as cilent_id,sum(p.amount) as total_amount_spent from customer c
join payment p
on p.customer_id=c.customer_id
group by c.customer_id
having total_amount_spent>(select round(avg(total),2) as total_amount from(
select c.customer_id as cilent_id,sum(p.amount) as total from customer as c
join payment p
on p.customer_id=c.customer_id
group by c.customer_id)t)