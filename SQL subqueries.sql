## 1
select f.title,count(i.inventory_id) copy_num
from inventory i
join film f 
on i.film_id = f.film_id
where f.title= 'Hunchback Impossible';

## 2
select * 
from film 
where length > (
select avg(length)
from film);

# 3
select actor_id, full_name,last_name
from actor 
where actor_id in (
      select f.actor_id 
      from film f
      join film_actor fa
      on f.film_id = fa.film_id);
# 4
select fi.film_id, fi.title 
from category ca
join film_category fc
on ca.category_id= fc.category_id
join film fi 
on fc.film_id= fi.film_id
where ca.name = 'Family';

# 5
select cu.first_name, 
       cu.last_name,
       cu.email
from customer cu
where address_id in
(select ad.address_id
from address ad
join city ci
on ad.city_id = ci.city_id
join country co
on ci.country_id = co.country_id
where co.country = 'Canada');

# 6
select f.title
from film f 
join film_actor fa
on f.film_id = fa.film_id
where fa.actor_id = 
(select fa.actor_id 
from film_actor fa
group by actor_id
order by count(actor_id) DESC 
LIMIT 1);
    
# 7
select fi.title
from film fi 
join inventory inv on fi.film_id = inv.film_id
join rental re on inv.inventory_id = re.inventory_id
where customer_id =
(select p.customer_id 
from payment p
group by customer_id
order by SUM(amount) desc
LIMIT 1);

# 8
select customer_id, SUM(amount) as total_amount
from payment
group by customer_id
having sum(amount) > (
    select avg(total_amount)
    from (select sum(amount) as total_amount
          from payment
          group by customer_id) as avg_amounts
);





      