-- Use sakila
-- Select * from film_category; -- --> Film_ID and Category_ID
-- Select * from category; -- --> Category_ID
-- Select * from film; -- --> Film_ID,language_ID
-- Select * from country; -- --> Country_ID
-- Select * from City; -- --> City_ID, Country_ID
-- Select * from address; -- --> Addres_ID,City_ID 
-- Select * from payment; -- --> Paymnet_ID,Customer_ID,Staff_ID,Rental_ID
-- Select * from rental; -- -- Rental_ID,Inventory_ID,Customer_ID,Staff_ID
-- Select * from store; -- --> Store_ID, Manager_Staff_ID,addres_ID
-- Select * from customer; -- --> Customer_ID,Store_ID, Address_ID
-- Select * from staff; -- --> Staff_ID, Address_ID, Store_ID
-- Select * from inventory; -- --> inventory_id, Film_ID, Store_ID
-- Select * from actor; -- --> Actor_ID
-- Select * from film_actor; -- --> actor_ID, Film_ID


-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- Select Count(title) as Copies from film f
-- join inventory i on f.film_ID=i.film_id
-- where title ="Hunchback Impossible";

Select f.Film_ID,f.Title,inv.Copies from film f
inner join (Select i.film_ID,Count(film_id)Copies from inventory i group by film_id) inv
on inv.film_id=f.film_id
where f.title ="Hunchback Impossible";


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
Select * from film f
where length > (Select avg(length) from film );

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

Select * from actor where actor_id in 
(Select actor_id from film_actor fc 
join film f on f.film_id=fc.film_id
where title= "Alone Trip");
