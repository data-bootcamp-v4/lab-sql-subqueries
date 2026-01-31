USE sakila;
##1
SELECT
    COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE');
    
##2    
SELECT
  film_id,
  title,
  length
FROM film
WHERE length > (
  SELECT AVG(length) FROM film
)
ORDER BY length DESC;

## 3
SELECT
  actor_id,
  first_name,
  last_name
FROM actor
WHERE actor_id IN (
  SELECT actor_id
  FROM film_actor
  WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'ALONE TRIP'))
ORDER BY last_name, first_name;

## 4
SELECT
  title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM film_category
  WHERE category_id = (
    SELECT category_id
    FROM category
    WHERE name = 'Family'))
ORDER BY title;

##5
SELECT
  customer_id,
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
      WHERE country = 'Canada')))
ORDER BY last_name, first_name;

##6
SELECT
  film_id,
  title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM film_actor
  WHERE actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1))
ORDER BY title;

## 7
SELECT DISTINCT
  title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM inventory
  WHERE inventory_id IN (
    SELECT inventory_id
    FROM rental
    WHERE customer_id = (
      SELECT customer_id
      FROM payment
      GROUP BY customer_id
      ORDER BY SUM(amount) DESC
      LIMIT 1)))
ORDER BY title;

## 8
SELECT
  t.customer_id,
  t.total_amount_spent
FROM (
  SELECT
    customer_id,
    SUM(amount) AS total_amount_spent
  FROM payment
  GROUP BY customer_id
) AS t
WHERE t.total_amount_spent > (
  SELECT AVG(x.total_amount_spent)
  FROM (
    SELECT
      customer_id,
      SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id) AS x)
ORDER BY t.total_amount_spent DESC;