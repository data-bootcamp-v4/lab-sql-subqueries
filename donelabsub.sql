-- 1. Количество копий фильма "Hunchback Impossible" в инвентаре
SELECT 
    COUNT(*) AS copy_count
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Hunchback Impossible';


-- 2. Фильмы, продолжительность которых больше средней по базе
SELECT 
    title,
    length
FROM 
    film
WHERE 
    length > (
        SELECT 
            AVG(length)
        FROM 
            film
    )
ORDER BY 
    length DESC;


-- 3. Актёры, снявшиеся в фильме "Alone Trip"
SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.actor_id IN (SELECT 
            fa.actor_id
        FROM
            film f
                JOIN
            film_actor fa ON f.film_id = fa.film_id
        WHERE
            f.title = 'Alone Trip');
