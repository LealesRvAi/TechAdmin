-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run

create table if not exists work_orders (
  id uuid primary key default gen_random_uuid(),
  wo_number text,
  customer_name text not null,
  customer_phone text,
  customer_city text,
  vehicle text,
  vin text,
  plate text,
  odometer text,
  created_at timestamptz not null default now()
);

create table if not exists job_lines (
  id uuid primary key default gen_random_uuid(),
  work_order_id uuid not null references work_orders(id) on delete cascade,
  line_no int not null default 1,
  title text not null,
  status text not null default 'not_started'
    check (status in ('not_started','in_progress','waiting_parts','done')),
  notes text default '',
  updated_by text,
  updated_at timestamptz default now()
);

create table if not exists job_photos (
  id uuid primary key default gen_random_uuid(),
  job_line_id uuid not null references job_lines(id) on delete cascade,
  path text not null,
  uploaded_by text,
  created_at timestamptz not null default now()
);

-- Lock every table: only signed-in users can touch anything
alter table work_orders enable row level security;
alter table job_lines   enable row level security;
alter table job_photos  enable row level security;

create policy "signed-in full access" on work_orders for all to authenticated using (true) with check (true);
create policy "signed-in full access" on job_lines   for all to authenticated using (true) with check (true);
create policy "signed-in full access" on job_photos  for all to authenticated using (true) with check (true);

-- Private photo bucket (not public; the page uses short-lived signed links)
insert into storage.buckets (id, name, public)
values ('job-photos', 'job-photos', false)
on conflict (id) do nothing;

create policy "signed-in photo access" on storage.objects
  for all to authenticated
  using (bucket_id = 'job-photos')
  with check (bucket_id = 'job-photos');
