# Recommended Power BI DAX Measures

The supplied PBIX already contains the dashboard. The measures below are an advanced measure pack aligned with the verified `budget_actuals` fields. Add them to the corresponding Power BI model if those table/column names match the PBIX model.

```DAX
Actual Revenue = SUM(budget_actuals[actual_revenue])

Budget Revenue = SUM(budget_actuals[budgeted_revenue])

Actual Cost = SUM(budget_actuals[actual_cost])

Budget Cost = SUM(budget_actuals[budgeted_cost])

Actual Gross Profit = [Actual Revenue] - [Actual Cost]

Budget Gross Profit = [Budget Revenue] - [Budget Cost]

Revenue Variance = [Actual Revenue] - [Budget Revenue]

Revenue Variance % = DIVIDE([Revenue Variance], [Budget Revenue])

Cost Variance = [Actual Cost] - [Budget Cost]

Cost Variance % = DIVIDE([Cost Variance], [Budget Cost])

Gross Profit Variance = [Actual Gross Profit] - [Budget Gross Profit]

Actual Gross Margin % = DIVIDE([Actual Gross Profit], [Actual Revenue])

Budget Gross Margin % = DIVIDE([Budget Gross Profit], [Budget Revenue])

Revenue Budget Attainment % = DIVIDE([Actual Revenue], [Budget Revenue])

Revenue Variance Status =
IF([Revenue Variance] >= 0, "Favorable", "Unfavorable")

Cost Variance Status =
IF([Cost Variance] <= 0, "Favorable", "Unfavorable")

Gross Profit Variance Status =
IF([Gross Profit Variance] >= 0, "Favorable", "Unfavorable")
```

These measures should be validated against the actual PBIX model before deployment because the PBIX model schema cannot be inferred solely from the repository's SQL files.
