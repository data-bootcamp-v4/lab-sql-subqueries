USE sakila;

-- Script 1

SELECT 
fi.title,
count(inv.inventory_id) as copyCNT
FROM film fi
JOIN inventory inv on inv.film_id = fi.film_id 
WHERE fi.title LIKE '%Hunchback Impossible%'
Group by fi.title;

-- Script 2

SELECT 
title,
length
FROM film
WHERE length > (select AVG(length) from film)
order by length desc;

-- Script 3

SELECT 
fi.title,
ac.first_name,
ac.last_name
FROM film fi
JOIN film_actor fa on fa.film_id = fi.film_id 
JOIN actor ac on ac.actor_id = fa.actor_id
WHERE fi.film_id IN (
  SELECT film_id FROM film WHERE title LIKE '%Alone Trip%'
);