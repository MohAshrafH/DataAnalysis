/*
    This script demonstrates how to aggregate data from separate Excel files for each year
    (from 2015 to 2023) into a consolidated SQL table and then calculate the average metrics 
    for each country across all the years. The steps are as follows:

    1. Create a consolidated table (`Consolidated_Happiness`) to store data combined from all 
       individual year tables. This table will have data columns for each metric and an 
       additional column for `year`.
    2. Insert data from each year's table (e.g., `Happiness_2015`, `Happiness_2016`, etc.) 
       into the consolidated table, maintaining consistent structure and adding the 
       corresponding year value.
    3. Use SQL aggregation functions (like `AVG`) to compute the average values for each metric 
       across all years for each country.
*/

-- Step 1: Create the Consolidated Table
CREATE TABLE Consolidated_Happiness (
    country NVARCHAR(255),
    region NVARCHAR(255),
    happiness_score FLOAT,
    gdp_per_capita FLOAT,
    generosity FLOAT,
    social_support FLOAT,
    freedom_to_make_life_choices FLOAT,
    healthy_life_expectancy FLOAT,
    year INT
);

-- Step 2: Insert Data from Each Year's Table
INSERT INTO Consolidated_Happiness
SELECT country, region, happiness_score, gdp_per_capita, generosity, 
       social_support, freedom_to_make_life_choices, healthy_life_expectancy, 2015 
FROM Happiness_2015;

INSERT INTO Consolidated_Happiness
SELECT country, region, happiness_score, gdp_per_capita, generosity, 
       social_support, freedom_to_make_life_choices, healthy_life_expectancy, 2016 
FROM Happiness_2016;

-- Repeat the insert for all years up to 2023
INSERT INTO Consolidated_Happiness
SELECT country, region, happiness_score, gdp_per_capita, generosity, 
       social_support, freedom_to_make_life_choices, healthy_life_expectancy, 2023 
FROM Happiness_2023;

-- Step 3: Aggregate Data to Get the Averages Across Years
SELECT 
    country,
    AVG(happiness_score) AS happiness_score,
    AVG(gdp_per_capita) AS gdp_per_capita,
    AVG(generosity) AS generosity,
    AVG(social_support) AS social_support,
    AVG(freedom_to_make_life_choices) AS freedom_to_make_life_choices,
    AVG(healthy_life_expectancy) AS healthy_life_expectancy
FROM Consolidated_Happiness
GROUP BY country
ORDER BY happiness_score DESC;
