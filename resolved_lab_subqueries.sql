
SELECT 
    COUNT(i.inventory_id) AS number_of_copies
FROM 
    film f
LEFT JOIN 
    sakila.inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Hunchback Impossible';
    
SELECT 
    title, 
    length
FROM 
 film
WHERE 
    length > (SELECT AVG(length) FROM film)
ORDER BY 
    length DESC;

SELECT 
    first_name, 
    last_name
FROM 
   actor
WHERE 
    actor_id IN (
        SELECT 
            actor_id
        FROM 
          film_actor
        WHERE 
            film_id IN (
                SELECT 
                    film_id
                FROM 
                  film
                WHERE 
                    title = 'Alone Trip'
            )
    );
 
    SELECT 
    f.film_id,
    f.title AS film_title,
    c.name AS category_name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family'
ORDER BY f.title ASC;

SELECT 
    co.country,
    cu.first_name,
    cu.last_name,
    cu.email
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY cu.last_name ASC;

SELECT 
    first_name,
    last_name,
    email
FROM customer
WHERE address_id IN (
    SELECT address_id 
    FROM address 
    WHERE city_id IN (
        SELECT city_id 
        FROM city 
        WHERE country_id = (
            SELECT country_id 
            FROM country 
            WHERE country = 'Canada'
        )
    )
);

SELECT 
    f.film_id,
    f.title AS film_title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    -- Subconsulta: Encuentra el ID del actor más prolífico
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
)
ORDER BY f.title ASC;

SELECT DISTINCT
    f.title AS film_title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    -- Subconsulta: Encuentra el ID del cliente con mayor gasto acumulado
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title ASC;

SELECT 
    customer_id AS client_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    -- Subconsulta: Calcula el promedio de lo que ha gastado cada cliente
    SELECT AVG(total_por_cliente)
    FROM (
        SELECT SUM(amount) AS total_por_cliente
        FROM payment
        GROUP BY customer_id
    ) AS subquery_promedio
)
ORDER BY total_amount_spent DESC;

 
 