#lab 2 sql_sub

#1 Determine the number of copies of the film 
#"Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

#2 List all films longer than the average length of all films
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

#3 Display all actors who appear in the film "Alone Trip"
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);





