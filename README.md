# Our Finance — household finance app starter

This is a mobile-first React/PWA starter for a household with two separate logins (iPhone + Android), one shared Supabase/PostgreSQL database, A–F main-category and subcategory dropdowns, and a transaction ledger.

## Included
- Responsive phone-friendly interface, installable as a home-screen web app.
- Email/password sign-up and sign-in using Supabase Auth.
- First user creates a household; second user joins with an invite code.
- Shared transaction database with row-level security.
- Every transaction stores the authenticated user ID.
- A–F dropdown categories, including separate Full-time Maid, Cleaning Maid, Car Washer and Herbalife Shake subcategories.
- Income, expense, investment, debt payment, transfer and refund transaction types.
- Monthly totals and a transaction list with person filter.
- Rule-based category suggestions; no LLM API is used in this first version.

## Important: this is not yet a live deployed app
It is the application source and database setup. To connect both phones, a Supabase project and a frontend deployment are required. I cannot create accounts or deploy into your personal cloud services without your explicit access/setup. Do not enter real financial data until setup and access rules have been checked.

## Setup
1. Create a project at https://supabase.com.
2. In Supabase SQL Editor, run all of `supabase/schema.sql`.
3. In Supabase Authentication settings, configure email sign-in and your preferred email-confirmation policy.
4. Copy the Project URL and public anon/publishable key from Project Settings → API.
5. Copy `.env.example` to `.env` and fill `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`.
6. Install Node.js LTS, then run:
   ```bash
   npm install
   npm run dev
   ```
7. Deploy the project to a static host (for example, Vercel or Netlify) and add the same environment variables to its project settings.
8. Open the deployed URL on the first phone, create an account and create the household. Share the invite code. On the second phone, create a separate account and join with that code.
9. iPhone: Safari → Share → Add to Home Screen. Android: Chrome → menu → Install app / Add to Home Screen.

## Category outline
A. Kitchen & Food: Monthly Ration / Bulk Grocery; Daily Food & Dairy; Outside Food & Dining.
B. Personal & Household: Personal Care; Household Cleaning; Household Supplies; Clothing & Footwear; Medical & Healthcare; Herbalife Shake (separate); Other Nutrition Products; Child Expenses; Home Maintenance; Domestic Help – Full-time Maid; Cleaning Maid; Car Washer; Cook; Other.
C. Vehicle & Transportation: Petrol; Diesel; EV Charging / Car Electricity; Servicing; Insurance; Tyres & Repairs; FASTag / Toll; Parking; Public Transport / Taxi.
D. Home Bills & Utilities: Electricity; Water; Gas; Broadband; Mobile; DTH/Cable; Society Maintenance.
E. Lifestyle & Miscellaneous: Shopping; Entertainment; Travel & Holidays; Gifts; Subscriptions; Donations; Other.
F. Financial Commitments: Loan EMIs; Life/Health Insurance; PPF; Mutual Funds/SIP; Stocks; FD/RD; Taxes; Other Investment.

## Privacy and security defaults
The included SQL allows both household members to read all household transactions, while each member can insert transactions as themselves and update/delete only their own entries. This is the shared-visibility option. If you prefer private individual transactions with only combined totals shared, the RLS policies and reporting design must be changed before entering real data. Never put a Supabase service-role key or an LLM API secret in frontend code. No bank credentials, card numbers or PINs are collected.

## Next development items
- Edit/delete transaction UI and recurring bills.
- Separate person-wise analytics and combined dashboard refinements.
- Budget, assets, liabilities and goal modules.
- Server-side AI monthly analysis via an Edge Function, only after deciding the privacy policy and data minimisation rules.
