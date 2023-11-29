SELECT *
FROM PortfolioProject..CovidVaccination

SELECT *
FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccination vac
ON dea.location = vac.location 
and dea.date=vac.date

--Total Population VS Number of people fully vaccinated

SELECT SUM(Population) as Total_Population,SUM(CAst(people_fully_vaccinated as bigint)) as VaccinatedFully
FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccination vac
ON dea.location = vac.location 
and dea.date=vac.date

--Vaccination amount by Location

SELECT sum(cast(people_fully_vaccinated as bigint)) as total_vaccinations,dea.location
FROM PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccination vac
ON dea.location = vac.location 
and dea.date=vac.date
where dea.continent is not null
GROUP BY dea.location
ORDER by 2

--Vaccinated percentage of people

Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
ON dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 1,2,3

--Total vaccination in each location

Select dea.location,SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location)
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
ON dea.location=vac.location
and dea.date=vac.date

--First Vaccine Injected

With FirstVaccine AS (
Select TOP 1 dea.location, dea.date ,vac.people_fully_vaccinated, 
ROW_NUMBER() OVER (Partition by dea.location order by vac.people_fully_vaccinated , dea.date) as rn
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
ON dea.location=vac.location
and dea.date=vac.date 
)
SELECT *
FROM FirstVaccine
WHERE rn=1

--Perecentage of people
WITH PopVSVac as (
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER(Partition BY dea.location Order by dea.location,dea.date) as PV 
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
ON dea.location=vac.location
and dea.date=vac.date 
)
SELECT *,(PV/population)*100 
FROM PopVSVac
