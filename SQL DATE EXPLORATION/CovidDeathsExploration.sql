Select *
FROM PortfolioProject.dbo.CovidDeaths
Where continent is not null
order by 3,4 


--Select *
--FROM PortfolioProject.dbo.CovidVaccination
--order by 3,4 

-- SELECT DATA WE ARE GOING TO USE

SELECT Location, Date ,total_cases, new_cases,total_deaths,population
FROM PortfolioProject.dbo.CovidDeaths
Where continent is not null
ORDER BY 1,2

--Looking at Total Cases VS Total Deaths

SELECT location,date,total_cases , total_deaths, (CAST(total_deaths as decimal) / CAST(total_cases as decimal))*100 as DeathPercentage
FROM PortfolioProject.dbo.CovidDeaths
Where continent is not null
ORDER BY 1,2

--Continents VS Total Locations

SELECT continent,COUNT(location) as TotalLocations
FROM PortfolioProject.dbo.CovidDeaths
GROUP BY continent
ORDER BY TotalLocations DESC

--Locations

SELECT DISTINCT(location)
FROM PortfolioProject.dbo.CovidDeaths
ORDER BY location  

-- First Case reported in each location

SELECT DISTINCT(location),date,total_cases
FROM PortfolioProject.dbo.CovidDeaths
WHERE total_cases=1
GROUP BY location,date,total_cases
ORDER BY location


-- Total Case VS Population

SELECT location,date,total_cases , population, (CAST(total_deaths as decimal) / CAST(population as decimal))*100 as InfectedPercentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE location = 'India' AND total_cases>0 AND continent is not null
ORDER BY 1,2

--Highest Infection Rate Population VS Total Case

SELECT location, population, MAX(total_cases) as MaximumInfectionCount,
MAX((CAST(total_cases as decimal) / CAST(population as decimal)))*100 as HighestInfectedPercentage 
FROM PortfolioProject.dbo.CovidDeaths
Where continent is not null
GROUP BY location,population
Order by HighestInfectedPercentage DESC

--Highest Death Count 

Select location,Max(cast(total_deaths as INT)) as MaxDeathCount 
FROM PortfolioProject.dbo.CovidDeaths
Where continent is null
GROUP BY location
Order by MaxDeathCount DESC

--Continent wise death rate and Overall COVID Deaths in World

Select location,Max(cast(total_deaths as INT)) as MaxDeathCount 
FROM PortfolioProject.dbo.CovidDeaths
Where continent is null
GROUP BY location
Order by MaxDeathCount DESC

--location wise first report of COVID

WITH FirstCase AS(
SELECT location,date,total_cases,ROW_NUMBER() OVER (PARTITION BY location ORDER BY date) as rn
FROM PortfolioProject.dbo.CovidDeaths
WHERE total_cases=1 AND continent is not null)
SELECT location,date,total_cases
FROM FirstCase
WHERE rn=1;

--First Case date in each continent

WITH RankedCovidDeaths AS (
    SELECT 
        date,
        continent,
        total_cases,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY date) AS rn
    FROM PortfolioProject.dbo.CovidDeaths
    WHERE total_cases = 1 AND continent IS NOT NULL
)
SELECT date, continent, total_cases
FROM RankedCovidDeaths
WHERE rn = 1;

--First Death Reported in world because of COVID

SELECT TOP 1 date,continent,location,total_deaths
FROM PortfolioProject.dbo.CovidDeaths
WHERE total_deaths=1 And continent is not null
group by continent,location,total_deaths,date
ORDER BY date  

--First Death Reported in each location

With FirstDeath AS (
SELECT location,date,total_deaths as FirstDeath,
ROW_NUMBER() OVER (Partition BY location ORDER BY date) as rn
FROM PortfolioProject.dbo.CovidDeaths
WHERE total_deaths=1 AND continent is not null)
SELECT location,date,FirstDeath
FROM FirstDeath
WHERE rn=1

--First Death Reported in each continent

WITH COntinentDeaths AS (
    SELECT 
        date,
        continent,
        total_deaths,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY date) AS rn
    FROM PortfolioProject.dbo.CovidDeaths
    WHERE total_deaths = 1 AND continent IS NOT NULL
)
SELECT date, continent, total_deaths
FROM ContinentDeaths
WHERE rn = 1;

--Last Death Reported of each continent

WITH ContinentDeaths AS (
    SELECT 
        date,
        continent,
        total_deaths,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY date desc) AS rn
    FROM PortfolioProject.dbo.CovidDeaths
    WHERE total_deaths = 1 AND continent IS NOT NULL
)
SELECT date, continent, total_deaths
FROM ContinentDeaths
WHERE rn = 1;

--Last Death Reported in each location

With FirstDeath AS (
SELECT location,date,total_deaths as FirstDeath,
ROW_NUMBER() OVER (Partition BY location ORDER BY date desc) as rn
FROM PortfolioProject.dbo.CovidDeaths
WHERE total_deaths=1 AND continent is not null)
SELECT location,date,FirstDeath
FROM FirstDeath
WHERE rn=1

--Last Death Reported in world because of COVID

SELECT TOP 1 date,continent,location,total_deaths
FROM PortfolioProject.dbo.CovidDeaths
WHERE total_deaths=1 And continent is not null
group by continent,location,total_deaths,date
ORDER BY date desc 

--Number of new cases reported each date from day-1 of COVID

SELECT location,date,new_cases
FROM PortfolioProject.dbo.CovidDeaths
where new_cases <> 0 and continent is not null
ORDER BY date

--Number of new cases in each continent from day-1

SELECT continent,date,new_cases
FROM PortfolioProject.dbo.CovidDeaths
where new_cases <> 0 and continent is not null
ORDER BY date

--Total Cases and Total Deaths due to COVID

SELECT SUM(cast(total_cases as bigint)) as Total_Cases , SUM(CAST(total_deaths as bigint)) as Total_Deaths , 
SUM(CAST(Population as BIgInt)) as Total_Population
FROM PortfolioProject.dbo.CovidDeaths 


