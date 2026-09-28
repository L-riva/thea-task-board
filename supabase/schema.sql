-- Thea Task Board: database setup.
-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists public.tasks (
  id          uuid primary key default gen_random_uuid(),
  title       text not null,
  type        text not null default '',
  owner       text not null default '',
  status      text not null default 'todo' check (status in ('todo','doing','blocked','done')),
  start_date  date not null,
  due_date    date not null,
  notes       text not null default '',
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  updated_by  text
);

-- Nobody reads or writes without a login. Sign-ups are closed in the Auth
-- settings, so "authenticated" means "someone you invited".
alter table public.tasks enable row level security;

drop policy if exists "team reads"   on public.tasks;
drop policy if exists "team inserts" on public.tasks;
drop policy if exists "team updates" on public.tasks;
drop policy if exists "team deletes" on public.tasks;

create policy "team reads"   on public.tasks for select to authenticated using (true);
create policy "team inserts" on public.tasks for insert to authenticated with check (true);
create policy "team updates" on public.tasks for update to authenticated using (true) with check (true);
create policy "team deletes" on public.tasks for delete to authenticated using (true);

-- Live updates: when one person saves, everyone else's board refreshes.
-- (If this line errors because the table is already in the publication, ignore it.)
alter publication supabase_realtime add table public.tasks;
