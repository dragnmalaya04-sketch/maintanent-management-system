# Data Model

## assets
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid (nullable, for future RLS) |
| name | text not null |
| asset_code | text unique |
| location | text |
| category | text |
| status | text default 'active' |
| created_at | timestamptz default now() |

**RLS:** v1 open read/write (demo). Later: owner-scoped.

## maintenance_requests
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid (nullable) |
| asset_id | uuid references assets(id) |
| title | text not null |
| description | text |
| priority | text default 'medium' (low/medium/high/critical) |
| status | text default 'open' (open/in_progress/resolved/closed) |
| photo_url | text |
| assigned_to | text |
| ai_priority | text (AI field: value) |
| ai_priority_source | text |
| ai_priority_confidence | numeric |
| ai_priority_review_status | text default 'unreviewed' |
| created_at | timestamptz default now() |

**Relationships:** belongs to asset. **RLS:** v1 open; later owner-scoped.

## preventive_schedules
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid (nullable) |
| asset_id | uuid references assets(id) |
| task_name | text not null |
| frequency_days | int |
| last_done_date | date |
| next_due_date | date |
| created_at | timestamptz default now() |

**Relationships:** belongs to asset. **RLS:** v1 open; later owner-scoped.

## spare_parts
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid (nullable) |
| name | text not null |
| part_number | text |
| stock_qty | int default 0 |
| reorder_threshold | int default 0 |
| unit_cost | numeric |
| created_at | timestamptz default now() |

**RLS:** v1 open; later owner-scoped.

## vendors
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid (nullable) |
| name | text not null |
| contact_person | text |
| phone | text |
| email | text |
| service_category | text |
| created_at | timestamptz default now() |

**RLS:** v1 open; later owner-scoped.

## AI Fields Convention
Any AI-generated value stores: `value` + `source` (text) + `confidence` (numeric 0-1) + `review_status` (text default 'unreviewed'). Applied to `ai_priority` on maintenance_requests.