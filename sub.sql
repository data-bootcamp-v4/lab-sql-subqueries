USE sakila;

# 1
SELECT COUNT(*)
FROM inventory i
INNER JOIN 
			(SELECT film_id, title
            FROM film 
            WHERE title = 'Hunchback Impossible') f
ON f.film_id = i.film_id;

# 2 
SELECT *
FROM film
WHERE length > (SELECT AVG(length) FROM film);

# 3
SELECT COUNT(a.actor_id), f.title
FROM film_actor a
INNER JOIN 
			(SELECT film_id, title
            FROM film
            WHERE title = 'Alone Trip') f
ON a.film_id = f.film_id;

# 4
SELECT f.title, c.name
FROM film_category y
INNER JOIN 
			(SELECT * FROM category
            WHERE name = 'Family') c
ON c.category_id = y.category_id
INNER JOIN film f
ON f.film_id = y.film_id;

# 5
SELECT first_name, last_name, email, country 
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city y
ON y.city_id = a.city_id
INNER JOIN 
			(SELECT * FROM country 
			WHERE country = 'Canada') x
ON y.country_id = x.country_id;

#6
SELECT a.count, f.title, a.actor_id 
FROM film_actor x
INNER JOIN 
			(SELECT COUNT(film_id) AS count, actor_id
            FROM film_actor
            GROUP BY actor_id) a 
ON x.actor_id = a.actor_id
INNER JOIN film f
ON f.film_id = x.film_id
ORDER BY count DESC;

SELECT COUNT(film_id), actor_id
FROM film_actor
GROUP BY actor_id