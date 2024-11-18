use sakila;

select country
from country;

select first_name, email
from customer
where address_id in (select address_id from address where city_id in (select city_id from city where country_id = (select country_id from country where country = 'Canada')))