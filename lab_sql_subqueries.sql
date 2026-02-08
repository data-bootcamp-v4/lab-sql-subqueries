USE sakila;

#1
SELECT title,
	( SELECT COUNT(*)
    FROM inventory i
    WHERE i.film_id = f.film_id
    ) AS count_copies
FROM film f
WHERE title = "Hunchback Impossible";

#2
SELECT film_id,
	   title,
	 length AS above_avg_length
FROM film
WHERE length > ( SELECT AVG(length) AS avg_length FROM film)
ORDER BY above_avg_length ASC;

#3

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
	 SELECT fc.actor_id
	 FROM film_actor fc
	 WHERE fc.film_id IN ( 
			SELECT f.film_id
			FROM film f
			WHERE f.title = "Alone Trip"
    )
     );
#4
SELECT f.film_id, f.title 
FROM  film f
WHERE f.film_id IN (SELECT fc.film_id
				   FROM film_category fc 
				   WHERE fc.category_id IN (SELECT c.category_id
										 FROM category c 
										 WHERE c.name = "Family"));

#5
SELECT c.first_name, c.last_name, c.email
FROM customer c 
WHERE c.address_id IN ( SELECT a.address_id, a.city_id
						FROM address a
                       WHERE a.city_id = (
				       ( 
