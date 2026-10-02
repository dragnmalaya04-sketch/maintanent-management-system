# Maintenance Management System — PRD

## Problem
Maintenance teams (technicians, supervisors, assistant managers) track assets, schedules, breakdowns, spare parts, and vendors across scattered spreadsheets and paper. Response is slow because intake, assignment, and status live nowhere connected.

## Target User
- **Technician** — logs issues, updates status, checks spare parts.
- **Supervisor** — assigns jobs, reviews preventive schedule, tracks completion.
- **Assistant Manager** — oversees asset register, vendor list, reporting.

## Core Objects (v1)
- **Asset** — machine/equipment being maintained.
- **Maintenance Request** — the single intake form (replaces Google Form). Captures issue, asset, priority, requester.
- **Preventive Schedule** — recurring maintenance plan per asset.
- **Spare Part** — inventory item with qty + reorder threshold.
- **Vendor** — external service provider.

## MVP (v1) Checklist
- [ ] Maintenance request intake form (asset select, issue text, priority, photo upload)
- [ ] Request list with status (open → in-progress → resolved)
- [ ] Asset CRUD with QR/ID and location
- [ ] Preventive schedule list (next-due date per asset)
- [ ] Spare part inventory list with stock count + reorder flag
- [ ] Vendor directory
- [ ] All screens viewable without login (demo data seeded)
- [ ] Responsive sidebar nav (desktop) / hamburger (mobile)

## Non-Goals (v1)
- Work orders (deliberately excluded)
- Authentication / per-user isolation (later lock-down sprint)
- WhatsApp / Sheets integration (later sprint)
- Manpower planning module

## Success Criteria
A technician opens the app on their phone, taps "New Request", selects an asset, types "AC unit leaking", picks priority High, and submits. The request appears instantly in the request list with status "Open". A supervisor sees it, changes status to "In Progress", then "Resolved". The whole flow persists to the database and survives a refresh — no dead buttons, no seed-only screens.