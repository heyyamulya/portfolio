-- amulya.os: shared visit counter + guestbook
-- Run this once in Supabase → SQL Editor → New query → Run.
-- Visitors can add a visit, sign the guestbook, and read names + dates.
-- Emails are stored for you only: the public (anon) key can never read them.

create table if not exists public.visits (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now()
);

create table if not exists public.guestbook (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 1 and 60),
  email text check (email is null or char_length(email) <= 120),
  created_at timestamptz not null default now()
);

alter table public.visits enable row level security;
alter table public.guestbook enable row level security;

create policy "anyone can log a visit" on public.visits for insert to anon with check (true);
create policy "anyone can count visits" on public.visits for select to anon using (true);
create policy "anyone can sign the guestbook" on public.guestbook for insert to anon with check (true);
create policy "anyone can read the guestbook" on public.guestbook for select to anon using (true);

-- column-level privacy: anon may read names and dates, never emails
revoke select on public.guestbook from anon;
grant select (id, name, created_at) on public.guestbook to anon;
revoke insert on public.guestbook from anon;
grant insert (name, email) on public.guestbook to anon;
