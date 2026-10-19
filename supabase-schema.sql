create table if not exists public.user_workouts (
  user_id uuid primary key references auth.users (id) on delete cascade,
  data jsonb not null default '{"version":3,"weights":{},"sessions":{},"routines":[],"activeRoutineId":"default"}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.user_workouts enable row level security;

revoke all on public.user_workouts from public, anon;
grant usage on schema public to authenticated;
grant select, insert, update on public.user_workouts to authenticated;

drop policy if exists "Users can read their own workout data" on public.user_workouts;
create policy "Users can read their own workout data"
  on public.user_workouts for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own workout data" on public.user_workouts;
create policy "Users can create their own workout data"
  on public.user_workouts for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own workout data" on public.user_workouts;
create policy "Users can update their own workout data"
  on public.user_workouts for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
