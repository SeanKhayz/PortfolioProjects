--SELECT *
--FROM [Portfolio Project].[dbo].[CovidDeaths$]

SELECT *
FROM PortfolioProject..CovidDeaths$
--WHERE Continent is NOT NULL
ORDER BY 3,4



--SELECT *
--FROM PortfolioProject..CovidVaccinations$
--ORDER BY 3,4

-- Select Data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths$
ORDER BY 1,2

-- looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths$
Where Location LIKE '%States%'
ORDER BY 1,2

--Looking  at total cases vs the population
--Shows percentage of population with covid cases in where country contains State
SELECT Location, date, Population, total_cases, (total_cases/population)*100 AS PercentageCases
FROM PortfolioProject..CovidDeaths$
Where Location LIKE '%States%'
ORDER BY 1,2

--Looking at countries with highest infection rate compared to population
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentageCases
FROM PortfolioProject..CovidDeaths$
GROUP BY Location, Population
--Where Location LIKE '%States%'
ORDER BY 4 DESC

-- Countries with highest death count per population
SELECT Location, MAX(CAST(total_deaths as int) )AS TotalDeathCount, 
FROM PortfolioProject..CovidDeaths$
-- This line below helps us to remove the locations where there are continents within the location column and keep just the countries
WHERE Continent is NOT NULL
GROUP BY Location
Order By 2 DESC


-- Breaking things down by Continents

SELECT Location, MAX(CAST(total_deaths as int) )AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
-- This line below helps us to highlight the locations where there are no countries rather just continents
WHERE Continent is NULL
GROUP BY Location
Order By 2 DESC
 
 --OR 

 SELECT Continent, MAX(CAST(total_deaths as int) )AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
-- This line below helps us to highlight the locations where there are no countries rather just continents
WHERE Continent is Not NULL
GROUP BY Continent
Order By 2 DESC

--OR

 SELECT Continent, MAX(CAST(total_deaths as int) )AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
-- This line below helps us to highlight the locations where there are no countries rather just continents
WHERE location <> continent
GROUP BY Continent
Order By 2 DESC

