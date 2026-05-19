SHOW VARIABLES LIKE 'secure_file_priv';
create database pharmadata;
use pharmadata;
DROP TABLE adverse_events;

CREATE TABLE adverse_events (
    report_id VARCHAR(20),
    caers_created_date VARCHAR(20),
    event_start_date VARCHAR(20),
    product_role VARCHAR(50),
    brand_name VARCHAR(200),
    industry_code VARCHAR(20),
    industry_name VARCHAR(100),
    age_at_event VARCHAR(20),
    age_unit VARCHAR(20),
    gender VARCHAR(20),
    outcomes VARCHAR(200),
    symptoms TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CAERS_ASCII_2004_2017Q2.csv'
INTO TABLE adverse_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM adverse_events LIMIT 10;



SELECT 
    industry_name, 
    COUNT(*) AS total_reports
FROM adverse_events
WHERE industry_name != 'Not Available'  -- Removing incomplete records
GROUP BY industry_name
ORDER BY total_reports DESC
LIMIT 10;
/* ANALYSIS 1: Top Reported Industries
Goal: Find which food/product industries have the most adverse event reports
Insight: Helps identify high-risk sectors*/
-- INSIGHT: Vitamin/Mineral/Protein supplements account for 48,501 reports
-- which is 4x more than the second highest category (Cosmetics: 11,733)
-- This suggests supplements carry the highest adverse event risk
-- among all FDA-reported food/product categories (2004-2017)





SELECT 
    gender,
    COUNT(*) AS total_reports,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM adverse_events), 2) AS percentage    -- total percentage nikalna hai
FROM adverse_events
GROUP BY gender
ORDER BY total_reports DESC;
/*Analysis 2
INSIGHT: Females account for 64.9% of all adverse event reports
vs Males at 29.68% -- nearly 2x more female reporters
 Possible reason: higher female consumption of supplements & cosmetics
 which are the top 2 high-risk categories (Query 1)*/
 
 
 
 SELECT 
    -- date se sirf year nikaal rahe hain
    SUBSTRING(caers_created_date, -4, 4) AS report_year,
    COUNT(*) AS total_reports,
    CASE 
        WHEN COUNT(*) > 5000 THEN 'High Volume'
        WHEN COUNT(*) > 2000 THEN 'Medium Volume'
        ELSE 'Low Volume'
    END AS volume_category
FROM adverse_events
WHERE caers_created_date != 'Not Available'
GROUP BY report_year
ORDER BY report_year ASC;

/*query3
INSIGHT: Adverse event reports grew 5x from 2004 (3,338) to 2016 (15,547)
Consistent growth post-2009 likely due to FDA's improved 
online reporting systems making it easier for public to report*/





SELECT 
    outcomes,
    COUNT(*) AS total_reports
FROM adverse_events
WHERE outcomes NOT IN ('Not Available', '')
GROUP BY outcomes
HAVING COUNT(*) > 500
ORDER BY total_reports DESC
LIMIT 10;
/*query 4
INSIGHT: Non-serious injuries lead at 24,370 but serious events
are close behind at 19,948 -- nearly a 50-50 split
7,271 cases resulted in hospitalization or ER visits
suggesting food/supplement adverse events carry real medical risk*/



-- Top 10 Most Reported Product Brands
-- Goal: Identify which brands appear most in adverse events

SELECT 
    brand_name, COUNT(*) AS total_reports
FROM
    adverse_events
WHERE
    brand_name != 'Not Available'
GROUP BY brand_name
ORDER BY total_reports DESC
LIMIT 10;
-- INSIGHT: REDACTED brand leads with 6,081 reports (identity hidden by FDA)
-- Remaining top brands are all supplements: Vitamin D, Multivitamin, Fish Oil
-- This confirms Query 1 finding -- supplement industry is highest risk
-- Pattern: Same category dominates both industry-level and brand-level analysis


-- --query 6
-- Age Group wise adverse event distribution
-- Goal: Which age group is most affected?
SELECT 
    CASE 
        WHEN age_at_event BETWEEN '1' AND '17' THEN 'Child (1-17)'
        WHEN age_at_event BETWEEN '18' AND '35' THEN 'Young Adult (18-35)'
        WHEN age_at_event BETWEEN '36' AND '60' THEN 'Middle Age (36-60)'
        WHEN age_at_event > '60' THEN 'Senior (60+)'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS total_reports
FROM adverse_events
GROUP BY age_group
ORDER BY total_reports DESC;
/*
 INSIGHT: Senior (60+) and Middle Age (36-60) are most affected
 with 20,889 and 20,310 reports respectively
 Likely reason: weaker immunity in seniors + higher supplement 
 consumption in middle age group
 Children (2,104) least affected -- faster metabolism & recovery
Unknown (37,874) highlights data quality issue in age reporting*/




-- Brands linked to most serious outcomes
-- Goal: Find brands where outcome was DEATH or HOSPITALIZATION

SELECT 
    brand_name,
    COUNT(*) AS serious_reports
FROM adverse_events
WHERE outcomes LIKE '%DEATH%' 
   OR outcomes LIKE '%HOSPITALIZATION%'
AND brand_name != 'Not Available'
GROUP BY brand_name
HAVING COUNT(*) > 50
ORDER BY serious_reports DESC
LIMIT 10;
-- INSIGHT: REDACTED brand leads with 1,393 serious cases (identity protected)
-- Super Beta Prostate (231) confirms seniors (60+) most vulnerable group
-- Supplements dominate top 10 -- consistent finding across all queries
-- Hydroxycut presence validates data -- FDA banned it in 2009 for liver damage
-- Raw Oysters only natural food in list -- bacterial contamination risk


