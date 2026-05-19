# FDA Adverse Events Analysis (2004–2017)
**SQL | MySQL Workbench | Excel**

---

## About This Project

I came across the FDA's CAERS dataset and got curious — which products are actually causing harm? Which brands? Which age groups are most at risk?

So I took 90,786 real adverse event reports filed with the FDA between 2004 and 2017, imported them into MySQL, and started digging.

No fancy tools. Just SQL.

---

## Tools Used

- MySQL Workbench — all queries and analysis
- Microsoft Excel — initial data exploration
- GitHub — sharing the work

---

## What I Found

**Supplements dominate everything.**
Vitamin, mineral, and protein supplements account for 48,501 reports — nearly 4x more than cosmetics (11,733), the second highest. Every single query I ran kept pointing back to the same category. It's not a coincidence.

**Women report almost twice as much as men.**
64.9% of reports came from females vs 29.68% from males. Makes sense when you consider that the top two risky categories — supplements and cosmetics — are heavily consumed by women.

**Reports grew 5x between 2004 and 2016.**
From 3,338 reports in 2004 to 15,547 in 2016. The jump starts around 2009 — right when FDA made online reporting easier. More awareness, more reports.

**Older people (60+) are most affected.**
20,889 serious reports from seniors. Weaker immunity plus heavy supplement use is a dangerous combination.

**Super Beta Prostate stands out.**
Among brands with visible names, Super Beta Prostate had 231 death or hospitalization cases. It's a supplement used mostly by older men — which lines up exactly with the age group finding.

**Hydroxycut shows up in serious cases.**
FDA banned Hydroxycut in 2009 for causing liver damage. It appears in this dataset's serious cases too — which tells me the data is tracking real events accurately.

---

## The Redacted Problem

One thing I didn't expect to find — "REDACTED" shows up as the most reported brand with 6,081 total reports, and 1,393 death or hospitalization cases. That's the highest of any single entity in the dataset.

FDA hides certain brand names — usually because of legal cases or settlements. So the most dangerous product in this entire dataset has its identity protected. That's worth thinking about.

---

## Recommendations

- Supplements need stricter pre-market safety testing. The numbers are too large to ignore.
- Seniors (60+) should be counselled specifically about supplement risks — especially prostate and energy products.
- The REDACTED data is a problem. Public health decisions shouldn't be made with hidden information.
- Adverse event monitoring should be real-time. Hydroxycut was dangerous years before the 2009 ban. Earlier detection would have mattered.

---

## Dataset

FDA CFSAN Adverse Event Reporting System (CAERS) — publicly available.
90,786 records | 2004 to Q2 2017

Link: https://www.fda.gov/food/compliance-enforcement-food/cfsan-adverse-event-reporting-system-caers

Dataset not included in this repo due to file size. Download directly from FDA.

---

**Abhishek Kumar**
abhiyadav8762@gmail.com | github.com/abhishek8762a
