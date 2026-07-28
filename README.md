# Google Trends Data Cleaning with PostgreSQL

## Project Overview

This project demonstrates a complete SQL data cleaning workflow using PostgreSQL.

The dataset consists of multiple Google Trends categories collected separately and combined into a single analytical dataset.

The objective was to identify data quality issues, standardize the data, convert text fields into usable formats, and prepare the dataset for analysis.

---

# Tools Used

- PostgreSQL
- pgAdmin 4
- SQL
- Microsoft Excel (validation)

---

# Dataset

The project contains multiple Google Trends categories including:

- Autos
- Beauty & Fashion
- Business & Finance
- Climate
- Entertainment
- Food & Drinks
- Games
- Health
- Hobbies & Leisure
- Jobs & Education
- Laws & Government
- Others Search
- Pets & Animals
- Politics
- Science
- Shopping
- Sports
- Technology
- Travel & Transportation

Each table contains:

- trends
- search_volume
- started_date
- ended_date
- trend_breakdown
- explore_link

---

# Project Workflow

## Step 1 — Explore the Original Dataset

The original data contained text dates, inconsistent formatting, and values that required cleaning before analysis.

<img width="1212" height="137" alt="Screenshot 2026-07-28 124957" src="https://github.com/user-attachments/assets/44462cf9-c2ea-4bde-82e4-932928517626" />

---

## Step 2 — Combine All Tables

A SQL View was created using `UNION ALL` to combine every category into one dataset.

This allowed all cleaning and validation queries to run against a single view.

<img width="1600" height="523" alt="Screenshot 2026-07-28 131112" src="https://github.com/user-attachments/assets/395a75cc-3cce-4876-8933-3a9e26f61cf4" />


---

## Step 3 — Check for Duplicate Records

Duplicates were identified using

- ROW_NUMBER()
- PARTITION BY

to identify repeated rows.

```sql
ROW_NUMBER() OVER (
PARTITION BY
trends,
search_volume,
started_date,
ended_date,
trend_breakdown,
explore_link,
source_table
)
```

<img width="725" height="335" alt="Screenshot 2026-07-28 135637" src="https://github.com/user-attachments/assets/90b4a665-412d-4cbb-adc1-27f74042af36" />


---

## Step 4 — Standardize Text Values

Text values were standardized by

- trimming spaces
- correcting spelling inconsistencies
- replacing inconsistent trend names

Examples:

- "3m" → "three m open leaderboard"
- "72%" → "hours 72"

<img width="701" height="312" alt="Screenshot 2026-07-28 135904" src="https://github.com/user-attachments/assets/26186e4d-51e1-42c8-bc0b-7f6d37a1d097" />


---

## Step 5 — Clean Search Volume

Search volume values originally contained symbols such as

- K+
- +

Example:

```
2K+
```

became

```
2000
```

using SQL string functions.

---

## Step 6 — Convert Date Columns

The original dates were stored as text.

Example:

```
July 24, 2026 at 3:30 AM UTC-4
```

The project converted them into PostgreSQL TIMESTAMP values using

- REPLACE()
- REGEXP_REPLACE()
- TO_TIMESTAMP()

<img width="581" height="762" alt="Screenshot 2026-07-28 135928" src="https://github.com/user-attachments/assets/b894c833-627e-4d70-99d9-dabb45859c26" />


---

## Step 7 — Create Timestamp Columns

New columns were created:

- started_timestamp
- ended_timestamp

The cleaned timestamps replaced the original text-based dates.

Original text columns were removed after verification.

<img width="1600" height="523" alt="Screenshot 2026-07-28 131112" src="https://github.com/user-attachments/assets/d6937dd9-afcd-41f7-be79-5356d28e6390" />


---

## Step 8 — Handle Missing Values

The dataset was inspected for NULL values.

Results:

- started_timestamp NULL = 0
- ended_timestamp NULL = 109

The NULL values were preserved because no valid source value existed.

Rows containing NULL timestamps were excluded from the final cleaned analytical view.

<img width="957" height="323" alt="Screenshot 2026-07-28 135942" src="https://github.com/user-attachments/assets/40635362-6ce6-45e7-8349-9769b0e1a7c3" />


---

## Step 9 — Add Source Table

A new column named

```
source_table
```

<img width="665" height="321" alt="Screenshot 2026-07-28 135957" src="https://github.com/user-attachments/assets/d6b54e1d-d308-463f-99fb-56204fe9e875" />


was added to identify the original category for every record after combining all datasets.

Example:

```
autos
beauty_fashion
business_finance
...
```

This makes filtering and analysis much easier.

---

## Step 10 — Final Clean Dataset

The final dataset contains

- standardized text
- cleaned search volumes
- timestamp columns
- category tracking
- duplicate validation
- consistent formatting

and is ready for Exploratory Data Analysis (EDA).

<img width="1506" height="762" alt="Screenshot 2026-07-28 141013" src="https://github.com/user-attachments/assets/2d7c10b0-bfb3-4aba-924f-4809cb2d8939" />


---

# SQL Skills Demonstrated

- CREATE VIEW
- UNION ALL
- ALTER TABLE
- UPDATE
- DELETE
- TRIM()
- REPLACE()
- REGEXP_REPLACE()
- TO_TIMESTAMP()
- COALESCE()
- ROW_NUMBER()
- PARTITION BY
- COUNT()
- Data Validation
- Missing Value Analysis
- Duplicate Detection
- Data Standardization
- Data Cleaning

---

# Key Results

✅ Combined 19 Google Trends datasets

✅ Standardized inconsistent text values

✅ Converted text dates into timestamps

✅ Cleaned search volume values

✅ Added category tracking

✅ Validated duplicate records

✅ Identified missing values

✅ Produced an analysis-ready dataset

---

# Future Work

Next steps include:

- Exploratory Data Analysis (EDA)
- Trend analysis
- Category comparisons
- Time-series analysis
- Dashboard creation in Power BI
