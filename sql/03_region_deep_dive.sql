-- Regional FP&A Deep Dive
-- Uses only fields already referenced by the original project.

WITH regional AS (
    SELECT
        r.region_name,
        SUM(b.budgeted_revenue) AS budget_revenue,
        SUM(b.actual_revenue) AS actual_revenue,
        SUM(b.budgeted_cost) AS budget_cost,
        SUM(b.actual_cost) AS actual_cost
    FROM public.budget_actuals b
    JOIN public.regions r ON b.region_id = r.region_id
    GROUP BY r.region_name
), metrics AS (
    SELECT
        *,
        actual_revenue - budget_revenue AS revenue_variance,
        actual_cost - budget_cost AS cost_variance,
        actual_revenue - actual_cost AS gross_profit
    FROM regional
)
SELECT
    region_name,
    budget_revenue,
    actual_revenue,
    revenue_variance,
    ROUND(100.0 * revenue_variance / NULLIF(budget_revenue, 0), 2) AS revenue_variance_pct,
    budget_cost,
    actual_cost,
    cost_variance,
    ROUND(100.0 * cost_variance / NULLIF(budget_cost, 0), 2) AS cost_variance_pct,
    gross_profit,
    ROUND(100.0 * gross_profit / NULLIF(actual_revenue, 0), 2) AS gross_margin_pct,
    RANK() OVER (ORDER BY gross_profit DESC) AS profit_rank
FROM metrics
ORDER BY gross_profit DESC;
