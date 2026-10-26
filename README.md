<div align="center">

# 💊 FDA Adverse Events Analysis (SQL)

**90,786 real FDA CAERS reports (2004 – 2017), investigated in MySQL: which products, brands and people are most affected.**

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analysis-0B1120?style=flat-square)
![Excel](https://img.shields.io/badge/Excel-217346?style=flat-square&logo=microsoftexcel&logoColor=white)
![Status](https://img.shields.io/badge/status-complete-22C55E?style=flat-square)

</div>

---

## 📌 Overview

I came across the FDA's CAERS dataset and got curious: which products are actually causing harm? Which brands? Which age groups are most at risk?

So I took 90,786 real adverse event reports filed with the FDA between 2004 and 2017, loaded them into MySQL and started digging. No fancy tools. Just SQL.

## 📂 Dataset

| | |
|---|---|
| **Source** | [FDA CFSAN Adverse Event Reporting System (CAERS)](https://www.fda.gov/food/compliance-enforcement-food/cfsan-adverse-event-reporting-system-caers), public data |
| **File** | [`data/CAERS_ASCII_2004_2017Q2.csv`](data/CAERS_ASCII_2004_2017Q2.csv) |
| **Rows** | 90,786 reports, 2004 to Q2 2017 |
| **Columns (12)** | report ID, created date, event start date, product role, brand name, industry code and name, age at event, age unit, gender, outcomes, symptoms |

## 🔍 Questions Answered

| # | Question | SQL used |
|---|---|---|
| 1 | Which industries have the most reports? | `GROUP BY`, `WHERE` to drop incomplete rows |
| 2 | How do reports split by gender? | Percentage with a scalar sub-query |
| 3 | How did report volume change by year? | `SUBSTRING` on dates, `CASE` volume bands |
| 4 | What are the most common outcomes? | `NOT IN`, `HAVING` |
| 5 | Which brands are reported most? | `GROUP BY`, `LIMIT` |
| 6 | Which age groups are most affected? | `CASE` age buckets |
| 7 | Which brands are linked to death or hospitalisation? | `LIKE`, `HAVING` |

All queries, with the insight under each, are in [`sql/fda_adverse_events_analysis.sql`](sql/fda_adverse_events_analysis.sql).

## 📊 What I Found

**Supplements dominate everything.**
Vitamin, mineral and protein supplements account for 48,501 reports, about 4x more than cosmetics (11,733), the second highest. Every query kept pointing back to the same category.

**Women report almost twice as much as men.**
64.9% of reports came from women vs 29.68% from men. The top two categories, supplements and cosmetics, are heavily used by women.

**Reports grew almost 5x between 2004 and 2016.**
From 3,338 reports in 2004 to 15,547 in 2016. The jump starts around 2009, when the FDA made online reporting easier.

**Serious outcomes are common.**
Non-serious injuries lead with 24,370 reports, but serious events are close behind at 19,948, and 7,271 cases involved hospitalisation or an ER visit.

**Older adults (60+) file the most reports**, followed by the 36–60 age group. Age is missing in about 37,900 reports, a real data-quality gap.

**Super Beta Prostate stands out.**
Among brands with visible names, Super Beta Prostate had 231 death or hospitalisation cases. It is a supplement used mostly by older men, which lines up with the age finding.

**Hydroxycut shows up in serious cases.**
The FDA warned consumers to stop using Hydroxycut in 2009 over liver damage. It appears in this dataset's serious cases too, a sign the data tracks real events.

## 🕵️ The Redacted Problem

One thing I didn't expect: "REDACTED" is the most reported brand, with 6,081 reports and 1,393 death or hospitalisation cases, the highest of any single entity in the dataset.

The FDA hides certain brand names, usually because of legal cases or settlements. So the entity with the most serious reports in this dataset has its identity protected. That's worth thinking about.

## 💡 Recommendations

- Supplements need stricter pre-market safety testing. The numbers are too large to ignore.
- Seniors (60+) should be counselled specifically on supplement risks, especially prostate and energy products.
- Redacted data is a problem. Public-health decisions shouldn't rest on hidden information.
- Adverse-event monitoring should be real-time. Earlier detection matters.

## 📁 Repository Structure

```
fda-adverse-events-sql/
├── data/
│   └── CAERS_ASCII_2004_2017Q2.csv      # raw FDA CAERS export (~19 MB)
├── sql/
│   └── fda_adverse_events_analysis.sql  # table setup, data load and 7 analyses
└── README.md
```

## ▶️ How to Run

1. Run the first query in `sql/fda_adverse_events_analysis.sql` to find your MySQL `secure_file_priv` folder.
2. Copy `data/CAERS_ASCII_2004_2017Q2.csv` into that folder and update the `LOAD DATA INFILE` path if needed.
3. Run the `CREATE` and `LOAD DATA` statements, then each analysis query in order.

---

## 👤 Author

**Abhishek Kumar** · MIS Data Analyst  
[LinkedIn](https://www.linkedin.com/in/abhikumar8762/) · [GitHub](https://github.com/abhishek8762a) · [Portfolio](https://abhishek-portfolio-8762.vercel.app) · [Email](mailto:abhiyadav8762@gmail.com)
