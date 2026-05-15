select * from directors;
select * from movies;

# Can you get all data about movies? 
select * from movies;

# How do you get all data about directors?
select * from directors;

# Check how many movies are present in IMDB.
select count(distinct title) as movies_count from movies;
                  (or)
select count(*) as movies_count from movies;

# Find these 3 directors: James Cameron ; Luc Besson ; John Woo
select * from directors where name in ('James Cameron','Luc Besson','John Woo');

# Find all directors with name starting with S.
select * from directors where name like 's%';
                   (or)
select distinct name from directors where name like 's%';

# Count female directors.
Select count(*) from directors where gender=1;

# Find the name of the 10th first women directors?
Select name from directors where gender=1 
order by id asc limit 1 offset 9;

# What are the 3 most popular movies?
select original_title,popularity from movies 
order by popularity desc limit 3;

#What are the 3 most bankable movies?
select original_title,revenue from movies 
order by revenue desc limit 3;

# What is the most awarded average vote since the January 1st, 2000?
Select original_title,max(vote_average) as most_awarded_avg_vote from movies 
where release_date>'2000-01-01' group by original_title;

# Which movie(s) were directed by Brenda Chapman?
select m.original_title from movies as m 
join directors as d on d.id=m.director_id 
where name='Brenda Chapman';

# Which director is the most bankable?
select d.name,sum(m.revenue) as total_revenue from movies as m 
inner join directors as d on d.id=m.director_id 
group by d.name order by total_revenue desc limit 1;

# Movies Released per Year (Trend Analysis)
select year(release_date) as year,count(*) as movies from movies group by year order by year;

# Top 10 highest rated movies
select original_title as movie, vote_average from movies order by vote_average desc limit 10;

# Top 10 highest revenue movies
select original_title as movie,revenue from movies order by revenue desc limit 10;# l)	Which director made the most movies?

# Director With most movies
select d.name,count(m.id) as movies_count from movies as m 
inner join directors as d on d.id=m.director_id 
group by d.name order by movies_count desc;

# Director With Highest Average rating
select d.name,avg(m.vote_average) as average_rating
from movies as m inner join directors as d 
on m.director_id=d.id group by d.name 
order by average_rating desc;

# Movies with above average rating
select original_title,vote_average as above_avg_rating from movies where vote_average>(select avg(vote_average) from movies);

# Revenue Category
select original_title as movie ,revenue,
case 
     when revenue>1000000000 then 'Blockbuster'
     when revenue>500000000 then 'Super hit'
     when revenue>300000000 then 'Hit'
     else 'Average'
end as revenue_category
from movies;

# Revenue vs Rating
select vote_average ,avg(revenue) from movies group by vote_average order by vote_average desc;

# Movies Count by Director Gender
select d.gender,count(m.id) from movies as m inner join directors as d 
on m.director_id=d.id group by d.gender;

# Most Consistent Directors
select d.name,avg(m.vote_average) as average_rating,count(m.id) as movies_count from movies as m inner join directors as d
on m.director_id=d.id group by d.name having movies_count>=2 order by movies_count;

# Top Movie per year

SELECT m1.original_title,
       YEAR(m1.`release_date`) AS year,
       m1.`vote_average`
FROM movies m1
WHERE m1.`vote_average` = (
    SELECT MAX(m2.`vote_average`)
    FROM movies m2
    WHERE YEAR(m2.`release_date`) = YEAR(m1.`release_date`)
) order by year;

# Popularity vs Rating
SELECT `vote_average`,
       AVG(Popularity) AS avg_popularity
FROM movies
GROUP BY `vote_average`
ORDER BY `vote_average` DESC;