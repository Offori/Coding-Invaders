USE ci_p_3_sql;

-- Question 1

-- 1/1 point (graded)

-- Story: When we begin the exploratory data analysis, the first thing we do is go through all of the related tables. 

-- To start With, we will check how many different types of loans are given by the CI capital.

-- What are the different types of loans given by CI Capital?

-- Question: How many distinct loan types are given by CI Capital?

SELECT * FROM CI_loan;

SELECT COUNT(*)
FROM(
	SELECT DISTINCT loan_type
    FROM CI_loan
	)B;

-- Question 2

-- 1/1 point (graded)

-- Story: Companies should know the distribution of the different loans to find out the gaps 

-- so that they can target more where the loan has been given less than the actual target.

-- Find out the number of loans for each loan type.

-- Question: How many Auto loans for two-wheelers have been given?

SELECT * FROM CI_loan;

SELECT loan_type, COUNT(total_loans) AS number_loans 
FROM CI_loan 
WHERE loan_type='AL2'
GROUP BY loan_type;

-- Question 3
-- 1/1 point (graded)
-- Story: Age is a very important variable while giving out the loan. A younger applicant is considered to have more employment 
-- and earning opportunities against an older applicant. 
-- Therefore, if you are in your 20's, you are more eligible to get a personal loan of a longer 
-- tenure as compared to someone who is in the 50s. Let’s check the distribution of loans by age.

-- Find out the customers who are less than 30 years old and have taken loans?

-- Question: What is the age of account_no CI11?

SELECT * FROM CI_customer;

SELECT account_no, age 
FROM CI_customer
WHERE age<30 AND account_no='CI11';

-- Question 4
-- 1/1 point (graded)
-- Story: A credit score is a number between 300–850 that depicts a consumer's creditworthiness. 
-- The higher the score, the better a borrower looks to potential lenders. A credit score is based on credit history: number of open accounts, total levels of debt, and 
-- repayment history, and other factors. Let’s check the loan type which is in more risk due to low credit score?

-- How many loans have been given where credit score is less than 580 by different loan types?

-- Question: What is the minimum credit score for the Housing Loan?

SELECT * FROM CI_loan;

SELECT loan_type,
       Count(account_no) AS count_of_loans
FROM   CI_loan
WHERE  credit_score < 580
GROUP  BY loan_type;

SELECT COUNT(*)
FROM(
    SELECT *
    FROM   CI_loan
    WHERE  credit_score < 580
           AND loan_type ="hl"
    ORDER  BY credit_score)B;
    
-- Question 5

-- 1/1 point (graded)

-- Story: Even when a customer's credit score is high,Borrower can fall behind on loan repayments. We will investigate whether income plays a role in this phase.

-- Find out the average income of customers who have credit scores more than 700 and have been defaulted?

-- Question: What is the average annual income of the customers who have defaulted?

SELECT  b.if_default,
       Avg(annual_income) AS Average_annual_income
FROM    CI_customer a
       INNER JOIN CI_loan b
               ON a.account_no = b.account_no
WHERE   b.credit_score > 700
GROUP BY b.if_default;

-- Question 6

-- 1/1 point (graded)

-- Story: When conducting exploratory research, it is important to consider the relationship between variables in order 

-- to gain insights into how one variable follows the flow of another variable.

-- What is the average credit score by different marital status?

-- Question: What is the average credit score for widower?

SELECT  a.marital_status,
       Avg(b.credit_score) AS Average_credit_Score
FROM    CI_customer a
       INNER JOIN CI_loan b
               ON a.account_no = b.account_no
GROUP   BY a.marital_status; 

-- Question 7
-- 1/1 point (graded)
-- Story: Is education level important while giving out the loan? Let’s check the relation between the education level and loan defaulters?

-- How many customers have more than or equal to 5 defaults by different education levels?

-- Question: How many customers who are doing Masters education have been defaulted?

SELECT a.education_level,
       Sum(b.if_default) as default_count
FROM   CI_customer a
       INNER JOIN CI_loan b
              ON a.account_no = b.account_no
  GROUP  BY a.education_level
HAVING default_count >= 5;

-- Question 8

-- 1/1 point (graded)
-- Story: External factors such as the country's GDP and unemployment rate affects the loan demand. As a result, 
-- we must recognize this when developing new policies and rules for the business.

-- Create a report that shows the relationship between the number of loans granted for each month and respective unemployment rate. 
-- It should be sorted by unemployment rate, from lowest to highest.

-- Note: The CI_economics table has data from 2018 to 2020.

-- Report Should contain the following Columns in the same exact sequence:
-- Report_Month,
-- Real_GDP_in_Lakh_Crore,
-- unemp_rate,
-- Count of Loans

-- Question: What is the unemployment rate of the country in Feb 2019?

SELECT * FROM CI_economics

SELECT
 a.report_month,
       a.real_gdp_in_lakh_crore,
       a.Unemp_Rate,
       Count(b.account_no) AS count_of_loans
FROM  
 CI_economics a
       LEFT JOIN CI_loan b
              ON Year(a.report_month) = Year(b.start_date)
                 AND Month(a.report_month) = Month(b.start_date)
GROUP  
BY a.report_month,
          a.real_gdp_in_lakh_crore,
          a.Unemp_Rate
ORDER 
BY a.unemp_rate ASC
