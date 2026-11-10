-- Singular test: returns rows that violate our business rule.
-- A test passes if and only if this query returns 0 rows.
select
    order_id,
    total_amount_dollars
from {{ ref('fct_orders') }}
where total_amount_dollars < 0

