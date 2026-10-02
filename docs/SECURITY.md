# Security

## Secret Handling
- Supabase URL + anon key: public (safe for client-side RLS-protected reads).
- Supabase service role key: server-only, never in frontend env exposed to browser.
- All secrets in `.env.local` / Vercel env vars — never committed.

## Permission Model
- **v1 (demo):** all tables open (PERMISSIVE RLS — read + write for all). Seed data visible without login.
- **Lock-down sprint (later):** replace v1 policies with owner-scoped RLS — `auth.uid() = user_id` on all tables. Users see only their tenant's data.
- Agent inherits the calling user's permissions — never runs as service role for user-facing actions.

## Approved-Tools Rule
- Agent may only call named tools (`suggest_request_priority`, `update_request_status`, `flag_part_reorder`).
- Never raw SQL execution or arbitrary function calls from the agent.
- High-risk actions require explicit human approval before execution.

## Audit Principle
- Every status change, priority override, and agentic action is logged to `audit_logs`.
- Logs are append-only — no delete policy.
- If something can't be proven safe, stop and get a human reviewer.

## Honesty
- Do not mark security as "done" until RLS policies are tested with real auth flows.
- v1 is explicitly **not secure** — it is a demo. The lock-down sprint is mandatory before real data.