/*   Course  SQL Module 4  Part 3. Table creation and Manipulation (DDL and DML statements)  CREATE statement
Assignment 2
0/1 point (graded)
Create a table with name ‘Continent_vaccination’ with fields continent, total vaccinations, people_vaccinated. 
Use aggregate functions to roll up the data at continent level. What is the number of total people vaccinated in Asia?

Instructions:

1. Create a table with name ‘Content_vaccination’ by aggregating fields total_vaccinations and people_vaccinated at continent level
2. Write a query to filter the data for Asia*/
USE SQL_MODULE_3;

SELECT * FROM VACCINATIONS;

CREATE TABLE CONTINENT_VACCINATION 
	(	CONTINENT TEXT,
		TOTAL_VACCINATIONS INT,
        PEOPLE_VACCINATED INT);
 
 /* SHOWS DATA TYPES */
SHOW COLUMNS FROM VACCINATIONS FROM SQL_MODULE_3;

/* INSERT VALUES FROM ANOTHER TABLE(VACCINATIONS) INTO CONTINENT_VACCINATION */
SELECT * FROM CONTINENT_VACCINATION;
SELECT * FROM VACCINATIONS;

INSERT INTO CONTINENT_VACCINATION (continent, total_vaccinations, people_vaccinated)
SELECT continent, total_vaccinations, people_vaccinated
FROM VACCINATIONS;
/*DELETE ALL FIELDS IN A TABLE*/

DELETE FROM CONTINENT_VACCINATION;

SELECT * FROM CONTINENT_VACCINATION;

/*  ROLL UP*/

SELECT 
    CONTINENT, TOTAL_VACCINATIONS, PEOPLE_VACCINATED
FROM
    CONTINENT_VACCINATION
GROUP  BY CONTINENT WITH ROLLUP;


/*correct Assignment 2*/ 

CREATE TABLE continent_vaccination_correct
  (SELECT continent,
          Sum(total_vaccinations) AS total_vaccinations,
          Sum(people_vaccinated)  AS people_vaccinated
   FROM   `vaccinations`
   GROUP  BY continent); 
SELECT *
FROM   `continent_vaccination_correct`
WHERE  continent = 'Asia';

/* Course  SQL Module 4  Part 3. Table creation and Manipulation (DDL and DML statements)  UPDATE statement*/

/* Assignment 1
1/1 point (graded)
Update the field total_vaccinations_per_hundred to 1 where the total_vaccinations_per_hundred value is less than 1. Please enter the number of rows affected in the answer.

Instructions:

1. Use the Update statement on the table vaccinations
2. Set the value of the mentioned column to 1
3. Add the filter where the mentioned column is less than 1*/

UPDATE VACCINATIONS_UPDATE
SET total_vaccinations_per_hundred = 1
WHERE total_vaccinations_per_hundred < 1;

SELECT total_vaccinations_per_hundred 
FROM VACCINATIONS_UPDATE;

/* Assignment 2
1/1 point (graded)
Update the field total_vaccinations to 50000 if the value is less than 50000. Please enter the number of rows affected as the answer.

Instructions:

1. Use the Update statement on the table vaccinations
2. Set the value of the mentioned column to 50000
3. Add the filter where the mentioned column is less than 50000*/

UPDATE VACCINATIONS_UPDATE
SET total_vaccinations = 50000
WHERE total_vaccinations < 50000;

SELECT COUNT(*) 
FROM VACCINATIONS_UPDATE
WHERE total_vaccinations = 50000;

/* Course  SQL Module 4  Part 3. Table creation and Manipulation (DDL and DML statements)  ALTER Statement*/

/* Assignment 1
1/1 point (graded)
Add column people_fully_vaccinated in the table vaccinations. Then Update the column with the values. People_fully_vaccinated = total_vaccinations - people_vaccinated. How many people are fully vaccinated in ‘India’

Instructions:

1. Use Alter statement on the table vaccinations
2. Add the mentioned column name along with its data type
3. As both the numbers are integer, the subtraction will be integer as well
4. Select the row from the table where country is ‘India’*/

USE SQL_MODULE_3;

SHOW COLUMNS FROM VACCINATIONS_UPDATE FROM SQL_MODULE_3;

ALTER TABLE VACCINATIONS_UPDATE
ADD people_fully_vaccinated INT;

UPDATE VACCINATIONS_UPDATE
SET people_fully_vaccinated = total_vaccinations - people_vaccinated;

SELECT people_fully_vaccinated 
FROM VACCINATIONS_UPDATE
WHERE COUNTRY = "INDIA";

/* Assignment 2
0/1 point (graded)
Add column vaccines_per_person in the table continent_vaccination. Then Update the column with the values. 
vaccines_per_person = total_vaccinations/people_vaccinated. What is the vaccines_per_person for 
the continent Europe?*/

USE SQL_MODULE_3;

SHOW COLUMNS FROM VACCINATIONS_UPDATE FROM SQL_MODULE_3;

ALTER TABLE VACCINATIONS_UPDATE
ADD vaccines_per_person INT;

/* CHANGE DATA TYPE */
ALTER TABLE VACCINATIONS_UPDATE 
MODIFY COLUMN vaccines_per_person FLOAT;

UPDATE VACCINATIONS_UPDATE
SET vaccines_per_person = total_vaccinations/people_vaccinated;

SELECT COUNT(*)
FROM(SELECT CONTINENT, vaccines_per_person
FROM VACCINATIONS_UPDATE
WHERE CONTINENT = "EUROPE") B;


/* Course  SQL Module 4  Part 3. Table creation and Manipulation (DDL and DML statements)  DELETE statement*/

/* Assignment 1
0/1 point (graded)
Delete rows from the table continent_vaccination where people_vaccinated are less than 1 million. Please enter the number of rows deleted as the answer.

Instructions:

1. Use Delete statement
2. Put a where condition that people vaccinated are less than 1 million*/

USE SQL_MODULE_3;

DELETE FROM VACCINATIONS_UPDATE
WHERE people_vaccinated < 1000000;
/*  Course  SQL Module 4  Part 4. Capstone project Module 4  Project (Unguided)*/

SELECT * FROM IMDB_MOVIES;

/* Assignment 1
0/1 point (graded)
What is the revenue contribution of ‘The Avengers’ in the genre ‘Action’ in the year 2012? (Answer with % sign)
Hint (1 of 1): 1. Use subquery in select to calculate total revenue of genre ‘Action’ in the year 2012
2. Select and filter movie ‘The Avengers’ and calculate the % revenue
*/
USE SQL_MODULE_3;
SELECT * FROM IMDB_MOVIES;

/* search by beginning of a word*/
SELECT TITLE FROM IMDB_MOVIES WHERE TITLE LIKE "AVE%";

SELECT REVENUE_MILLIONS*100/(SELECT SUM(REVENUE_MILLIONS) 
								FROM IMDB_MOVIES 
                                WHERE GENRE = "ACTION" AND YEAR = "2012") AS PERC_REVENUE_ACTION_2012
FROM IMDB_MOVIES
WHERE TITLE ="The Avengers";

SELECT title,
       revenue_millions * 100 / (SELECT Sum(revenue_millions)
                                 FROM   imdb_movies
                                 WHERE  genre = 'Action'
                                        AND year = 2012) AS perc_revenue
FROM   imdb_movies
WHERE  title = 'The Avengers';

USE SQL_MODULE_3;

/* Assignment 2
1 point possible (graded)
What is the revenue contribution of the genre ‘Comedy’ of total revenue in the year 2016? (Answer with % sign) 
Hint (1 of 1): Hint:
1. Use subquery in select to calculate total revenue of the year 2016
2. Use aggregate function to calculate total revenue of the genre ‘Comedy’
3. Select and filter the genre ‘Comedy’ and calculate the % revenue

Hint: Use subquery in select to calculate total revenue of the year 2016
Use aggregate function to calculate total revenue of the genre ‘Comedy’
Select and filter the genre ‘Comedy’ and calculate the % revenue
query was wrong please try with the following hints*/

SELECT * FROM IMDB_MOVIES;

SELECT genre,
       Sum(revenue_millions) * 100 / (SELECT Sum(revenue_millions)
                                      FROM   imdb_movies
                                      WHERE  year = 2016) AS perc_revenue
                                       FROM   imdb_movies
WHERE  genre = 'Comedy'
       AND year = 2016; 
                                        
/* Assignment 3
1 point possible (graded)
How many movies have rating more than 8 in genre ‘Action’?

Hint (1 of 1): Hint:
1. Use subquery to filter the data for genre and rating
2. Use select within FROM clause to count number of rows*/

USE SQL_MODULE_3;

SELECT * FROM IMDB_MOVIES;

SELECT COUNT(*)
FROM (	SELECT GENRE
		FROM IMDB_MOVIES
		WHERE GENRE = "ACTION" AND RATING > 8) AS SUBQUERY;

SELECT COUNT(*)
FROM IMDB_MOVIES
WHERE GENRE = "ACTION" AND RATING > 8;

SELECT Count(*)
FROM  (SELECT *
       FROM   imdb_movies
       WHERE  rating > 8
         AND genre = 'Action') A;

/* Assignment 4
1 point possible (graded)
How many movies have revenue higher than 100 million
Hint (1 of 1): Hint:
1. FIlter the data for revenue greater than 100 million
2. Use select within FROM clause to count number of movies*/

SELECT * FROM IMDB_MOVIES;

SELECT COUNT(*)
FROM (	SELECT REVENUE_MILLIONS
		FROM IMDB_MOVIES
        WHERE REVENUE_MILLIONS > 100) AS REVENUE_MILLIONS_100;
        
/* Assignment 5
1 point possible (graded)
How many movies have revenue greater than every movie of the ‘Adventure’ genre? 
Hint (1 of 1): Hint:
1. Use subquery in WHERE clause such that it returns maximum revenue of genre ‘Adventure’
2. Apply filter that revenue is greater than the maximum revenue of ‘Adventure’
3. Use outer query to count number of movies*/

USE SQL_MODULE_3;

SELECT COUNT(*)
FROM IMDB_MOVIES
WHERE REVENUE_MILLIONS > (	SELECT MAX(REVENUE_MILLIONS) 
							FROM IMDB_MOVIES
                            WHERE GENRE = "ADVENTURE");
                            
USE SQL_MODULE_3;

/* Assignment 6
1 point possible (graded)
How many movies have ratings greater than every movie in the year 2015? 
Hint (1 of 1): Hint:
1. Use subquery in WHERE clause such that it returns maximum rating of the year 2015
2. Apply filter that rating is greater than the maximum rating of 2015
3. Use outer query to count number of movies*/

SELECT COUNT(*)
FROM IMDB_MOVIES
WHERE RATING > (SELECT MAX(RATING) FROM IMDB_MOVIES WHERE YEAR = "2015");

/* 	Assignment 7
1 point possible (graded)
What is the minimum revenue corresponding to a movie such that its 
rating is higher than all the movies in the year 2015 and its revenue is greater than all the movies 
in the genre ‘Comedy’?
Hint (1 of 1): Hint:
1. Filter the table using two subqueries
2. Ratings should be higher than maximum rating in the year 2015
3. Revenue should be greater than the maximum revenue of the movie in the genre ‘Comedy’
4. Select the minimum of revenue*/

USE SQL_MODULE_3;

SELECT YEAR FROM IMDB_MOVIES;

SELECT REVENUE_MILLIONS
FROM IMDB_MOVIES
WHERE RATING > (SELECT MAX(RATING)	FROM IMDB_MOVIES WHERE YEAR = "2015") 
		AND REVENUE_MILLIONS > (SELECT MAX(REVENUE_MILLIONS)	FROM IMDB_MOVIES WHERE GENRE = "COMEDY")
ORDER BY REVENUE_MILLIONS ASC;

USE SQL_MODULE_3;

/* Assignment 8
1 point possible (graded)
What is the maximum revenue corresponding to a movie such that its rating 
is higher than all the movies in the year 2016 and its revenue is greater than all the movies in 
the genre ‘Adventure’?
Hint (1 of 1): Hint:
1. Filter the table using two subqueries
2. Ratings should be higher than maximum rating in the year 2016
3. Revenue should be greater than the maximum revenue of the movie in the genre ‘Animation’
4. Select the maximum of revenue*/

SELECT REVENUE_MILLIONS
FROM IMDB_MOVIES
WHERE RATING > (SELECT MAX(RATING)	FROM IMDB_MOVIES WHERE YEAR = "2016") 
		AND REVENUE_MILLIONS > (SELECT MAX(REVENUE_MILLIONS)	FROM IMDB_MOVIES WHERE GENRE = "ANIMATION")
ORDER BY REVENUE_MILLIONS DESC;

/* Assignment 9
1 point possible (graded)
How many movies contribute to more than 10% of revenue to the total revenue of all movies in a year? 
Hint (1 of 1): Hint:
1. Use a self join to map total revenue of each year to the movie
2. Calculate the % revenue and apply filter of greater than 10%
3. Use outer query to count number of movies*/

USE SQL_MODULE_3;

SELECT YEAR, REVENUE_MILLIONS*10/(SELECT SUM(REVENUE_MILLIONS)
							FROM IMDB_MOVIES) AS PERC_REVENUE_MILLIONS
FROM IMDB_MOVIES
WHERE REVENUE_MILLIONS*10/(SELECT SUM(REVENUE_MILLIONS)
							FROM IMDB_MOVIES) > 10;
                            
/* Assignment 10
1 point possible (graded)
How many movies contribute to more than 5% of revenue to the total revenue of all movies in their respective genre?
Hint (1 of 1): Hint:
1. Use a self join to map total revenue of each year to the movie
2. Calculate the % revenue and apply filter of greater than 5%
3. Use outer query to count number of movies*/

SELECT YEAR, REVENUE_MILLIONS*10/(SELECT SUM(REVENUE_MILLIONS)
							FROM IMDB_MOVIES) AS PERC_REVENUE_MILLIONS
FROM IMDB_MOVIES
WHERE REVENUE_MILLIONS*10/(SELECT SUM(REVENUE_MILLIONS)
							FROM IMDB_MOVIES) > 5;
                            
/* Assignment 11
1 point possible (graded)
Create a table ‘top_movies’ which contains all the columns from the table ‘imdb_movies’ 
but has data only for movies with revenue greater than 100 million and rating higher than 7. What is the number 
of rows in this new table? */

USE SQL_MODULE_3;

CREATE TABLE TOP_MOVIES
	AS SELECT *
    FROM IMDB_MOVIES
    WHERE REVENUE_MILLIONS > 100 AND RATING > 7;

SELECT * FROM IMDB_MOVIES;

/* Assignment 13
1 point possible (graded)
Modify the ratings column in 
the table ‘imdb_movies’ and set the value to 5 if the rating is below 5. 
What is the number of rows that are modified?*/

CREATE TABLE IMDB_MOVIES_INSERT_VALUES
	AS SELECT * 
		FROM IMDB_MOVIES;
        
INSERT INTO IMDB_MOVIES_INSERT_VALUES
            (id,
             title,
             genre,
             year,
             rating,
             votes,
             revenue_millions)
VALUES     (1001,
            'Tenet',
            'Action',
            2020,
            7.5,
            316882,
            364.2);

UPDATE IMDB_MOVIES_INSERT_VALUES
SET RATING = 5
WHERE RATING < 5;

/*Assignment 14
1 point possible (graded)
Add a column ‘total_rating’ 
in the table ‘imdb_movies’. Set the values of this newly added column as Rating*votes. 
What is the highest total rating in the year 2016?*/

SHOW COLUMNS FROM IMDB_MOVIES_INSERT_VALUES FROM SQL_MODULE_3;

ALTER TABLE IMDB_MOVIES_INSERT_VALUES
ADD TOTAL_RATING DOUBLE;

UPDATE IMDB_MOVIES_INSERT_VALUES
SET TOTAL_RATING = RATING*VOTES;

SELECT TOTAL_RATING 
FROM IMDB_MOVIES_INSERT_VALUES
WHERE RATING > (SELECT MAX(RATING) FROM IMDB_MOVIES_INSERT_VALUES WHERE YEAR = 2016);

SELECT TOTAL_RATING 
FROM IMDB_MOVIES_INSERT_VALUES
WHERE YEAR = "2016"
ORDER BY RATING DESC LIMIT 1;

USE SQL_MODULE_3;

/* Assignment 15
1 point possible (graded)
Delete rows from the table ‘imdb_movies’ where rating is less than 2 or 
revenue is less than 20 million. How many rows were deleted?*/

CREATE TABLE IMDB_MOVIES_DELETE_VALUES
AS	SELECT *
	FROM IMDB_MOVIES_INSERT_VALUES;

DELETE FROM IMDB_MOVIES_INSERT_VALUES
WHERE RATING < 2 OR REVENUE_MILLIONS < 20;

CREATE TABLE IMDB_MOVIES_DELETE_VALUES_FROM_IMDBMOVIES
AS	SELECT *
	FROM IMDB_MOVIES_INSERT_VALUES;

DELETE FROM IMDB_MOVIES_DELETE_VALUES_FROM_IMDBMOVIES
WHERE RATING < 2 OR REVENUE_MILLIONS < 20;

/*Assignment 16
1 point possible (graded)
Which movie has the highest ratio of (revenue/total_rating)? Use modified data.*/

SELECT TITLE 
FROM IMDB_MOVIES_INSERT_VALUES
WHERE REVENUE_MILLIONS/TOTAL_RATING > ( SELECT MAX(REVENUE_MILLIONS/TOTAL_RATING) FROM IMDB_MOVIES_INSERT_VALUES);

SELECT TITLE, REVENUE_MILLIONS/TOTAL_RATING AS RATIO_REVENUE_RATING
FROM IMDB_MOVIES_INSERT_VALUES
GROUP BY TITLE 
ORDER BY REVENUE_MILLIONS/TOTAL_RATING DESC LIMIT 1;

/* Assignment 17
1 point possible (graded)
What is the avg rating for the genre ‘Action’ in the year 2015? Use modified data on the local server.*/

SELECT AVG(RATING)
FROM IMDB_MOVIES_INSERT_VALUES
WHERE GENRE = "ACTION" AND YEAR = "2015";

USE SQL_MODULE_5;

/* Course  SQL Module 5  Part 1. Windows functions  Rank() over partition by*/

CREATE DATABASE SQL_MODULE_5;

/* Assignment 1
1 point possible (graded)
Create a report where all the countries are ranked based on total_vaccinations in their respective continent. 
What is the rank of ‘Belgium’ in Europe?
Hint (1 of 1): Instructions:

1. Use Rank() over partition by statement to rank on the metric total_vaccinations in descending order
2. Partitioning would be on continent
3. Select fields country,continent, total_vaccinations
4. Use outer query to select and filter for country ‘Belgium’*/
/*MY CODE*/
SELECT * FROM VACCINATIONS;

SELECT CONTINENT, COUNTRY, total_vaccinations,
         rank() OVER (partition BY CONTINENT ORDER BY total_vaccinations DESC) AS RANK_CUNTRIES_total_vaccinations
			FROM     VACCINATIONS 
			WHERE CONTINENT = "EUROPE";

/* EXPECTED CODE*/

SELECT *
FROM   (SELECT country,
               continent,
               total_vaccinations,
               Rank()
                 OVER (
                   partition BY continent
                   ORDER BY total_vaccinations DESC) AS RANK_CUNTRIES_total_vaccinations
        FROM   vaccinations) A
WHERE  country = 'Belgium';

/* Assignment 2
1 point possible (graded)
Create a report where all 
the countries are ranked based on 
people_vaccinated in their respective continent. What is the rank of ‘Malaysia’ in Asia?*/

USE SQL_MODULE_5;

SELECT *
FROM(
	SELECT CONTINENT, COUNTRY, PEOPLE_VACCINATED, 
		RANK()
			OVER(
				PARTITION BY CONTINENT
				ORDER BY PEOPLE_VACCINATED DESC) AS RANK_CUNTRIES_PEOPLE_VACCINATED
	FROM VACCINATIONS) B
    WHERE COUNTRY = "Malaysia";
    
    /* Course  SQL Module 5  Part 1. Windows functions  Sum() over partition by*/
    
    /* Assignment 1
1 point possible (graded)
Compute the percentage of total_vaccinations of each country in their 
respective continents. Which country has the highest contribution % to the total_vaccinations of 
their respective continents?
Hint (1 of 1): Instructions:

1. Use aggregate function SUM() on total_vaccinations over the partition continent
2. Select country, continent, total_vaccinations fields
3. Select all the fields in outer query and compute percentage
4. Order the output by percentage in descending order in outer query*/

USE sql_module_5;

SELECT CONTINENT, COUNTRY, TOTAL_VACCINATIONS, TOTAL_VACCINATIONS*100/TOTAL_PARTION_TOTAL_VACCINATION
FROM(SELECT 	COUNTRY, CONTINENT, TOTAL_VACCINATIONS, 
		SUM(TOTAL_VACCINATIONS)
			OVER( 
				PARTITION BY CONTINENT ORDER BY TOTAL_VACCINATIONS DESC)AS TOTAL_PARTION_TOTAL_VACCINATION 
		FROM VACCINATIONS) B;
        
/* Assignment 2
1 point possible (graded)
Compute the percentage of people_vaccinated of each country in their respective continents. Which country 
has the lowest contribution % to the total_vaccinations of their respective 
continents? (% contribution should be greater than 0)
Hint (1 of 1): Instructions:

1. Use aggregate function SUM() on people_vaccinated over the partition continent
2. Select country, continent, people_vaccinated fields
3. Select all the fields in outer query and compute percentage
4. Order the output by percentage in ascending order in outer query
5. Look for the first non-zero value and enter the corresponding country*/

USE SQL_MODULE_5;

SELECT CONTINENT, COUNTRY, PEOPLE_VACCINATED, PEOPLE_VACCINATED*100/TOTAL_PATITION_PEOPLE_VACCINATED AS PERC_PEOPLE_VACCINATED
FROM(	SELECT CONTINENT, COUNTRY, PEOPLE_VACCINATED,
			SUM(PEOPLE_VACCINATED)
				OVER(PARTITION BY CONTINENT) AS TOTAL_PATITION_PEOPLE_VACCINATED
		FROM VACCINATIONS) B
WHERE PEOPLE_VACCINATED <> 0
ORDER BY PERC_PEOPLE_VACCINATED ASC;

/* Course  SQL Module 5  Part 2. CONTROL FLOW FUNCTIONS  CASE STATEMENT*/

/* Assignment 1
1 point possible (graded) 
Segment the countries based on the below criteria using CASE WHEN
Total_vaccinations_per_hundred greater than 15 : On-track
Total_vaccinations_per_hundred between 5 and 15 : Need improvement
Total_vaccinations_per_hundred less than 5: Poor
How many people were vaccinated fully including all countries in the segment ‘On-track’?
Hint (1 of 1): Instructions:
1. Use CASE WHEN statement tag the progress of countries as mentioned in the question
2. In the outer query use the aggregate function SUM to find total people_vaccinated
3. Use grouping based on new column created using CASE WHEN*/

SELECT CONTINENT, COUNTRY, SUM(people_vaccinated), Total_vaccinations_per_hundred_CONDITIONS
FROM(SELECT *,
			CASE
				WHEN Total_vaccinations_per_hundred > 15 THEN "On-track"
				WHEN Total_vaccinations_per_hundred BETWEEN 5 AND 15 THEN "Need improvement"
				WHEN Total_vaccinations_per_hundred < 5 THEN "POOR"
			END AS Total_vaccinations_per_hundred_CONDITIONS
		FROM   VACCINATIONS) B
WHERE Total_vaccinations_per_hundred_CONDITIONS = "On-track"
GROUP BY Total_vaccinations_per_hundred_CONDITIONS; 

USE SQL_MODULE_5;

/* Assignment 2
1 point possible (graded)
Segment the countries based on the below criteria using CASE WHEN
People_vaccinated_per_hundred greater than 10 : On-track
People_vaccinated_per_hundred between 5 and 10 : Need improvement
People_vaccinated_per_hundred less than 5: Poor

What is the total_vaccinations for all the countries in the ‘Poor’ segment?
Hint (1 of 1): Instructions:
1. Use CASE WHEN statement tag the progress of countries as mentioned in the question
2. In the outer query use the aggregate function SUM to find total people_vaccinated
3. Use grouping based on new column created using CASE WHEN*/
USE SQL_MODULE_5;

SELECT Total_vaccinations_per_hundred_CONDITIONS, SUM(total_vaccinations) AS SUM_PEOPLE_VACCINATED 
FROM(SELECT *,
			CASE
				WHEN Total_vaccinations_per_hundred > 10 THEN "On-track"
				WHEN Total_vaccinations_per_hundred BETWEEN 5 AND 10 THEN "Need improvement"
				WHEN Total_vaccinations_per_hundred < 5 THEN "POOR"
			END AS Total_vaccinations_per_hundred_CONDITIONS
		FROM   VACCINATIONS) B
GROUP BY Total_vaccinations_per_hundred_CONDITIONS;

/* EXPECTED */

SELECT progress,
       Sum(total_vaccinations) AS total_people_vaccinated
FROM   (SELECT country,
               continent,
               total_vaccinations,
               CASE
                 WHEN people_vaccinated_per_hundred > 10 THEN 'On-track'
                 WHEN people_vaccinated_per_hundred BETWEEN 5 AND 10 THEN 'Need Improvement'
                 WHEN people_vaccinated_per_hundred < 5 THEN 'Poor'
               END AS Progress
        FROM   vaccinations) A
GROUP  BY progress;

/* Course  SQL Module 5  Part 2. CONTROL FLOW FUNCTIONS  IF STATEMENT*/

/*  Assignment 1
1 point possible (graded)
Assign the value ‘Single dose’ if the total_vaccinations is equal to people_vaccinated and assign 
the ‘Double dose’ if people_vaccinated is less than total_vaccinations else assign ‘Unknown’

How many countries are still in the ‘Single dose’ phase?*/
USE SQL_MODULE_5;
SELECT * FROM VACCINATIONS;
SELECT COUNT(*)
FROM(	SELECT *, 
			IF(total_vaccinations = people_vaccinated, "SINGLE DOSE", 
				IF(people_vaccinated < total_vaccinations, "DOUBLE DOSE", "UNKNOWN")) AS TOTAL_VACCINATION_POSITION
		FROM VACCINATIONS) A
WHERE TOTAL_VACCINATION_POSITION = "SINGLE DOSE";

/*Assignment 2
1 point possible (graded)
What is the total daily_vaccinations 
including all countries? Consider only those countries which have daily_vaccinations greater than 10000. 
Use IF statement.
Hint (1 of 1): Instructions:
1. Use IF function inside SUM function. This is similar to the SUMIF function in Excel.
2. Give the appropriate condition that daily_vaccinations is greater than 10000
3. If the condition is true then daily_vaccinations else 0*/
USE SQL_MODULE_5;

SELECT * FROM VACCINATIONS;

/* expected */

/* WORK PERFECTLY ON BENCH */

select  SUM(IF( daily_vaccinations >10000 , daily_vaccinations,0)) AS SUM_DAILY_VACCINATION_GREATER_10000
from vaccinations;

select  SUM(IF( daily_vaccinations >10000 , daily_vaccinations,0)) from vaccinations;


/* Course  SQL Module 5  Part 3. HANDLING NULL VALUES  IS NULL and IS NOT NULL Example*/

/* Assignment 1
1 point possible (graded)
How many countries have NULL values in the field people_vaccinated?*/

USE SQL_MODULE_5;
SELECT * FROM VACCINATIONS;


/* WORK PERFECTLY ON METABASE NOT MYSQL WORKBENCH*/

 
SELECT COUNT(*) AS NO_NULL_VALUE_PEOPLE_VACCINATED
FROM(SELECT COUNTRY, people_vaccinated
FROM VACCINATIONS
WHERE people_vaccinated IS NULL) TABLE_people_vaccinated_IS_NULL;

/*EXPECTED*/

SELECT Count(*)
FROM   vaccinations
WHERE  people_vaccinated IS NULL;

/* Assignment 2
1 point possible (graded)
What is the overall total_vaccinations done by all countries excluding the countries 
where people_vaccinated is NULL?
Hint (1 of 1): Instructions:
1. Use aggregate function SUM() on the field total_vaccinations
2. Add a filter where mentioned field in the question is not NULL
*/

SELECT COUNTRY, SUM(TOTAL_VACCINATIONS) AS OVERALL_CONTRIBUTIONS
FROM VACCINATIONS
WHERE people_vaccinated IS NOT NULL;

/* Course  SQL Module 5  Part 3. HANDLING NULL VALUES  IFNULL() and COALESCE()*/

/* Assignment 1
1 point possible (graded)
Assign value of total_vaccinations to the field people_vaccinated 
where the value is NULL. What is the total people_vaccinated including all countries? (Use IFNULL)
 Use IFNULL function in the sum function to select people_vaccinated
2. If the people_vaccinated is NULL, then give total_vaccinations*/




/* Course  Project 3 - SQL  SQL Project 1 Task  Task */

/* Question 1
1 point possible (graded)
Story: When we begin the exploratory data analysis, the first thing we do is go through all of 
the related tables. To start With, we will check how many different types of loans are given by the CI capital.

What are the different types of loans given by CI Capital?

Question: How many distinct loan types are given by CI Capital?

Hint (1 of 1): Use Distinct*/
USE SQL_MODULE_5;

