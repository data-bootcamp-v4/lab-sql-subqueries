# 1. Determine the number of copies of the film "Hunchback Impossible" in the inventory
SELECT 
    f.title,
    COUNT(i.inventory_id) AS copies_available
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

#2.List all films longer than the average length of all films

SELECT 
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;

# 3. Use a subquery to display all actors who appear in the film "Alone Trip"

SELECT 
    a.first_name,
    a.last_name
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

# Bonus 
# Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT 
    f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family'
ORDER BY f.title;



