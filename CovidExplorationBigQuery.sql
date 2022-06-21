/*
Covid 19 Data Exploration 
Skills used: Joins, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

SELECT
  *
FROM
  `secret-country-345801.Portfolio.covid_deaths`
Where continent is not null
ORDER BY
  3,4

  --SELECT *
  --FROM `secret-country-345801.Portfolio.covid_vaccinations`
  --order by 3,4

SELECT location, date, total_cases, new_cases, total_deaths
FROM
  `secret-country-345801.Portfolio.covid_deaths`
ORDER BY
1, 2
  
  -- Looking at Total Cases vs Total Deaths
  -- Shows likehood of dying 
SELECT
  location,date,total_cases,new_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM
  `secret-country-345801.Portfolio.covid_deaths`
WHERE location like 'United States'
ORDER BY
  1, 2

-- Looking at Total Cases vs Population 
-- shows what percentage of the population got Covid
SELECT
  location,date,total_cases,population, (total_cases/population)*100 as DeathPercentage
FROM
  `secret-country-345801.Portfolio.covid_deaths`
WHERE location like 'United States'
ORDER BY 1,2

-- Looking at Countries with highest infection rate compared to population 

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected 
FROM `secret-country-345801.Portfolio.covid_deaths`
--WHERE location like 'United States'
GROUP BY location, population
order by PercentPopulationInfected DESC 

-- Showing countries with highest death count per population

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM `secret-country-345801.Portfolio.covid_deaths`
--WHERE location like 'United States'
Where continent is not null
GROUP BY location
order by TotalDeathCount DESC 

--Breaking Down by Continent

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM `secret-country-345801.Portfolio.covid_deaths`
--WHERE location like 'United States'
Where continent is not null
GROUP BY continent
order by TotalDeathCount DESC 

--Showing the continents with the highest death count

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM `secret-country-345801.Portfolio.covid_deaths`
--WHERE location like 'United States'
Where continent is not null
GROUP BY continent
order by TotalDeathCount DESC 


-- Global Numbers

SELECT
SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM
  `secret-country-345801.Portfolio.covid_deaths`
--WHERE location like 'United States'
WHERE 
continent is not null
--group by date
ORDER BY 1,2

SELECT dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
,SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--,RollingPeopleVaccinated
FROM `secret-country-345801.Portfolio.covid_deaths` as dea
JOIN `secret-country-345801.Portfolio.covid_vaccinations` as vac
  on dea.location = vac.location 
  and dea.date =vac.date
WHERE dea.continent is not null
order by 2,3


--CREATING VIEW

CREATE VIEW `secret-country-345801.Portfolio.PercentPopulationVaccinated` AS
SELECT dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
,SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--,RollingPeopleVaccinated
FROM `secret-country-345801.Portfolio.covid_deaths` as dea
JOIN `secret-country-345801.Portfolio.covid_vaccinations` as vac
  on dea.location = vac.location 
  and dea.date =vac.date
WHERE dea.continent is not null
order by 2,3

--
