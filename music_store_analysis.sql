-- ======================================
-- MUSIC STORE DATA ANALYSIS PROJECT
-- Author: Drishti Agrawal
-- Tools Used: PostgreSQL
-- ======================================

--Q1: Who is the senior most employee based on job title?

select *
from employee
order by levels desc
limit 1;

--Q2: Which countries have the most invoices?

select count(*) as invoices, billing_country
from invoice
group by billing_country
order by invoices desc;

--Q3: What are top three values of total invoice?

select total from invoice
order by total desc
limit 3;

--Q4 Which city has the best customer? we would like to throw a promotional music festival
--in the city we made the most money. Write a query that returns one city that has the high
--the highest sum of invoice totals. Return both the city name & sum of all invoices 

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc;

--Q5 Who is the best customer?

select c.customer_id, c.first_name, c.last_name, sum(i.total) as total_spent
from customer c
join invoice i
on c.customer_id = i.customer_id
group by c.customer_id
order by total_spent desc
limit 1;

--Q6 Write a query to return the email, first name, & last name of all rock music
--listeners. Return your list ordered alphabetically by email starting with A.

select distinct c.email, c.first_name, c.last_name
from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line l on i.invoice_id = l.invoice_id
join track t on l.track_id = t.track_id
join genre g on t.genre_id = g.genre_id
where g.name = 'Rock'
order by c.email;

--Q7 Let's invite the artists who have written the most rock music in our dataset. Write a 
--query that returns the Artist name and total track count of the top 10 rock bands.

select a.name, a.artist_id, count(a.artist_id) as number_of_songs from artist a
join album b on a.artist_id = b.artist_id
join track t on b.album_id = t.album_id
join genre g on t.genre_id = g.genre_id
where g.name like 'Rock'
group by a.artist_id, a.name
order by number_of_songs desc
limit 10;

--Q8 Return all the track names that have a song length longer than the avg song length.
--Return the name and milliseconds for each track. Order by the song length with the longest 
--song listed first

select name, milliseconds
from track
where milliseconds > (select avg(milliseconds) as avg_track_length
from track)
order by milliseconds desc;

-- Q9: Calculate the monthly revenue trend.
-- Write a query to display each month and the total revenue generated in that month.
-- Sort the results chronologically by month.

SELECT 
    EXTRACT(MONTH FROM invoice_date) AS month,
    SUM(total) AS revenue
FROM invoice
GROUP BY month
ORDER BY month asc;

-- =========================
-- KEY INSIGHTS
-- =========================
-- A small group of customers contributes majority of revenue
-- Certain cities generate significantly higher sales
-- A few genres dominate customer purchases
-- Top artists account for most track sales
-- Monthly revenue shows variation indicating demand trends
