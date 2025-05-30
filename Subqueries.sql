USE sakila;

#1
	SELECT f.title, COUNT(i.inventory_id) as 'Nº of copies'
    FROM inventory i
    JOIN film f ON f.film_id = i.film_id
    WHERE f.title = 'Hunchback Impossible';
    
#2
	SELECT * FROM FILM HAVING length > (SELECT AVG(length) FROM film);
 
#3
	SELECT CONCAT(a.first_name, ' ', a.last_name) AS "'Alone Trip' cast" 
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id
    JOIN film f ON f.film_id = fa.film_id
    WHERE f.title = "Alone Trip";
    
#4
	SELECT f.title AS 'Family films'
    FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id
    JOIN category c ON c.category_id = fc.category_id
    WHERE c.name = 'Family';
    
#5
	SELECT CONCAT(cu.first_name, ' ', cu.last_name) AS 'Customer', cu.email
    FROM customer cu
    JOIN address a ON a.address_id = cu.address_id
    JOIN city ci ON ci.city_id = a.city_id
    JOIN country co ON co.country_id = ci.country_id
    WHERE co.country = 'Canada';

#6
	SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Most prolific actor'
	FROM actor a
	JOIN film_actor fa ON fa.actor_id = a.actor_id
	GROUP BY a.actor_id
	ORDER BY COUNT(fa.film_id) DESC
	LIMIT 1;

#7
	SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Most profitable customer'
	FROM customer c
	JOIN payment p ON p.customer_id = c.customer_id
	GROUP BY c.customer_id
	ORDER BY COUNT(p.amount) DESC
	LIMIT 1;
    
#8
	SELECT 
    c.customer_id AS client_id, SUM(p.amount) AS total_amount_spent
	FROM customer c
	JOIN payment p ON c.customer_id = p.customer_id
	GROUP BY c.customer_id
	HAVING 
		SUM(p.amount) > (SELECT AVG(total_amount) FROM 
        (SELECT SUM(amount) AS total_amount FROM payment GROUP BY customer_id) AS customer_totals)
	ORDER BY 
		COUNT(p.payment_id) DESC;