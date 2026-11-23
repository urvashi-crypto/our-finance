# Our Finance v2 — household finance app

This is an updated React/PWA source package for the existing Our Finance Supabase project.

## v2 changes
- Loads all household transactions in pages of 500; no silent 500-row cutoff.
- Shows a visible database error and retry action instead of silently replacing failed reads with an empty list.
- Uses India/local calendar dates for the default entry date and exact month start/end boundaries.
- Adds Family Overview, My Expenses and Husband's Expenses views.
- Adds person-wise monthly totals and separate totals for Income, Expense, Investment, Debt Payment, Refund and Transfer.
- Keeps transfers separate from consumption spending.
- Adds transaction editing and deletion for the signed-in user's own records (subject to existing RLS).
- Prevents repeated form submissions while saving and only confirms after Supabase confirms the write.
- Retains the existing category dropdowns and local category suggestions.

## Important deployment notes
1. This package is intended to replace the source in the existing GitHub repository connected to Vercel. Do not create a new Supabase project.
2. Keep the existing Vercel environment variables `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. The URL must be the project base URL, not `/rest/v1/`; the key must be the public anon/publishable key, never `service_role`.
3. Before deploying, keep a copy of the current GitHub branch so rollback is possible.
4. In Supabase SQL Editor, run `supabase/upgrade_v2.sql`. It is additive: it grants the app-role permissions already needed by the UI and creates indexes; it does not delete or rewrite existing data.
5. Commit/push the updated source to the same GitHub repository and let Vercel deploy. Verify the deployment URL before using it.
6. Test with small test entries from both household accounts before importing or entering a full month's records.

## Existing data
The migration does not drop tables, truncate rows, recreate households, or reset accounts. The app reads existing `households`, `household_members`, and `transactions` tables.

## Current limitations to review before production use
- The month selector currently controls the overview; the transaction ledger shows all loaded transactions with pagination.
- The household view assumes two members for the labels “My Expenses” and “Husband's Expenses”; the partner view means the other household member, not a fixed gender identity in the database.
- Transfers are displayed separately and excluded from the monthly position calculation. Refunds are displayed separately; they are not automatically netted against the original expense because the database has no original-transaction linkage.
- This app is a household ledger, not a bank reconciliation or tax/accounting system.
