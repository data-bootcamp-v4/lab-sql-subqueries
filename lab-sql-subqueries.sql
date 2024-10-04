#Write SQL queries to perform the following tasks using the Sakila database:

#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
#select * from inventory where film_id=439;
#select * from film where title="Hunchback Impossible";

select COUNT(*)
from inventory AS i
where i.film_id=(select film_id from film where title="Hunchback Impossible");

#List all films whose length is longer than the average length of all the films in the Sakila database.
select title,length,(SELECT AVG(length) FROM film) AS avg_length
from film
where length>(select AVG(length) from film);


#Use a subquery to display all actors who appear in the film "Alone Trip".
select actor_id,CONCAT(first_name, ' ', last_name) AS actor_name
from actor
where actor_id IN (select actor_id
from film_actor
where film_id=(select film_id from film where title="Alone Trip"))
group by actor_id;


