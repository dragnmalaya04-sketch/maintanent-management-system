# Intelligence Layer

## Messy Inputs
- Free-text issue descriptions from technicians (varying detail, typos, language).
- Photo of breakdown (no structured fields).
- Priority self-selected by requester (often wrong).

## Auto-Structure Schema (v1+)
```json
{
  "request_id": "uuid",
  "parsed_issue": "AC unit leaking water from indoor unit",
  "suggested_asset": "HVAC-01",
  "suggested_priority": "high",
  "confidence": 0.82,
  "source": "keyword_match + asset_history",
  "review_status": "unreviewed"
}
```

## Events to Track
- `request.created` — new intake → trigger AI priority suggestion.
- `request.status_changed` — status transition.
- `part.stock_low` — stock_qty <= reorder_threshold.
- `schedule.overdue` — next_due_date < today.

## Scoring Rules (v1, rule-based)
- **Priority auto-suggest:** keyword match ("leak", "burst", "fire" → critical; "broken", "stopped" → high; "noise", "smell" → medium; else low).
- **Confidence:** 0.9 if keyword match found, 0.4 if fallback default.
- **Reorder flag:** `stock_qty <= reorder_threshold` → boolean.
- **Overdue flag:** `next_due_date < current_date` → boolean.

## What Gets Ranked
- Request list: sort by AI-suggested priority (critical first), then by created_at.
- Preventive schedule: sort by next_due_date ascending (most overdue first).

## v1 vs Later
- **v1:** rule-based priority suggestion, reorder/overdue flags (pure SQL queries).
- **Later:** LLM-based issue classification, photo analysis, spare-part recommendation, auto-assignment to technician by skill match.