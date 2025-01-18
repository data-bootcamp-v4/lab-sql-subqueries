--Exercise 1
SELECT 
    COUNT(*) AS NumberOfCopies
FROM 
    inventory
WHERE 
    film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');


--Exercise 2 
SELECT 
    title, 
    length
FROM 
    film
WHERE 
    length > (SELECT AVG(length) FROM film)
ORDER BY 
    length DESC;


--Exercise 3
SELECT 
    a.actor_id, 
    a.first_name, 
    a.last_name
FROM 
    actor a
WHERE 
    a.actor_id IN (
        SELECT 
            fa.actor_id
        FROM 
            film_actor fa
        JOIN 
            film f ON fa.film_id = f.film_id
        WHERE 
            f.title = 'Alone Trip'
    );


--Bonus 4
SELECT 
    f.title AS FamilyMovie
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
WHERE 
    c.name = 'Family';


--Bonus 5 -> Using subqueries
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
                    country_id = (SELECT country_id FROM country WHERE country = 'Canada')
            )
    );

--Bonus 5 -> Using joins
SELECT 
    c.first_name, 
    c.last_name, 
    c.email
FROM 
    customer c
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id
WHERE 
    co.country = 'Canada';


--Bonus 6
-- Step 1: Find the most prolific actor
WITH ProlificActor AS (
    SELECT 
        actor_id, 
        COUNT(*) AS FilmCount
    FROM 
        film_actor
    GROUP BY 
        actor_id
    ORDER BY 
        FilmCount DESC
    LIMIT 1
)

-- Step 2: Find the films of the most prolific actor
SELECT 
    f.title AS FilmTitle
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
WHERE 
    fa.actor_id = (SELECT actor_id FROM ProlificActor);


--Bonus 7
-- 
WITH MostProfitableCustomer AS (
    SELECT 
        customer_id, 
        SUM(amount) AS TotalSpent
    FROM 
        payment
    GROUP BY 
        customer_id
    ORDER BY 
        TotalSpent DESC
    LIMIT 1
)

-- 
SELECT 
    DISTINCT f.title AS RentedFilm
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    r.customer_id = (SELECT customer_id FROM MostProfitableCustomer);


-- Bonus 8

-- 
WITH CustomerSpending AS (
    SELECT 
        customer_id, 
        SUM(amount) AS TotalSpent
    FROM 
        payment
    GROUP BY 
        customer_id
)

-- 
SELECT 
    customer_id, 
    TotalSpent
FROM 
    CustomerSpending
WHERE 
    TotalSpent > (SELECT AVG(TotalSpent) FROM CustomerSpending)
ORDER BY 
    TotalSpent DESC;
