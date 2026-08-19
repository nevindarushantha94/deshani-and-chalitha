-- ============================================================
-- Migration: add guest_message column
-- Your `guests` table already exists in Supabase, so run this
-- once instead of the full schema.sql (that one is only for
-- brand-new setups).
--
-- Supabase → SQL Editor → New query → paste this → Run
-- ============================================================

alter table guests add column if not exists guest_message text;

-- No RLS changes needed — the existing "public can update guests"
-- policy already covers every column, including this new one.
