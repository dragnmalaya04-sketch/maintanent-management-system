# Test Plan

## v1 Success Scenario
1. Open app on phone browser → see Requests page with demo data (no login).
2. Tap "New Request".
3. Select asset "HVAC-01" from dropdown.
4. Enter title "AC unit leaking".
5. Select priority "High".
6. Tap Submit → redirect to request list.
7. Verify new request appears at top with "Open" status.
8. Tap the request → change status to "In Progress" → verify badge updates.
9. Change status to "Resolved" → verify.
10. Refresh page → verify status persists.

## Empty State
1. Delete all requests (or filter to none) → verify "No requests yet. Create one." message + CTA button.

## Error State
1. Disconnect network → submit form → verify error toast: "Could not save request. Please retry."
2. Verify form retains entered data on error.

## Loading State
1. Open Requests page → verify skeleton/spinner before data renders.

## Asset CRUD
1. Go to Assets → create "Pump-02" → verify it appears.
2. Edit name to "Pump-02B" → verify update persists.
3. Delete → verify removed from list.

## Parts Reorder Flag
1. Set stock_qty to 2, reorder_threshold to 5 → verify "Low Stock" badge.

## Schedule Overdue
1. Set next_due_date to yesterday → verify "Overdue" badge.

## Persistence Check
1. Create request, close tab, reopen → data still present.

## Auth Lock-Down (Sprint 5)
1. Sign up as user A, create a request.
2. Sign up as user B → verify A's request is NOT visible.
3. Verify anonymous access redirects to login.