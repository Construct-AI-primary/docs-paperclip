---
id: "BTND-000"
title: "Desktop Automation: BTND-PLATFORM — Bidding & Tendering Platform"
type: "trigger"
product: "BTND-PLATFORM"
trigger_value: "bid and tender"
trigger_on: "user utterance containing 'bid and tender', 'bidding', 'tendering', 'BTND', 'tender platform'"
status: "active"
---

# Desktop Automation — BTND-PLATFORM

## Trigger

When the user says something about bidding/tendering or mentions the BTND platform, execute:

```
cd /Users/_A_QA of code/paperclip-render && pnpm dev
```

Then open the browser at `http://localhost:3100/engineering/BTND` after the platform loads.

## Implementation Files

| File | Purpose |
|------|---------|
| `BTND-PLATFORM-implementation.md` | Master implementation document |
| `desktop/issues/BTND-001-foundation-database-api.md` | Foundation phase |
| `desktop/issues/BTND-002-bidding-system.md` | Bidding phase |
| `desktop/issues/BTND-003-tendering-system.md` | Tendering phase |
| `desktop/issues/BTND-004-external-portal.md` | External portal phase |
| `desktop/issues/BTND-005-integration-testing.md` | Integration & testing phase |

## Related Documentation

| Document | Location |
|----------|----------|
| Readme | `../../README.md` |
| Platform Structure | `../../DISCIPLINE-PLATFORM-STRUCTURE.md` |
| Workflows Catalog | `../../DISCIPLINE-WORKFLOWS-CATALOG.md` |
| UI/UX Specification | `../../UI-UX-SPECIFICATION.md` |
| Master Plan | `../../plans/2026-04-29-bidding-tendering-plan.md` |