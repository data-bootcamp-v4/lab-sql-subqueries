USE sakila;
SELECT 
    COUNT(i.film_id) AS hunchback_count
FROM
    inventory i
WHERE
    i.film_id = (SELECT f.film_id
        FROM
            film f
            WHERE f.title = 'Hunchback Impossible');
            
SELECT DISTINCT(f.title)
FROM film f
WHERE
	f.length > (SELECT AVG(length) FROM film);
    
SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.actor_id IN (SELECT 
            film_actor.actor_id
        FROM
            film_actor
        WHERE
            film_actor.film_id = (SELECT 
                    film.film_id
                FROM
                    film
                WHERE
                    film.title = 'Alone Trip'));

SELECT 
    f.title
FROM
    film f
WHERE
    f.film_id IN (SELECT 
            fc.film_id
        FROM
            film_category fc
        WHERE
            fc.category_id = (SELECT 
                    c.category_id
                FROM
                    category c
                WHERE
                    c.name = 'Family'));

SELECT 
    cu.first_name, cu.email
FROM
    customer cu
        JOIN
    store s ON cu.store_id = s.store_id
WHERE
    s.address_id IN (SELECT 
            a.address_id
        FROM
            address a
                JOIN
            city ci ON a.city_id = ci.city_id
                JOIN
            country co ON ci.country_id = co.country_id
        WHERE
            co.country = 'Canada');
            
SELECT ac.first_name, ac.last_name
FROM actor ac
WHERE ac.actor_id = (SELECT fa.actor_id FROM film_actor fa
GROUP BY fa.actor_id
ORDER BY Count(fa.film_id) DESC
LIMIT 1);

SELECT 
    f.title
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    r.customer_id = (SELECT 
            p.customer_id
        FROM
            payment p
        GROUP BY p.customer_id
        ORDER BY SUM(p.amount) DESC
        LIMIT 1);

SELECT 
    p.customer_id AS client_id,
    SUM(p.amount) AS total_amount_spent
FROM
    payment p
GROUP BY p.customer_id
HAVING SUM(p.amount) > (SELECT 
        AVG(total_spent)
    FROM
        (SELECT 
            SUM(amount) AS total_spent
        FROM
            payment
        GROUP BY customer_id) AS subquery)
ORDER BY total_amount_spent DESC;
