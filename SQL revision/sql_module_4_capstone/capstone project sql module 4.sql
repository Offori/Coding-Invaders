use ci_sql4;

-- Assignment 1
-- 1/1 point (graded)
-- What is the revenue contribution of ‘The Avengers’ in the genre ‘Action’ in the year 2012? (Answer without % sign)

select * from imdb_movies;
SELECT title,
       revenue_millions * 100 / (SELECT Sum(revenue_millions)
                                 FROM   imdb_movies
                                 WHERE  genre = 'Action'
                                        AND year = 2012) AS perc_revenue
FROM   imdb_movies
WHERE  title = 'The Avengers';

-- Assignment 2
-- 1/1 point (graded)
-- What is the revenue contribution of the genre ‘Comedy’ of total revenue in the year 2016? (Answer it without % sign)

SELECT genre,
       Sum(revenue_millions) * 100 / (SELECT Sum(revenue_millions)
                                      FROM   imdb_movies
                                      WHERE  year = 2016) AS perc_revenue
FROM   imdb_movies
WHERE  genre = 'Comedy'
       AND year = 2016;
       
-- Assignment 3
-- 1/1 point (graded)
-- Which genre has the highest revenue collection for the last 3 years? Enter its revenue.

SELECT Max(A.tot_revenue)
FROM   (SELECT genre,
               Sum(revenue_millions) AS tot_revenue
        FROM   imdb_movies
        WHERE  year IN ( 2014, 2015, 2016 )
        GROUP  BY genre) AS A;
        
-- Assignment 4
-- 1/1 point (graded)
-- Find out the the director who has highest average rating of his/her movies. Enter the rating.

SELECT Max(A.avg_rating)
FROM   (SELECT director,
               Avg(rating) AS avg_rating
        FROM   imdb_movies
        GROUP  BY director) AS A;
        
-- Assignment 5
-- 1/1 point (graded)
-- How many movies have revenue greater than highest movie revenue of the ‘Adventure’ genre?

SELECT Count(*)
       FROM   imdb_movies
       WHERE  revenue_millions > (SELECT Max(revenue_millions)
                                  FROM   imdb_movies
                                  WHERE  genre = 'Adventure');
                                  
-- Assignment 6
-- 1/1 point (graded)
-- How many movies have ratings greater than highest movie rating of the year 2015?

-- Assignment 7
-- 1/1 point (graded)
-- What is the minimum revenue corresponding to a movie such that its rating is higher than highest 
-- movie rating of the year 2015 and its revenue is greater than highest movie revenue of the ‘Comedy’ genre?

SELECT Min(revenue_millions)
FROM   imdb_movies
WHERE  rating > (SELECT Max(rating)
                 FROM   imdb_movies
                 WHERE  year = 2015)
       AND revenue_millions > (SELECT Max(revenue_millions)
                               FROM   imdb_movies
                               WHERE  genre = 'Comedy');
                               
-- Assignment 8
-- 1/1 point (graded)
-- How many movies contribute more than 10% of revenue to the total revenue of all movies in a year?

SELECT Count(*)
FROM   (SELECT title,
               ( revenue_millions * 100 / tot_revenue ) AS perc_revenue
        FROM   imdb_movies A
               INNER JOIN (SELECT year,
                                  Sum(revenue_millions) AS tot_revenue
                           FROM   imdb_movies
                           GROUP  BY year) b
                       ON A.year = b.year
        WHERE  ( revenue_millions * 100 / tot_revenue ) > 10) C;
        
-- Assignment 9
-- 0/1 point (graded)
-- How many movies contribute more than 5% of revenue to the total revenue of all movies 
-- in their respective genre?

select * from imdb_movies;

select count(*)
from(
		select Title, (Revenue_millions*100)/total_rev as perc_rev
		from imdb_movies a 
			inner join (select Year, sum(Revenue_millions) as total_rev
						from imdb_movies
						group by ID
						) b
			on a.year=b.year
		where (Revenue_millions*100)/total_rev>5
	)b;
        