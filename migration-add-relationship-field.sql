-- ============================================================
-- Adds the "relationship" field used by the RSVP Management
-- Excel report (Member / Wife / Husband / Family / Guest / …).
-- Run once in Supabase: Project → SQL Editor → New query → Run.
-- Safe to run even if the column already exists.
-- ============================================================

alter table guests add column if not exists relationship text;

-- No default value — existing rows are left blank ("Other / Blank"
-- in the report) until set from the Admin Panel's Add/Edit Guest
-- form or a guest-list import that includes a "relationship" column.
