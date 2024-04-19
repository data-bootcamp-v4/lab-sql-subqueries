#LAB SQL SUBQUERIES
#1
SELECT COUNT(*) AS num_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';
#2
SELECT f.title FROM film f
WHERE f.length > (SELECT AVG(length) FROM film);
#3
SELECT a.actor_id, a.first_name,a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Alone Trip';

#Bonus
#1 
SELECT f.title AS film_title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';
#2
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address 
WHERE city_id IN (SELECT city_id FROM city 
WHERE country_id IN (SELECT country_id FROM country 
WHERE country = 'Canada')));
#Using joins:
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
#3
SELECT f.title AS film_title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
        SELECT actor_id
        FROM (SELECT 
                actor_id, 
                COUNT(*) AS film_count
            FROM film_actor
            GROUP BY actor_id
            ORDER BY film_count DESC
            LIMIT 1) AS most_prolific_actor);





