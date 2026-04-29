---
title: Scope Boundary Monitor — PROC-ORDER and Downstream Procurement Projects
description: Decision tree and monitoring checklist for preventing scope overlap between PROC-ORDER and related procurement projects
author: Paperclip Orchestration System
date: 2026-04-29
version: 1.0
status: active
---

# Scope Boundary Monitor: PROC-ORDER and Downstream Projects

## Purpose

This document provides a decision framework for determining whether a new issue or requirement belongs in **PROC-ORDER** (the central order creation system) or in one of its sibling projects. It prevents scope creep, duplication, and boundary violations as the procurement ecosystem grows.

---

## 1. Project Map

| Project | Focus | Boundary |
|---------|-------|----------|
| **PROC-ORDER** | Unified order creation for PO, WO, and SO — 5-phase wizard, approval routing, supplier selection, contract generation, order tracking | **Creation only.** Covers requisition → approval → order created. |
| **PROC-SERVICE** | Service Order downstream lifecycle — SLA management, delivery monitoring, acceptance workflows, service contract admin | **Post-creation.** Picks up after PROC-ORDER creates a Service Order. |
| **PROC-EMERG** | Emergency procurement & single-source justification — expedited approvals, emergency supplier engagement, post-award compliance | **Exception path.** Handles the non-standard workflow, then hands off to PROC-ORDER for order record. |
| **PROC-AMEND** | Order amendments and modifications — change orders, scope changes, value adjustments | **Post-creation modifications.** Modifies existing PROC-ORDER records. |
| **PROC-TRACK** | Order tracking and status monitoring — dashboards, notifications, milestones | **Read-only.** Reads PROC-ORDER order data for display. |
| **PROC-INV** | Invoice processing and payment | **Financial downstream.** Covers post-order financial processing. |
| **PROC-NCR** | Non-conformance reporting | **Quality downstream.** Covers post-delivery quality issues. |

---

## 2. Decision Tree for New Issues

When evaluating where a new issue belongs, follow this decision tree:

```
START: What does this issue do?
    │
    ├── Creates a new procurement order?
    │   └──→ PROC-ORDER (all PO, WO, SO creation is unified here)
    │
    ├── Manages Service Order lifecycle after creation?
    │   ├── SLA management? → PROC-SERVICE
    │   ├── Delivery monitoring? → PROC-SERVICE
    │   ├── Service acceptance? → PROC-SERVICE
    │   └── Service contract admin? → PROC-SERVICE
    │
    ├── Handles an emergency/exception procurement path?
    │   ├── Single-source justification? → PROC-EMERG
    │   ├── Expedited approval? → PROC-EMERG
    │   ├── Emergency supplier engagement? → PROC-EMERG
    │   └── Post-award compliance documentation? → PROC-EMERG
    │
    ├── Modifies an existing order?
    │   ├── Amendment/change order? → PROC-AMEND
    │   └── Scope change? → PROC-AMEND
    │
    ├── Tracks order status or displays dashboards?
    │   └──→ PROC-TRACK
    │
    ├── Processes invoices or payments?
    │   └──→ PROC-INV
    │
    ├── Reports non-conformance or quality issues?
    │   └──→ PROC-NCR
    │
    └── Something else?
        └──→ Evaluate and assign to appropriate project
```

---

## 3. Red Flags — Signs of Scope Creep

If any of these conditions are true, the issue may be crossing boundaries and needs escalation:

### PROC-ORDER Red Flags
- [ ] Issue creates a Service Order **lifecycle** feature (SLA, delivery monitoring, acceptance) → belongs in PROC-SERVICE
- [ ] Issue creates an **emergency** or **exception** workflow (single-source justification, compressed approvals) → belongs in PROC-EMERG
- [ ] Issue creates an **invoice** or **payment** feature → belongs in PROC-INV
- [ ] Issue creates a **non-conformance** feature → belongs in PROC-NCR

### PROC-SERVICE Red Flags
- [ ] Issue creates a **Service Order creation wizard** → already exists in PROC-ORDER
- [ ] Issue modifies the **order header** (supplier, value, approval status) → PROC-ORDER owns this
- [ ] Issue creates a **new order type** → belongs in PROC-ORDER

### PROC-EMERG Red Flags
- [ ] Issue creates a **standard order creation wizard** → use PROC-ORDER API instead
- [ ] Issue creates features for **planned/standard procurement** → belongs in PROC-ORDER
- [ ] Issue modifies **standard approval matrix** (not emergency-specific) → belongs in PROC-ORDER

---

## 4. Cross-Project Dependency Matrix

| Feature Area | Owner | PROC-ORDER | PROC-SERVICE | PROC-EMERG | PROC-AMEND | PROC-TRACK |
|---|---|---|---|---|---|---|
| Order Creation | PROC-ORDER | ✓ Owns | Reads only | Creates via API | — | Reads |
| Supplier Selection | PROC-ORDER | ✓ Owns | Reads | Reads | Reads | Reads |
| Approval Routing | PROC-ORDER | ✓ Owns | Standard only | Compressed variant | — | Reads |
| Contract Generation | PROC-ORDER | ✓ Owns | — | — | — | — |
| SLA Management | PROC-SERVICE | — | ✓ Owns | — | — | — |
| Delivery Monitoring | PROC-SERVICE | — | ✓ Owns | — | — | — |
| Acceptance Workflows | PROC-SERVICE | — | ✓ Owns | — | — | — |
| Emergency Justification | PROC-EMERG | — | — | ✓ Owns | — | — |
| Expedited Approvals | PROC-EMERG | — | — | ✓ Owns | — | — |
| Post-Award Compliance | PROC-EMERG | — | — | ✓ Owns | — | — |
| Order Amendments | PROC-AMEND | Modifies | — | — | ✓ Owns | Updates |
| Tracking/Dashboards | PROC-TRACK | Reads | Reads | Reads | Reads | ✓ Owns |
| Invoicing | PROC-INV | Reads | — | — | — | — |
| NCR | PROC-NCR | Reads | — | — | — | — |

---

## 5. Escalation Process

When a potential boundary violation is detected:

1. **Document**: Note the issue, the project it was filed under, and which project it should belong to
2. **Flag**: Add a `cross-project-boundary` label to the issue
3. **Notify**: Reference this document and record the concern
4. **Resolve**: Either move the issue to the correct project, or update this document if the boundary needs to shift

### Escalation Triggers
- New order type added to the system (e.g., "Rental Order") → belongs in PROC-ORDER
- Existing project attempting to duplicate PROC-ORDER functionality → redirect to PROC-ORDER
- PROC-ORDER's scope expanding into lifecycle management → split into downstream project
- Downstream project encroaching on order creation → push back to PROC-ORDER

---

## 6. Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-04-29 | Paperclip Orchestration System | Initial scope boundary monitor |

---

**Document Version**: 1.0
**Last Updated**: 2026-04-29
**Next Review**: 2026-05-29