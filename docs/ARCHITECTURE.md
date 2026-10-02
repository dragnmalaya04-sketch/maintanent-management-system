# Architecture

## Stack
- **Next.js 15** (App Router, RSC) + **Tailwind CSS**
- **Supabase** (Postgres + RLS + storage for photos)
- **Vercel** deployment

## Build Now vs Later
**Now (v1):** asset CRUD, request intake form + list, preventive schedule list, spare parts list, vendor directory — all open/no-auth with seeded demo data.
**Later:** auth + per-user RLS, work orders, WhatsApp/Sheets export, AI-assisted triage, manpower planning.

## Key User Action Flow (Request Intake)
1. User opens app → lands on Requests page (seed data visible).
2. Taps "New Request" → form renders (asset dropdown from DB, issue text, priority, photo).
3. Submits → row inserted into `maintenance_requests`, status defaults `open`.
4. List refreshes, new request appears at top with "Open" badge.
5. Supervisor changes status → `in_progress` → `resolved` (each persists).

## Responsive Nav Shell
Persistent left sidebar on desktop (Assets, Requests, Schedule, Parts, Vendors); collapses to hamburger menu on mobile. Current section highlighted.

## Layer Plan
1. **Data layer** (`lib/data/`) — all Supabase reads/writes, typed queries.
2. **App logic** (`lib/actions/`) — server actions for create/update.
3. **UI** (`components/`) — forms, tables, badges; calls data layer only.
4. **AI** (`lib/ai/`) — later: auto-priority, spare-part suggestion, triage.

## Why Core Runs Without AI
Every action (create request, update status, CRUD asset/parts/vendors) is plain DB CRUD. AI adds triage scoring and drafting later — the app is fully functional without it.

## Repo Structure
```
app/
  assets/
  requests/
  schedule/
  parts/
  vendors/
  layout.tsx (sidebar shell)
components/
lib/
  data/        (DB access)
  actions/     (server actions)
  ai/          (later)
  types.ts
tests/
```

## Module Map
| Module | Responsibility | Owns | Build Order |
|---|---|---|---|
| assets | Asset register CRUD | assets table | 1 |
| requests | Intake form + status list | maintenance_requests table | 2 |
| schedule | Preventive plan list | preventive_schedules table | 3 |
| parts | Spare part inventory | spare_parts table | 4 |
| vendors | Vendor directory | vendors table | 5 |
| nav | Sidebar/hamburger shell | — | 0 |