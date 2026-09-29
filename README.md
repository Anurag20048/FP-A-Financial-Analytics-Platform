# Enterprise FP&A & Financial Performance Analytics Platform

An end-to-end **Financial Planning & Analysis (FP&A)** project using **Power BI, PostgreSQL, SQL, Excel, Power Query and DAX**. The project analyzes financial transactions to support management reporting, budget-vs-actual analysis, profitability review, variance investigation and financial performance monitoring.

> **Interview focus:** financial analysis, data accuracy, variance analysis, KPI reporting, SQL, dashboarding and management-oriented insights.

## Project Objectives

- Analyze revenue and cost performance
- Compare budgeted and actual financial results
- Measure revenue, cost and gross-profit variances
- Evaluate gross margin and budget attainment
- Compare regional financial performance
- Identify financial exceptions such as revenue shortfalls and cost overruns
- Apply reporting-control checks before publishing financial results
- Present management-ready KPIs through Power BI

## Technology Stack

| Layer | Technology |
|---|---|
| Data preparation | Excel, Power Query |
| Database | PostgreSQL |
| Analysis | SQL |
| BI / Visualization | Power BI |
| Calculations | DAX |
| Reporting | Power BI dashboard |

## Existing Power BI Dashboard

The supplied PBIX contains the existing dashboard views for:

- Executive financial dashboard
- P&L analysis
- Revenue vs cost
- Gross profit and gross margin
- Budget vs actual
- Revenue and cost variance
- Regional performance
- Product profitability
- Forecasting / outlook

Screenshots are available in `Screenshots/`.

## Advanced SQL Layer Added

The repository now includes:

- Executive financial KPI pack
- Revenue and cost variance percentages
- Budget attainment
- Gross-profit variance
- Favorable / unfavorable variance classification
- Regional profitability ranking
- Regional exception analysis
- Financial data-quality checks
- Gross-profit reconciliation control
- Region referential-integrity check

## Financial KPI Definitions

See [`docs/KPI_DEFINITIONS.md`](docs/KPI_DEFINITIONS.md) for the definitions and interpretation of the core measures.

## Financial Controls

Before a management report is published, the project includes checks for:

- Missing revenue/cost/budget values
- Negative financial values
- Gross-profit reconciliation
- Unmatched region references

These checks are intended as analytical controls and should be adapted to the organization's accounting rules before production use.

## SQL Files

```text
01_financial_analysis.sql       Core financial calculations
region_analysis.sql             Regional revenue/cost analysis
sql/02_advanced_financial_analysis.sql  Advanced KPI and variance analysis
sql/03_region_deep_dive.sql             Regional profitability and ranking
sql/04_financial_controls.sql           Reporting-quality checks
```

## Project Structure

```text
Enterprise-FP-A-Dashboard/
│
├── PowerBI/
│   └── Enterprise_FPA_Dashboard.pbix
│
├── Screenshots/
│   ├── 01_main_dashboard.png
│   ├── 02_p&l_analysis.png
│   └── 03_forecasting_outlook.png
│
├── sql/
│   ├── 02_advanced_financial_analysis.sql
│   ├── 03_region_deep_dive.sql
│   └── 04_financial_controls.sql
│
├── docs/
│   ├── KPI_DEFINITIONS.md
│   └── INTERVIEW_GUIDE.md
│
├── 01_financial_analysis.sql
├── region_analysis.sql
└── README.md
```

## Data Scope

The original project describes a dataset containing **100,000+ financial transactions**. The existing project SQL verifies the use of revenue, cost, budget and region fields. Additional business measures should only be reported when the underlying source fields and calculations are present.

## Business Questions

1. Are actual revenues above or below budget?
2. Are costs under or over budget?
3. Which regions contribute the most gross profit?
4. Which regions have the largest revenue shortfalls?
5. Which regions show the largest cost overruns?
6. How does actual gross margin compare with budgeted gross margin?
7. Are financial results internally reconciled?
8. Are the source records complete enough for reporting?

## Key Insights Already Documented by the Original Project

The supplied project documentation reports:

- Actual revenue of **$80.21M** versus budgeted revenue of **$80.41M**.
- Revenue variance of approximately **-$206.55K**.
- Actual gross profit of **$32.17M**.
- Gross margin of **40.11%**.
- Regional performance comparisons across North, South, East and West.

These figures are retained from the original project documentation; they should be revalidated against the live database before being used as current reporting figures.

## Interview Preparation

See [`docs/INTERVIEW_GUIDE.md`](docs/INTERVIEW_GUIDE.md) for project-specific Financial Analyst interview questions and answers.

## Disclaimer

This is a portfolio/learning project. It demonstrates financial-analysis and reporting techniques and is not an accounting system or audited financial reporting solution.
