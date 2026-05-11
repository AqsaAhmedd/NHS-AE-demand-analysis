-- NHS A&E SQL Analysis
-- These queries are designed for the cleaned NHS A&E dataset.
-- Table name used: nhs_ae

-- 1. View first 10 rows
SELECT *
FROM nhs_ae
LIMIT 10;

-- 2. Total A&E attendances
SELECT 
    SUM(AE) AS total_ae_attendances
FROM nhs_ae;

-- 3. Average monthly attendance
SELECT 
    AVG(AE) AS average_monthly_attendance
FROM nhs_ae;

-- 4. Highest attendance month
SELECT 
    Date,
    AE
FROM nhs_ae
ORDER BY AE DESC
LIMIT 1;

-- 5. Yearly total attendances
SELECT 
    YEAR(Date) AS year,
    SUM(AE) AS yearly_total_attendances
FROM nhs_ae
GROUP BY YEAR(Date)
ORDER BY year;

-- 6. Demand category
SELECT 
    Date,
    AE,
    CASE
        WHEN AE >= 1500000 THEN 'High Demand'
        WHEN AE >= 1000000 THEN 'Medium Demand'
        ELSE 'Lower Demand'
    END AS demand_category
FROM nhs_ae;
