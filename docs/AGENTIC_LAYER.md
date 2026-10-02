# Agentic Layer

## Draftable Actions (low risk — auto)
- Suggest priority on new request (writes `ai_priority` fields, status `unreviewed`).
- Tag request with category from issue text.
- Draft supervisor summary of open requests.

## Executable After Approval (medium risk)
- Auto-set status to `in_progress` when assigned (supervisor approves).
- Reorder spare part — draft purchase note, supervisor confirms.
- Generate WhatsApp/Sheets export of resolved requests (later).

## Human-Only Actions (high/critical)
- Delete asset or request.
- Close a request as `resolved` (technician must confirm).
- Change priority to `critical` (supervisor override).
- Refund or financial transaction.

## Named Tools
- `suggest_request_priority(request_id)` — low, auto.
- `update_request_status(request_id, status)` — medium, requires approval.
- `flag_part_reorder(part_id)` — low, auto.
- `export_requests_whatsapp(date_range)` — high, requires approval.

## Audit Log Fields
Every agentic action logs: `id`, `tool_name`, `actor_user_id`, `target_entity`, `target_id`, `action_detail` (jsonb), `risk_level`, `approved_by`, `created_at`.

## v1 vs Later
- **v1:** rule-based `suggest_request_priority` and `flag_part_reorder` only — no external calls, no messages sent.
- **Later:** WhatsApp export, auto-assignment, LLM-assisted triage with approval queue.