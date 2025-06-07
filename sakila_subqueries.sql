USE sakila;
#Cuántas copias de la película “Hunchback Impossible” existen 
SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (
  SELECT film_id
  FROM film
  WHERE title = 'Hunchback Impossible'
);
#2. Películas cuya duración es mayor que la duración promedio
SELECT title, length
FROM film
WHERE length > (
  SELECT AVG(length)
  FROM film
);
#3. Actores que aparecen en la película “Alone Trip”
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'
  )
);
#4. Películas categorizadas como "Family"
SELECT f.title
FROM film f
WHERE f.film_id IN (
  SELECT fc.film_id
  FROM film_category fc
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Family'
);
#5. Nombre y correo electrónico de clientes de Canadá 
SELECT first_name, last_name, email
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
#6. Películas del actor más prolífico
SELECT DISTINCT f.title
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE p.customer_id = (
  SELECT customer_id
  FROM payment
  GROUP BY customer_id
  ORDER BY SUM(amount) DESC
  LIMIT 1
);
#8. Clientes que han gastado más que el promedio de todos los clientes
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > (
  SELECT AVG(total_per_customer)
  FROM (
    SELECT SUM(amount) AS total_per_customer
    FROM payment
    GROUP BY customer_id
  ) AS customer_totals
);


