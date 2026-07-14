USE sakila;

-- Challenge 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory
SELECT
COUNT(i.inventory_id) AS total_copies
FROM inventory AS i
WHERE i.film_id = (
SELECT
film_id
FROM film
WHERE title = 'Hunchback Impossible'
);

-- Challenge 2. Films whose length is longer than the average length of all films
SELECT
f.title,
f.length
FROM film AS f
WHERE
f.length > (
SELECT
AVG(F2.length)
FROM film AS f2
);

-- Challenge 3. Actors who appear in the film "Alone Trip" (use subquery)
SELECT
a.first_name,
a.last_name
FROM actor AS a
WHERE
a.actor_id IN (
SELECT
fa.actor_id
FROM film_actor AS fa
WHERE
fa.film_id = (
SELECT
f.film_id
From
film AS f
WHERE
f.title = 'Alone Trip'
)
);

-- BONUS: 4. All movies categorized as family films
SELECT
f.title
FROM
film AS f
WHERE
f.film_id IN (
SELECT
fc.film_id
FROM
film_category AS fc
WHERE
fc.category_id = (
SELECT
c.category_id
FROM category AS c
WHERE
c.name = 'Family'
)
);

-- BONUS: 5. Retrieve name and email of Canadian customers using subqueries
SELECT
cu.first_name,
cu.last_name,
cu.email
From
customer AS cu
INNER JOIN address AS a
ON cu.address_id = a.address_id
WHERE a.city_id IN (
SELECT
ci.city_id
FROM city AS ci
INNER JOIN country AS CO
ON ci.country_id = co.country_id
WHERE
co.country = 'Canada'
);

-- BONUS: 6. Films starred by the most prolific actor
SELECT
f.title
FROM
film AS f
WHERE
f.film_id IN (
SELECT
fa.film_id
FROM
film_actor AS fa
WHERE
fa.actor_id = (
SELECT
fa2.actor_id
FROM film_actor AS fa2
GROUP BY
fa2.actor_id
ORDER BY COUNT(fa2.film_id) DESC
LIMIT 1
)
);

-- BONUS: 7. Films rented by the most profitable customer
SELECT DISTINCT
f.title
FROM
film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
WHERE
r.customer_id = (
SELECT
p.customer_id
FROM
payment AS p
GROUP BY
p.customer_id
ORDER BY
SUM(p.amount) DESC
LIMIT 1);

-- BONUS: 8. Clients who spent more than the average total amount spent
SELECT
p.customer_id,
SUM(p.amount) AS total_amount_spent
FROM
payment AS p
GROUP BY
p.customer_id
HAVING SUM(p.amount) > (
SELECT
AVG(derived.customer_total)
FROM (
SELECT
SUM(p2.amount) AS customer_total
FROM
payment AS p2
GROUP BY
p2.customer_id
) AS derived
)
ORDER BY
total_amount_spent DESC;
