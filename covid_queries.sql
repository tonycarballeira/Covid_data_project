SELECT * 
FROM Covid_Project.covid_deaths
where continent is not null
order by 3,4;

select Location, date, total_cases, new_cases, total_deaths, population
from Covid_Project.covid_deaths;

-- looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from Covid_Project.covid_deaths;

-- Looking at total cases vs population
-- shows what percentage of population got covid

Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
from Covid_Project.covid_deaths
where location like '%states%';


-- Looking at countries with highest infection rate compared to population

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from Covid_Project.covid_deaths
group by location, population
order by PercentPopulationInfected desc;

-- Showing countries with highest death count per population

Select location, MAX(total_deaths) as TotalDeathCount
from Covid_Project.covid_deaths
where continent is not null
group by location
order by TotalDeathCount desc;

-- Showing the continents with the highest death count

Select continent, MAX(total_deaths) as TotalDeathCount
from Covid_Project.covid_deaths
where continent is not null
group by continent
order by TotalDeathCount desc;


-- Global Numbers Total

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, 
SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
from Covid_Project.covid_deaths
where continent is not null
-- group by date
order by 1,2;

-- looking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(new_vaccinations) over (partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from Covid_Project.covid_deaths dea
join Covid_Project.covid_vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 5 desc;


