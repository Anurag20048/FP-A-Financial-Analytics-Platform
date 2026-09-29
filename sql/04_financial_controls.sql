-- Financial reporting control queries
-- Run before publishing a management report.

-- A. Check for nulls and negative values
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE actual_revenue IS NULL OR actual_cost IS NULL) AS incomplete_actual_rows,
    COUNT(*) FILTER (WHERE budgeted_revenue IS NULL OR budgeted_cost IS NULL) AS incomplete_budget_rows,
    COUNT(*) FILTER (WHERE actual_revenue < 0 OR actual_cost < 0) AS negative_actual_rows,
    COUNT(*) FILTER (WHERE budgeted_revenue < 0 OR budgeted_cost < 0) AS negative_budget_rows
FROM public.budget_actuals;

-- B. Check budget/actual reconciliation
SELECT
    ROUND(SUM(actual_revenue - actual_cost), 2) AS gross_profit_from_rows,
    ROUND(SUM(actual_revenue) - SUM(actual_cost), 2) AS gross_profit_from_totals,
    ROUND(SUM(actual_revenue - actual_cost) - (SUM(actual_revenue) - SUM(actual_cost)), 2) AS difference
FROM public.budget_actuals;

-- C. Check region referential coverage
SELECT COUNT(*) AS unmatched_region_rows
FROM public.budget_actuals b
LEFT JOIN public.regions r ON b.region_id = r.region_id
WHERE r.region_id IS NULL;
