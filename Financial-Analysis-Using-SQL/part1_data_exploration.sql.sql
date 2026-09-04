-- ============================================================
-- FINANCIAL ANALYSIS USING SQL
-- Part 1 — Data Exploration & Company Analysis
-- Dataset: SEC Financial Statement Data Sets
-- Database: PostgreSQL
-- Table: SUB
-- ============================================================


-- ============================================================
-- 1. DATASET SIZE
-- Question: How many total records are in the SUB table?
-- ============================================================

SELECT COUNT(*) AS total_records
FROM sub;


-- ============================================================
-- 2. UNIQUE COMPANIES
-- Question: How many unique companies are represented?
-- ============================================================

SELECT COUNT(DISTINCT cik) AS unique_companies
FROM sub;


-- ============================================================
-- 3. MOST FREQUENT SIC CODES
-- Question: Which SIC codes appear most frequently?
-- Note: This counts filing records, not unique companies.
-- ============================================================

SELECT sic,
       COUNT(*) AS filing_records
FROM sub
GROUP BY sic
ORDER BY filing_records DESC
LIMIT 10;


-- ============================================================
-- 4. MOST COMMON INDUSTRIES BY UNIQUE COMPANIES
-- Question: Which SIC codes represent the most unique companies?
-- ============================================================

SELECT sic,
       COUNT(DISTINCT cik) AS unique_companies
FROM sub
WHERE sic IS NOT NULL
GROUP BY sic
ORDER BY unique_companies DESC
LIMIT 10;


-- ============================================================
-- 5. COMPANIES BY COUNTRY
-- Question: Which countries have the most unique companies?
-- ============================================================

SELECT countryba,
       COUNT(DISTINCT cik) AS unique_companies
FROM sub
WHERE countryba IS NOT NULL
GROUP BY countryba
ORDER BY unique_companies DESC
LIMIT 10;


-- ============================================================
-- 6. COMPANIES WITH THE MOST FILING RECORDS
-- Question: Which companies appear most frequently in the dataset?
-- ============================================================

SELECT cik,
       MAX(name) AS company_name,
       COUNT(*) AS filing_records
FROM sub
GROUP BY cik
ORDER BY filing_records DESC
LIMIT 10;


-- ============================================================
-- 7. MOST COMMON FILING TYPES
-- Question: Which SEC filing forms appear most frequently?
-- ============================================================

SELECT form,
       COUNT(*) AS filing_count
FROM sub
GROUP BY form
ORDER BY filing_count DESC
LIMIT 10;


-- ============================================================
-- 8. FILING RECORDS BY YEAR
-- Question: How many filing records were submitted each year?
-- ============================================================

SELECT EXTRACT(YEAR FROM filed) AS filing_year,
       COUNT(*) AS filing_count
FROM sub
GROUP BY filing_year
ORDER BY filing_year;


-- ============================================================
-- 9. LATEST FILING DATE BY COMPANY
-- Question: What is the most recent filing date for each company?
-- ============================================================

SELECT cik,
       MAX(name) AS company_name,
       MAX(filed) AS latest_filing
FROM sub
GROUP BY cik
ORDER BY latest_filing DESC
LIMIT 10;


-- ============================================================
-- 10. MISSING COMPANY NAMES
-- Question: How many records are missing a company name?
-- ============================================================

SELECT COUNT(*) AS missing_names
FROM sub
WHERE name IS NULL;


-- ============================================================
-- 11. MISSING CIK VALUES
-- Question: How many records are missing a company identifier?
-- ============================================================

SELECT COUNT(*) AS missing_cik
FROM sub
WHERE cik IS NULL;
