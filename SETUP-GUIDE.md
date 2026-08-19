# RSVP System Setup — Deshani & Chalitha

You'll do this once. Takes about 10 minutes.

## 1. Create the Supabase project

1. Go to https://supabase.com → sign in (or sign up, free tier is enough for this)
2. **New project** → name it something like `deshani-chalitha-rsvp` → pick a database password (save it somewhere) → pick the region closest to Sri Lanka (Singapore) → Create

Wait ~2 minutes for it to spin up.

## 2. Create the table

1. In your new project, open **SQL Editor** (left sidebar)
2. **New query**
3. Open `schema.sql` from this folder, copy all of it, paste it in, click **Run**

This creates the `guests` table and turns on Realtime (so the admin dashboard updates live).

## 3. Import the Groom's list

1. Left sidebar → **Table Editor** → select the `guests` table
2. Click **Insert** → **Import data from CSV**
3. Upload `guests-groom-import.csv` (already in this folder — all 76 of your Groom's side guests, ready to go)
4. Confirm the column mapping matches (`name`, `title`, `invited_count`, `side`) → Import

You can do the exact same thing later for the Bride's list once you have it — just make a CSV with the same 4 columns (`name`, `title`, `invited_count`, `side`, using `side = bride`) and import it the same way. No rebuild needed.

## 4. Get your API keys

1. Left sidebar → **Project Settings** → **API**
2. Copy the **Project URL**
3. Copy the **anon public** key (NOT the `service_role` one — that one is dangerous to expose in a browser file)

## 5. Plug the keys into both files

Open `rsvp.html` and `admin.html` in a text editor, and near the top of each `<script>` block replace:

```js
const SUPABASE_URL = "YOUR_SUPABASE_URL";
const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
```

with your actual values from step 4. Same two lines in both files.

## 6. Set your admin password

In `admin.html`, find:

```js
const ADMIN_PASSWORD = "CHANGE_ME";
```

Change `CHANGE_ME` to whatever password you want to use to view the live dashboard. This isn't bank-grade security — anyone with the password and the link can see and edit the guest list — so just don't post the admin link publicly.

## 7. Deploy

Upload this whole folder (`rsvp.html`, `admin.html`, `supabase.umd.js`) to Netlify/Vercel/GitHub Pages — same way as the wedding invite itself.

You'll end up with three links:

| Purpose | Link |
|---|---|
| Groom's side RSVP | `yoursite.com/rsvp.html?side=groom` |
| Bride's side RSVP | `yoursite.com/rsvp.html?side=bride` |
| Live dashboard (for you) | `yoursite.com/admin.html` |

Send the two RSVP links to Deshani and Chalitha respectively to distribute to their sides. Keep the admin link to yourself.

## What the dashboard shows

- Live counts: guest entries, total invited, confirmed headcount, liquor count, declined, not yet responded — all filterable by All / Bride / Groom
- Full guest table with inline edit, delete, and "reset RSVP" per person
- Add-guest form (for adding people one at a time, e.g. late additions)
- CSV export button, for sending a snapshot to the catering team

It updates live — no refresh needed — because of the Realtime subscription set up in the schema.
