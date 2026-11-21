-- Our Finance v2: safe additive migration.
-- Does not delete or rewrite existing household or transaction data.
-- Run once in Supabase SQL Editor.

-- Ensure the authenticated app role can perform the operations used by the UI.
GRANT SELECT ON TABLE public.households TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.household_members TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.transactions TO authenticated;

-- Support the household/date and person/date query patterns used by the app.
CREATE INDEX IF NOT EXISTS tx_household_date_created_idx
  ON public.transactions (household_id, transaction_date DESC, created_at DESC);
CREATE INDEX IF NOT EXISTS tx_household_user_date_idx
  ON public.transactions (household_id, user_id, transaction_date DESC);

-- Helpful for membership lookup by signed-in user.
CREATE INDEX IF NOT EXISTS household_members_user_idx
  ON public.household_members (user_id);

-- Verify existing transaction types without changing historical data.
SELECT transaction_type, COUNT(*) AS records, SUM(amount) AS total_amount
FROM public.transactions
GROUP BY transaction_type
ORDER BY transaction_type;
