SELECT count(film_id) as copies from inventory 
where film_id = ( SELECT film_id from film where title = "Hunchback Impossible"
);

SELECT * from film where length > (
SELECT avg(length) from film );

SELECT first_name, last_name from actor
where actor_id in (SELECT actor_id from film_actor where film_id in ( SELECT film_id from film where title = "ALONE TRIP") );
SELECT title from film