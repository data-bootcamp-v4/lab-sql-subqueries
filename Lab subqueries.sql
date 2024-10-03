USE sakila;

-- QUESTION 1:
SELECT f.title AS film_title, COUNT(i.inventory_id) AS copies
FROM film AS f
JOIN inventory AS i
ON f.film_id=i.film_id
WHERE f.title = "Hunchback Impossible";

-- QUESTION 2:
SELECT
    title,
    length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- QUESTION 3: 
SELECT a.first_name, a.last_name
FROM actor AS a
WHERE 
	a.actor_id IN(
		SELECT
			film_actor.actor_id
		FROM
			film AS f
		INNER JOIN
			film_actor 
		ON 
			f.film_id = film_actor.film_id
		WHERE
			f.title = "Alone Trip"
);

-- BONUS:
-- QUESTION 4: 
SELECT f.title AS movie_title
FROM film AS f
INNER JOIN film_category as fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = "Family";

-- QUESTION 5: 
SELECT
    customer.first_name,
    customer.last_name,
    customer.email
FROM
    customer
JOIN
    address ON customer.address_id = address.address_id
JOIN
    city ON address.city_id = city.city_id
JOIN
    country ON city.country_id = country.country_id
WHERE
    country.country = 'Canada';

SELECT
    first_name,
    last_name,
    email
FROM
    customer
WHERE
    address_id IN (
        SELECT
            address_id
        FROM
            address
        WHERE
            city_id IN (
                SELECT
                    city_id
                FROM
                    city
                WHERE
                    country_id IN (
                        SELECT
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'Canada'
                    )
            )
    );
    
-- QUESTION 6:
SELECT
    actor_id,
    COUNT(*) AS film_count
FROM
    film_actor
GROUP BY
    actor_id
ORDER BY
    film_count DESC
LIMIT 1;

SELECT
    film.film_id,
    film.title
FROM
    film
JOIN
    film_actor ON film.film_id = film_actor.film_id
WHERE
    film_actor.actor_id = (SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(*) DESC LIMIT 1);
    
-- QUESTION 7:
SELECT
    customer_id,
    SUM(amount) AS total_payment
FROM
    payment
GROUP BY
    customer_id
ORDER BY
    total_payment DESC
LIMIT 1;


SELECT
    film.title
FROM
    film
JOIN
    inventory ON film.film_id = inventory.film_id
JOIN
    rental ON inventory.inventory_id = rental.inventory_id
JOIN
    customer ON rental.customer_id = customer.customer_id
WHERE
    customer.customer_id = (SELECT
                                customer_id
                            FROM
                                payment
                            GROUP BY
                                customer_id
                            ORDER BY
                                SUM(amount) DESC
                            LIMIT 1);
                            
