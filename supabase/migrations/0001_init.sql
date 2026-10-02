create table if not exists assets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  asset_code text unique,
  location text,
  category text,
  status text default 'active',
  created_at timestamptz not null default now()
);

create table if not exists maintenance_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  asset_id uuid references assets(id) on delete set null,
  title text not null,
  description text,
  priority text default 'medium',
  status text default 'open',
  photo_url text,
  assigned_to text,
  ai_priority text,
  ai_priority_source text,
  ai_priority_confidence numeric,
  ai_priority_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

create table if not exists preventive_schedules (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  asset_id uuid references assets(id) on delete set null,
  task_name text not null,
  frequency_days int,
  last_done_date date,
  next_due_date date,
  created_at timestamptz not null default now()
);

create table if not exists spare_parts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  part_number text,
  stock_qty int default 0,
  reorder_threshold int default 0,
  unit_cost numeric,
  created_at timestamptz not null default now()
);

create table if not exists vendors (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  contact_person text,
  phone text,
  email text,
  service_category text,
  created_at timestamptz not null default now()
);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  tool_name text,
  actor_user_id uuid,
  target_entity text,
  target_id uuid,
  action_detail jsonb,
  risk_level text,
  approved_by uuid,
  created_at timestamptz not null default now()
);

alter table assets enable row level security;
alter table maintenance_requests enable row level security;
alter table preventive_schedules enable row level security;
alter table spare_parts enable row level security;
alter table vendors enable row level security;
alter table audit_logs enable row level security;

drop policy if exists "assets_v1_read" on assets;
create policy "assets_v1_read" on assets for select using (true);
drop policy if exists "assets_v1_write" on assets;
create policy "assets_v1_write" on assets for all using (true) with check (true);

drop policy if exists "maintenance_requests_v1_read" on maintenance_requests;
create policy "maintenance_requests_v1_read" on maintenance_requests for select using (true);
drop policy if exists "maintenance_requests_v1_write" on maintenance_requests;
create policy "maintenance_requests_v1_write" on maintenance_requests for all using (true) with check (true);

drop policy if exists "preventive_schedules_v1_read" on preventive_schedules;
create policy "preventive_schedules_v1_read" on preventive_schedules for select using (true);
drop policy if exists "preventive_schedules_v1_write" on preventive_schedules;
create policy "preventive_schedules_v1_write" on preventive_schedules for all using (true) with check (true);

drop policy if exists "spare_parts_v1_read" on spare_parts;
create policy "spare_parts_v1_read" on spare_parts for select using (true);
drop policy if exists "spare_parts_v1_write" on spare_parts;
create policy "spare_parts_v1_write" on spare_parts for all using (true) with check (true);

drop policy if exists "vendors_v1_read" on vendors;
create policy "vendors_v1_read" on vendors for select using (true);
drop policy if exists "vendors_v1_write" on vendors;
create policy "vendors_v1_write" on vendors for all using (true) with check (true);

drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into assets (id, name, asset_code, location, category, status) values
  ('a1000000-0000-0000-0000-000000000001', 'HVAC Rooftop Unit 1', 'HVAC-01', 'Rooftop', 'Cooling', 'active'),
  ('a1000000-0000-0000-0000-000000000002', 'Water Pump Basement', 'PUMP-02', 'Basement', 'Plumbing', 'active'),
  ('a1000000-0000-0000-0000-000000000003', 'Elevator A', 'ELEV-01', 'Lobby', 'Vertical Transport', 'active'),
  ('a1000000-0000-0000-0000-000000000004', 'Diesel Generator', 'GEN-01', 'Mechanical Room', 'Power', 'active');

insert into maintenance_requests (id, asset_id, title, description, priority, status, assigned_to) values
  ('b1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'AC unit leaking water', 'Water pooling under indoor unit on 3rd floor.', 'high', 'open', 'Tech Raj'),
  ('b1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', 'Pump making unusual noise', 'Grinding sound from basement pump during startup.', 'medium', 'in_progress', 'Tech Priya'),
  ('b1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003', 'Elevator door not closing', 'Passenger elevator door stays open intermittently.', 'high', 'open', null),
  ('b1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000004', 'Generator monthly service', 'Routine monthly check and oil change.', 'low', 'resolved', 'Tech Raj');

insert into preventive_schedules (id, asset_id, task_name, frequency_days, last_done_date, next_due_date) values
  ('c1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'Filter replacement', 90, '2025-01-15', '2025-04-15'),
  ('c1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', 'Seal inspection', 180, '2024-12-01', '2025-06-01'),
  ('c1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000004', 'Oil and filter change', 30, '2025-02-20', '2025-03-22');

insert into spare_parts (id, name, part_number, stock_qty, reorder_threshold, unit_cost) values
  ('d1000000-0000-0000-0000-000000000001', 'HVAC Air Filter 24x24', 'FLT-2424', 8, 5, 320.00),
  ('d1000000-0000-0000-0000-000000000002', 'Pump Mechanical Seal', 'SEAL-M12', 2, 4, 1500.00),
  ('d1000000-0000-0000-0000-000000000003', 'Elevator Door Sensor', 'SNR-ELV1', 1, 2, 4500.00),
  ('d1000000-0000-0000-0000-000000000004', 'Generator Oil Filter', 'OIL-GEN01', 12, 6, 850.00);

insert into vendors (id, name, contact_person, phone, email, service_category) values
  ('e1000000-0000-0000-0000-000000000001', 'CoolAir Services', 'Anil Kumar', '+91 98765 43210', 'anil@coolair.in', 'HVAC'),
  ('e1000000-0000-0000-0000-000000000002', 'PumpTech Solutions', 'Meera Singh', '+91 98123 45678', 'meera@pumptech.in', 'Plumbing'),
  ('e1000000-0000-0000-0000-000000000003', 'ElevateCare', 'Sunil Rao', '+91 99000 11223', 'sunil@elevatecare.in', 'Elevators');