-- Enterprise FP&A Dashboard
-- Advanced Financial Analysis Layer
-- Source table: public.budget_actuals
-- Verified columns from the existing project SQL:
-- actual_revenue, actual_cost, budgeted_revenue, budgeted_cost, region_id

-- 1. Executive financial KPI pack
SELECT
    SUM(actual_revenue) AS actual_revenue,
    SUM(budgeted_revenue) AS budgeted_revenue,
    SUM(actual_cost) AS actual_cost,
    SUM(budgeted_cost) AS budgeted_cost,
    SUM(actual_revenue - actual_cost) AS actual_gross_profit,
    SUM(budgeted_revenue - budgeted_cost) AS budgeted_gross_profit,
    ROUND(100.0 * SUM(actual_revenue - actual_cost) / NULLIF(SUM(actual_revenue), 0), 2) AS actual_gross_margin_pct,
    ROUND(100.0 * SUM(budgeted_revenue - budgeted_cost) / NULLIF(SUM(budgeted_revenue), 0), 2) AS budgeted_gross_margin_pct,
    ROUND(100.0 * SUM(actual_revenue - budgeted_revenue) / NULLIF(SUM(budgeted_revenue), 0), 2) AS revenue_variance_pct,
    ROUND(100.0 * SUM(actual_cost - budgeted_cost) / NULLIF(SUM(budgeted_cost), 0), 2) AS cost_variance_pct
FROM public.budget_actuals;


-- 2. Budget attainment and gross-profit variance
SELECT
    SUM(budgeted_revenue) AS budgeted_revenue,
    SUM(actual_revenue) AS actual_revenue,
    SUM(actual_revenue - budgeted_revenue) AS revenue_variance,
    ROUND(100.0 * SUM(actual_revenue) / NULLIF(SUM(budgeted_revenue), 0), 2) AS revenue_budget_attainment_pct,
    SUM(budgeted_revenue - budgeted_cost) AS budgeted_gross_profit,
    SUM(actual_revenue - actual_cost) AS actual_gross_profit,
    SUM((actual_revenue - actual_cost) - (budgeted_revenue - budgeted_cost)) AS gross_profit_variance
FROM public.budget_actuals;


-- 3. Favorable / unfavorable classification
-- Revenue: actual above budget is favorable.
-- Cost: actual below budget is favorable.
SELECT
    CASE
        WHEN SUM(actual_revenue - budgeted_revenue) >= 0 THEN 'Favorable'
        ELSE 'Unfavorable'
    END AS revenue_variance_status,
    CASE
        WHEN SUM(actual_cost - budgeted_cost) <= 0 THEN 'Favorable'
        ELSE 'Unfavorable'
    END AS cost_variance_status,
    CASE
        WHEN SUM((actual_revenue - actual_cost) - (budgeted_revenue - budgeted_cost)) >= 0 THEN 'Favorable'
        ELSE 'Unfavorable'
    END AS gross_profit_variance_status
FROM public.budget_actuals;


-- 4. Regional profitability and margin ranking
WITH regional AS (
    SELECT
        r.region_name,
        SUM(b.budgeted_revenue) AS budgeted_revenue,
        SUM(b.actual_revenue) AS actual_revenue,
        SUM(b.budgeted_cost) AS budgeted_cost,
        SUM(b.actual_cost) AS actual_cost,
        SUM(b.actual_revenue - b.actual_cost) AS gross_profit
    FROM public.budget_actuals b
    JOIN public.regions r ON b.region_id = r.region_id
    GROUP BY r.region_name
)
SELECT
    region_name,
    budgeted_revenue,
    actual_revenue,
    actual_revenue - budgeted_revenue AS revenue_variance,
    ROUND(100.0 * (actual_revenue - budgeted_revenue) / NULLIF(budgeted_revenue, 0), 2) AS revenue_variance_pct,
    actual_cost,
    actual_cost - budgeted_cost AS cost_variance,
    gross_profit,
    ROUND(100.0 * gross_profit / NULLIF(actual_revenue, 0), 2) AS gross_margin_pct,
    RANK() OVER (ORDER BY gross_profit DESC) AS gross_profit_rank
FROM regional
ORDER BY gross_profit_rank;


-- 5. Largest regional revenue shortfalls / overruns
WITH regional AS (
    SELECT
        r.region_name,
        SUM(b.budgeted_revenue) AS budgeted_revenue,
        SUM(b.actual_revenue) AS actual_revenue,
        SUM(b.budgeted_cost) AS budgeted_cost,
        SUM(b.actual_cost) AS actual_cost
    FROM public.budget_actuals b
    JOIN public.regions r ON b.region_id = r.region_id
    GROUP BY r.region_name
)
SELECT
    region_name,
    actual_revenue - budgeted_revenue AS revenue_variance,
    ROUND(100.0 * (actual_revenue - budgeted_revenue) / NULLIF(budgeted_revenue, 0), 2) AS revenue_variance_pct,
    actual_cost - budgeted_cost AS cost_variance,
    ROUND(100.0 * (actual_cost - budgeted_cost) / NULLIF(budgeted_cost, 0), 2) AS cost_variance_pct,
    CASE
        WHEN actual_revenue < budgeted_revenue THEN 'Revenue Shortfall'
        WHEN actual_cost > budgeted_cost THEN 'Cost Overrun'
        ELSE 'Within Target'
    END AS exception_type
FROM regional
ORDER BY ABS(actual_revenue - budgeted_revenue) DESC;


-- 6. Data-quality checks before financial reporting
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE actual_revenue IS NULL) AS null_actual_revenue,
    COUNT(*) FILTER (WHERE actual_cost IS NULL) AS null_actual_cost,
    COUNT(*) FILTER (WHERE budgeted_revenue IS NULL) AS null_budgeted_revenue,
    COUNT(*) FILTER (WHERE budgeted_cost IS NULL) AS null_budgeted_cost,
    COUNT(*) FILTER (WHERE actual_revenue < 0) AS negative_actual_revenue_rows,
    COUNT(*) FILTER (WHERE actual_cost < 0) AS negative_actual_cost_rows,
    COUNT(*) FILTER (WHERE budgeted_revenue < 0) AS negative_budget_revenue_rows,
    COUNT(*) FILTER (WHERE budgeted_cost < 0) AS negative_budget_cost_rows
FROM public.budget_actuals;


-- 7. Financial control check: gross profit reconciliation
SELECT
    SUM(actual_revenue) - SUM(actual_cost) AS calculated_gross_profit,
    SUM(actual_revenue - actual_cost) AS row_level_gross_profit,
    ROUND(
        (SUM(actual_revenue) - SUM(actual_cost)) - SUM(actual_revenue - actual_cost),
        2
    ) AS reconciliation_difference
FROM public.budget_actuals;
