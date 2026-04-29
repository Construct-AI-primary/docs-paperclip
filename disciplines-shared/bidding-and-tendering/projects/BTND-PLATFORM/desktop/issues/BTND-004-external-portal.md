---
id: "BTND-004"
title: "Phase 4: External Portal — Vendor Portal Frontend, Sync Engine, Admin Dashboard"
status: "backlog"
priority: "medium"
estimate: "8-12 hours"
assignee: "portal-specialist-loopy"
company: "Loopy AI"
team: "Portal Development"
labels: ["phase-4", "portal", "sync", "btnd-platform", "vendor"]
related_docs:
  - docs-paperclip/disciplines-shared/bidding-and-tendering/plans/2026-04-29-bidding-tendering-plan.md
  - docs-paperclip/disciplines-shared/bidding-and-tendering/DISCIPLINE-PLATFORM-STRUCTURE.md
  - docs-paperclip/disciplines-shared/bidding-and-tendering/UI-UX-SPECIFICATION.md
  - docs-paperclip/disciplines-shared/bidding-and-tendering/integration/TENDERING-VENDOR-INTEGRATION.md
completion_criteria:
  - Public tender listing page renders published RFQs correctly
  - Vendor registration flow complete with email verification
  - Sync engine pushes new RFQs to portal within 30s
  - Daily reconciliation passes with zero discrepancies
  - Admin dashboard shows sync status and pending approvals
---

# BTND-004: Phase 4 — External Portal

## Scope

External vendor portal for public tender listing, vendor registration and authentication, along with the sync engine and admin dashboard for portal management.

## Dependencies

- **BTND-003**: Tendering System — tender lifecycle and vendor prequalification

## Tasks

### 4.1 Vendor Portal Frontend (4-6 hours)
| Task | Description | Dependencies |
|------|-------------|--------------|
| 4.1.1 | Public tender listing page (search, filter, paginate) | 3.1.6 |
| 4.1.2 | Vendor registration and profile management | 3.4.3 |
| 4.1.3 | Vendor login/authentication (JWT) | 4.1.2 |
| 4.1.4 | Quotation submission interface | 4.1.3 |
| 4.1.5 | Document upload for vendors | 4.1.3 |

### 4.2 Sync Engine (2-3 hours)
| Task | Description | Dependencies |
|------|-------------|--------------|
| 4.2.1 | CDC-based sync from internal → portal tables | 3.1.6 |
| 4.2.2 | Trigger-based sync (publish event → immediate push) | 4.2.1 |
| 4.2.3 | Daily reconciliation (checksum verification) | 4.2.1 |
| 4.2.4 | Dead-letter queue for failed syncs | 4.2.1 |

### 4.3 Admin Dashboard (2-3 hours)
| Task | Description | Dependencies |
|------|-------------|--------------|
| 4.3.1 | Portal management (publish/unpublish tenders) | 3.1.6 |
| 4.3.2 | Vendor approval management | 3.4.3 |
| 4.3.3 | Sync health monitoring | 4.2.3 |

## Gate Criteria
- [ ] Public tender listing page renders published RFQs correctly
- [ ] Vendor registration flow complete with email verification
- [ ] Sync engine pushes new RFQs to portal within 30s
- [ ] Daily reconciliation passes with zero discrepancies
- [ ] Admin dashboard shows sync status and pending approvals