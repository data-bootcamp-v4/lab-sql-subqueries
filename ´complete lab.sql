-- 1--

SELECT 
    f.title,
    COUNT(i.inventory_id) AS number_of_copies
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Hunchback Impossible'
GROUP BY 
    f.title;
    
-- 2 --
SELECT 
    title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film)
ORDER BY length DESC;
-- 3 --

