SELECT * FROM netflixdb.netflix_titles;
use netflixdb;
SELECT COUNT(*) FROM netflix_titles;
SELECT * FROM netflix_titles LIMIT 5;

SELECT
    SUM(director IS NULL) AS missing_director,
    SUM(country IS NULL) AS missing_country,
    SUM(rating IS NULL) AS missing_rating,
    SUM(date_added IS NULL) AS missing_date
FROM netflix_titles;
SET SQL_SAFE_UPDATES = 0;
UPDATE netflix_titles
SET director = 'Not Available'
WHERE director IS NULL;

UPDATE netflix_titles
SET country = 'Unknown'
WHERE country IS NULL;

SELECT title, COUNT(*)
FROM netflix_titles
GROUP BY title
HAVING COUNT(*) > 1;

DELETE t1
FROM netflix_titles t1
JOIN netflix_titles t2
ON t1.title = t2.title
AND t1.show_id > t2.show_id;

ALTER TABLE netflix_titles
MODIFY release_year INT;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT show_id) AS unique_titles
FROM netflix_titles;

#Movies and TV Show
SELECT 
    type, COUNT(*) AS total
FROM
    netflix_titles
GROUP BY type; 

#top 5 countries
SELECT 
    country, COUNT(*) AS total_count
FROM
    netflix_titles
GROUP BY country
ORDER BY total_count Desc
limit 5;

/*content by releasing */
SELECT release_year , COUNT(*) AS total_content
FROM netflix_titles
GROUP BY release_year
ORDER BY total_content DESC
limit 5;

#most common ratings 
SELECT 
    rating, COUNT(*) AS ratings
FROM
    netflix_titles
GROUP BY rating
ORDER BY ratings DESC;

#unique countries present
SELECT COUNT(DISTINCT country) AS total_countries
FROM netflix_titles;
use netflixdb;

#movies released after 2015
SELECT title, release_year
FROM netflix_titles
WHERE type ="movie"
AND release_year >2015;

#tv shows released before 2015
SELECT title, release_year
FROM netflix_titles
WHERE type ="TV Show"
AND release_year <2015;

#movies with more than 60min
select title,duration
from netflix_titles
where type = "movie"
and duration not like "60 min";

#which director has highly rated content
SELECT director,rating, COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director, rating
ORDER BY total_titles DESC;

#which director has most titles overall on netflix
SELECT director,COUNT(*) AS total_title
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_title DESC
LIMIT 10;
----- advanced questions----
#Top 5 genres over time (yearwise)
SELECT
    release_year,
    listed_in AS genre,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year, listed_in
ORDER BY total_titles DESC;
limit 10;

#rank director by number of titles
SELECT
    director,
    COUNT(*) AS total_titles,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS director_rank
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director;

#year wise growth percentage
select release_year,count(*)
 AS total_titles,
lag(count(*)) over (order by release_year)
 AS previous_year,
 round(count(*)-lag(count(*)) over (order by release_year)
 *100.0 / lag(count(*)) over (order by release_year),2)
AS growth_percentage
from netflix_titles
group by release_year
order by growth_percentage;

#year wise growth
SELECT
    release_year,
    COUNT(*) AS total_titles,
    LAG(COUNT(*)) OVER (ORDER BY release_year) AS previous_year_titles
FROM netflix_titles
GROUP BY release_year;




