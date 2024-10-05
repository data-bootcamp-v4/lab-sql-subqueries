use sakila;

#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select COUNT(film_id) AS number_of_copies
from inventory
where film_id = (select film_id
from film
where title = "Hunchback Impossible");

#2 List all films whose length is longer than the average length of all the films in the Sakila database.
select film_id,title
from film
where length > (select AVG(length)
				from film);
                
#3 Use a subquery to display all actors who appear in the film "Alone Trip".
# a) with a subquery:
select film_id, CONCAT(A.first_name , ' ' , A.last_name) AS actor_full_name
from actor A
JOIN film_actor FA
ON A.actor_id = FA.actor_id
WHERE FA.film_id = ( select film_id
from film
where title = "Alone Trip" );
# b) With two join
select FA.actor_id ,CONCAT(A.first_name , ' ' , A.last_name) AS actor_full_name
from film F
JOIN film_actor FA 
ON F.film_id = FA.film_id
JOIN actor A
ON A.actor_id = FA.actor_id
where F.title = "Alone Trip";


select *
from film_actor FA;

# Bonus
#4 Sales have been lagging among young families, and you want to target family movies for a promotion. 
# Identify all movies categorized as family films.
select F.film_id, F.title,F.description
from film F
join film_category FC
on FC.film_id = F.film_id
join category C 
ON C.category_id = FC.category_id
WHERE C.category_id = (  select category_id
from category
where name = 'Family'   );

#5 Retrieve the name and email of customers from Canada using both subqueries and joins. 
# To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT CONCAT(C.first_name , ' ' , C.last_name) AS customer_full_name , C.email
FROM customer C
JOIN rental R 
ON C.customer_id = R.customer_id
JOIN staff F 
ON R.staff_id = F.staff_id
JOIN address A 
ON F.address_id = A.address_id 
JOIN city CI 
ON CI.city_id = A.city_id
JOIN country CO 
ON CO.country_id = CI.country_id
WHERE CO.country = 'Canada';  

#6 Determine which films were starred by the most prolific actor in the Sakila database. -> 6 b)
# A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films 
# that he or she starred in. 

#6 a) subrequest for the most prolific actor (we take only the actor_id from this request).
select A.actor_id , CONCAT(A.first_name, ' ', A.last_name) AS actor_full_name, COUNT(FA.film_id) AS number_films
from actor A 
JOIN film_actor FA 
ON A.actor_id = FA.actor_id
JOIN FILM F 
ON F.film_id = FA.film_id
group by A.actor_id , CONCAT(A.first_name, ' ', A.last_name)
order by number_films DESC
limit 1;

# 6 b)
select F.title,CONCAT(A.first_name, ' ', A.last_name) AS actor_name
from film F
JOIN film_actor FA
ON F.film_id = FA.film_id
JOIN actor A 
ON A.actor_id = FA.actor_id
WHERE A.actor_id = (  select A.actor_id 
from actor A 
JOIN film_actor FA 
ON A.actor_id = FA.actor_id
JOIN FILM F2 
ON F2.film_id = FA.film_id
group by A.actor_id , CONCAT(A.first_name, ' ', A.last_name)
limit 1  );


