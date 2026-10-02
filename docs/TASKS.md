# Tasks

## Sprint 1 — Foundation + Asset CRUD
**Goal:** Database, nav shell, asset register working end-to-end.
- [ ] Set up Next.js + Tailwind + Supabase client
- [ ] Create migration SQL, run on Supabase
- [ ] Build responsive sidebar nav (desktop) / hamburger (mobile)
- [ ] `lib/data/assets.ts` — CRUD queries
- [ ] Asset list page (loading, empty, error, ready states)
- [ ] Asset create/edit form → persists to DB
- [ ] Seed demo assets
- **DoD:** Create, edit, delete an asset in the browser; survives refresh.

## Sprint 2 — Request Intake Engine (v1 functional milestone)
**Goal:** The core workflow — maintenance request form + status list.
- [ ] `lib/data/requests.ts` — CRUD + status update
- [ ] New request form (asset dropdown, issue text, priority, photo)
- [ ] Request list with status badges + sorting
- [ ] Status change (open → in_progress → resolved) — persists
- [ ] Seed demo requests
- **DoD:** Technician submits a request, it appears in the list, supervisor changes status — all persists. **This is the v1 success scenario.**

## Sprint 3 — Schedule, Parts, Vendors
**Goal:** Complete the five core modules.
- [ ] Preventive schedule list + create form (next_due_date auto-calc)
- [ ] Spare parts list with reorder flag + stock edit
- [ ] Vendor directory + create form
- [ ] Seed demo rows for all three
- **DoD:** All five sections render with real data; CRUD works on each.

## Sprint 4 — Intelligence + Polish
**Goal:** Rule-based priority suggestions, overdue/reorder flags, empty/error states everywhere.
- [ ] `lib/ai/priority.ts` — keyword-based priority suggestion on submit
- [ ] Store ai_priority + source + confidence + review_status on requests
- [ ] Overdue badge on schedule, reorder badge on parts
- [ ] Audit log table + status change logging
- [ ] All loading/empty/error states verified
- **DoD:** New request gets auto-priority; schedule shows overdue; parts show low-stock.

## Sprint 5 — Lock It Down
**Goal:** Auth + per-user RLS + data isolation.
- [ ] Supabase Auth (email/password)
- [ ] Signup/login pages
- [ ] Replace v1 RLS with owner-scoped policies (`auth.uid() = user_id`)
- [ ] Seed user-specific demo data
- [ ] Test: user A cannot see user B's data
- **DoD:** Logged-in user sees only their data; anonymous access blocked.

## Gantt
```
S1  ██████████████  Foundation + Assets
S2  ██████████████  Request Engine (v1 milestone)
S3  ██████████████  Schedule + Parts + Vendors
S4  ██████████████  Intelligence + Polish
S5  ██████████████  Lock Down (Auth + RLS)
```