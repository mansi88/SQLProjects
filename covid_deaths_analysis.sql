USE portfolio_project;

SELECT *
FROM covid_deaths_csv
WHERE continent is not null

/*Lookig at total cases vs total deaths*/

SELECT DISTINCT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS deathpercentage
FROM covid_deaths_csv
WHERE location LIKE '%States%'
AND continent is not null; 
 
/*looking at total cases vs population*/

SELECT DISTINCT location,date,population,total_cases,(total_cases/population)*100 AS percentofpopulationinfected
FROM covid_deaths_csv
WHERE continent is not null
/*WHERE location LIKE '%States%'*/

/*looking at countries with highest infection rate compared to population*/
SELECT DISTINCT location,population,MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100 AS percentofpopulationinfected
FROM covid_deaths_csv
WHERE continent is not null
GROUP BY location, population 
ORDER BY HighestInfectionCount DESC

/*showing continent with highest death count per population*/

SELECT continent, MAX(cast(total_deaths AS SIGNED integer)) AS TotalDeathCount
FROM covid_deaths_csv
WHERE continent IS not NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

SELECT sum(new_cases) AS total_cases, Sum(new_deaths) AS total_deaths, Sum(new_deaths)/sum(new_cases)*100 AS deathpercentage
FROM covid_deaths_csv
WHERE continent IS NOT NULL 

/*looking at total population vs vaccination*/

WITH popvsvac AS (
	SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,SUM(v.new_vaccinations)OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS RollingPeopleVaccination
	FROM covid_deaths_csv AS d
	JOIN vaccines AS v 
	ON d.location = v.location
	AND d.date = v.date		
	WHERE d.continent is not null
	LIMIT 10000
)

SELECT *, (RollingPeopleVaccination/population)*100
FROM popvsvac

/*TEMP TABLE*/

DROP TABLE IF EXISTS PercentPopulationVaccinated
CREATE TABLE PercentPopulationVaccinated
(
Continent varchar(255),
Location varchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO PercentPopulationVaccinated
	SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,SUM(v.new_vaccinations)OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS RollingPeopleVaccination
	FROM covid_deaths_csv AS d
	JOIN vaccines AS v 
	ON d.location = v.location
	AND d.date = v.date		
	WHERE d.continent is not null
	LIMIT 10000
	
SELECT *, (RollingPeopleVaccination/population)*100
FROM PercentPopulationVaccinated


/*CREATE VIEW FOR VISUALIZATION*/

CREATE VIEW PercentPopulationVaccinated AS
	SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,SUM(v.new_vaccinations)OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS RollingPeopleVaccination
	FROM covid_deaths_csv AS d
	JOIN vaccines AS v 
	ON d.location = v.location
	AND d.date = v.date		
	WHERE d.continent is not null
	 
	

