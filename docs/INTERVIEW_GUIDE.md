# Financial Analyst Project Interview Guide

## 1. What problem does the project solve?
It provides a management-oriented view of revenue, costs, profitability and budget performance, with SQL analysis and Power BI reporting.

## 2. What is FP&A?
Financial Planning & Analysis supports budgeting, forecasting, variance analysis, performance reporting and decision support.

## 3. How did you calculate revenue variance?
Revenue variance = Actual Revenue - Budgeted Revenue.

## 4. How did you calculate cost variance?
Cost variance = Actual Cost - Budgeted Cost. For this project, a positive cost variance represents an unfavorable cost overrun.

## 5. What is gross margin?
Gross margin % = Gross Profit / Actual Revenue × 100.

## 6. Why is variance percentage useful?
It puts the absolute variance into context relative to the budget and makes differently sized business units easier to compare.

## 7. How did you classify favorable and unfavorable variances?
Revenue above budget is favorable. Cost below budget is favorable. Gross-profit performance is favorable when actual gross profit is at or above budgeted gross profit.

## 8. Why use PostgreSQL and Power BI together?
PostgreSQL provides structured storage and SQL-based analysis, while Power BI provides interactive reporting and visualization.

## 9. What data-quality checks did you add?
Null checks, negative-value checks, gross-profit reconciliation and region referential-coverage checks.

## 10. What would you add in a production system?
Role-based access, audit trails, source-system reconciliation, documented accounting definitions, refresh monitoring and controlled access to sensitive financial data.

## Important limitation
The current repository's verified SQL references revenue, cost, budget and region fields. Do not claim working-capital, EBITDA, cash-flow or customer-level analysis unless those fields and calculations are actually added to the project.
