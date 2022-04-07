# Analysis
- Percentage of vaccinated populations in all areas across world

# Data Source
- COVID-19 Deaths data source : https://ourworldindata.org/covid-deaths.

# Cleaning and manipulation
- Used EXCEL to divide the table into covid_deaths and covid_vaccination for proper analysis.

# Tools
- [DBeaver 22.0.2](https://dbeaver.io/download/), Can use any server like mysql, Microsoft SQL, postgre SQL,SQLite, Oracle and many more, whichever you are comfortable with.

# SQL tactics 
- Updated the column type for some of columns

# Steps
All sql queries and steps are jotted down via comments but some stuff that I did which could help you
- I first selected the data on which I wanted to do analysis on like location,date,population,total_cases,total_deaths from the covid_deaths table.
- Started looking at total_cases vs total_deaths by using the percent formula. After that I was looking at the total_cases vs the population for each location(country), again by using the percent formula, you also use where statement to only look for the particular country.
- Further I was able to know the countries with the highest infection rate compared to the population and also the highest death count for each continent, using group by and order by helps give the proper view of the table.
- After that I jumped on to the next table covid_vaccination where I first analysed the total population vs vaccinations. I used the window function for seeing rolling count increasing and used the CTE for getting the percentage of vaccinated population. There is one more option we can use instead of CTE, we can use temp table for the same.
- At last I created a view for the percent of vaccinated population for easy visualization in tableau.
