-- ============================================================
-- Deshani & Chalitha — RSVP database schema
-- Run this once in Supabase: Project → SQL Editor → New query → Run
-- ============================================================

create table if not exists guests (
  id uuid primary key default gen_random_uuid(),
  side text not null check (side in ('bride','groom')),
  title text,                          -- Mr / Ms / Mrs (optional, from your list)
  name text not null,
  invited_count int not null default 1,          -- how many this guest can bring
  rsvp_status text check (rsvp_status in ('yes','no')),   -- null = not responded yet
  attending_count int,                            -- how many are actually coming
  liquor text check (liquor in ('yes','no')),
  guest_message text,                             -- optional personal note left with the RSVP
  responded_at timestamptz,
  created_at timestamptz not null default now()
);

-- fast name search for the RSVP search box
create index if not exists guests_name_idx on guests using gin (to_tsvector('simple', name));
create index if not exists guests_side_idx on guests (side);

-- Row Level Security — required by Supabase before the anon (public) key
-- can touch the table. Kept simple/open on purpose (same pattern as your
-- other tools): the RSVP page and admin dashboard are both gated by
-- knowing the right link / admin password, not by database-level auth.
alter table guests enable row level security;

create policy "public can read guests"
  on guests for select
  using (true);

create policy "public can insert guests"
  on guests for insert
  with check (true);

create policy "public can update guests"
  on guests for update
  using (true)
  with check (true);

create policy "public can delete guests"
  on guests for delete
  using (true);

-- ============================================================
-- Enable Realtime so the admin dashboard updates live as RSVPs
-- come in (Supabase → Database → Replication → toggle "guests" on,
-- or run the line below):
-- ============================================================
alter publication supabase_realtime add table guests;
