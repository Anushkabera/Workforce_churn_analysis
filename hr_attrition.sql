use anushka_db;

/*STEP 1: Create a new table for the risk classification*\
CREATE TABLE HR_Attrition_Risk AS
SELECT *,
  CASE
    WHEN Attrition = 'Yes' AND JobSatisfaction <= 2 AND WorkLifeBalance <= 2 THEN 'High Risk'
    WHEN Attrition = 'Yes' AND JobSatisfaction <= 2 THEN 'Moderate Risk'
    WHEN Attrition = 'Yes' THEN 'Low Risk'
    ELSE 'Stable'
  END AS Risk_Level
FROM hr_attrition;

SELECT * FROM HR_Attrition_Risk LIMIT 10;

/*Aggregate Attrition by Department*/
SELECT Department, 
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM hr_Attrition
GROUP BY Department;

/* Aggregate Attrition by Age Group*/
SELECT 
  CASE 
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age BETWEEN 30 AND 40 THEN '30-40'
    WHEN Age BETWEEN 41 AND 50 THEN '41-50'
    ELSE '51+'
  END AS Age_Group,
  COUNT(*) AS Total,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM HR_Attrition
GROUP BY 
  CASE 
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age BETWEEN 30 AND 40 THEN '30-40'
    WHEN Age BETWEEN 41 AND 50 THEN '41-50'
    ELSE '51+'
  END;

/* Aggregate Attrition by Job level */
SELECT JobLevel, 
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM hr_Attrition
GROUP BY JobLevel;

/*Create Cohorts Based on Risk Level and Job Role*/
SELECT JobRole, Risk_Level, COUNT(*) AS Employees
FROM hr_attrition_risk
GROUP BY JobRole, Risk_Level
ORDER BY JobRole, Risk_Level;

/* Summary for Visualization or Power BI Export*/
SELECT Department, Age, JobRole, JobLevel, Risk_Level, Attrition
FROM hr_Attrition_Risk;



  
  
