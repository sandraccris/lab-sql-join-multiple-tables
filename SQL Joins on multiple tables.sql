USE sakila;

# Lab | SQL Joins on multiple tables

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country
FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country ctr
ON c.country_id = ctr.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.


SELECT s.store_id, SUM(p.amount) as total_amount
FROM store as s
JOIN staff as st
ON s.store_id = st.store_id
JOIN payment as p
ON st.staff_id = p.staff_id
GROUP BY s.store_id;


-- 3. What is the average running time of films by category?

SELECT c.name, ROUND (AVG(f.length)) as avg_running_time
FROM film as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name;


-- 4. Which film categories are longest?

SELECT c.name, ROUND (AVG(f.length)) as avg_running_time
FROM film as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;
-- Games and Sports have the the longest length.


-- 5. Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(r.rental_id) as most_rented
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY most_rented DESC;

-- Most rented movie is "BUCKET BROTHERHOOD", 34 times.


-- 6.List the top five genres in gross revenue in descending order.

SELECT c.name, SUM(p.amount) as gross_revenue
FROM category as c
JOIN film_category as fc
ON c.category_id = fc.category_id
JOIN film as f
ON fc.film_id = f.film_id
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
JOIN payment as p
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC;

-- top 5 are Sports, Sci-Fi, Animation, Drama and Comedy.


-- 7. Is "Academy Dinosaur" available for rent from Store 1?


SELECT f.title, i.store_id, COUNT(i.inventory_id)
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
WHERE title = "Academy Dinosaur" AND store_id = 1
GROUP BY f.title, i.store_id;

-- 4 copies available for renting in store 1.
