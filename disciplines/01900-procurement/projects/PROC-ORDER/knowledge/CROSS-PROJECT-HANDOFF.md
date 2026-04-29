---
title: Cross-Project Handoff — PROC-ORDER to PROC-SERVICE and PROC-EMERG
description: Defines the handoff points, data contracts, and boundary rules between PROC-ORDER and downstream procurement projects
author: Paperclip Orchestration System
date: 2026-04-29
version: 1.0
status: active
---

# Cross-Project Handoff: PROC-ORDER → PROC-SERVICE / PROC-EMERG

## Purpose

This document defines the handoff points between the **PROC-ORDER** (Procurement Order Creation) project and its downstream sibling projects **PROC-SERVICE** (Service Order Lifecycle) and **PROC-EMERG** (Emergency Procurement). It ensures clear boundaries, prevents duplication, and establishes data contracts for cross-project integration.

---

## 1. PROC-ORDER → PROC-SERVICE Handoff

### Handoff Point

| Aspect | Detail |
|--------|--------|
| **Trigger** | A Service Order (SO) is created and approved via the PROC-ORDER 5-phase wizard |
| **Handoff Data** | `order_id`, `order_type = 'service_order'`, `supplier_id`, `sow_template_id`, `approval_status`, `discipline_assignments` |
| **PROC-SERVICE Entry** | PROC-SERVICE picks up the approved Service Order for lifecycle management: SLA setup, delivery monitoring, acceptance workflows |
| **Status Transition** | `approved` (PROC-ORDER) → `service_lifecycle_active` (PROC-SERVICE) |

### Data Contract

The shared data contract between PROC-ORDER and PROC-SERVICE:

```json
{
  "order_id": "uuid",
  "order_type": "service_order",
  "status": "approved",
  "supplier": {
    "supplier_id": "uuid",
    "name": "string",
    "contact_info": "object"
  },
  "sow_template": {
    "template_id": "uuid",
    "name": "string",
    "disciplines_required": ["string"]
  },
  "approval_chain": [
    {
      "approver_id": "uuid",
      "level": "integer",
      "status": "approved",
      "approved_at": "timestamp"
    }
  ],
  "value": "decimal",
  "currency": "string",
  "created_at": "timestamp",
  "approved_at": "timestamp"
}
```

### Boundary Rules

| Rule | Description |
|------|-------------|
| **No duplicate creation** | PROC-SERVICE must NOT implement a Service Order creation wizard. All SO creation flows through PROC-ORDER. |
| **Read-only order header** | PROC-SERVICE may read the order header (supplier, value, SOW template) but must NOT modify it. Amendments go through PROC-AMEND. |
| **Lifecycle-only scope** | PROC-SERVICE adds: SLA records, delivery milestones, acceptance checklists, service contract amendments. These are new tables, not modifications to PROC-ORDER's schema. |
| **Status coordination** | PROC-SERVICE updates the order's `lifecycle_status` field (not the core `order_status`). The core status remains under PROC-ORDER's domain. |

---

## 2. PROC-ORDER → PROC-EMERG Handoff

### Handoff Point

| Aspect | Detail |
|--------|--------|
| **Trigger** | An emergency procurement request is validated and approved via PROC-EMERG's expedited workflow |
| **Handoff Data** | `emergency_request_id`, `justification_doc_id`, `supplier_id`, `order_value`, `approval_chain` |
| **PROC-ORDER Entry** | After emergency approval, a standard order record is created in PROC-ORDER's schema for tracking and compliance |
| **Status Transition** | `emergency_approved` (PROC-EMERG) → `created_via_emergency` (PROC-ORDER) |

### Boundary Rules

| Rule | Description |
|------|-------------|
| **Emergency is the exception** | PROC-EMERG handles the non-standard path (single-source justification, compressed approvals). Once approved, the resulting order is recorded in PROC-ORDER's standard schema. |
| **No standard order creation in PROC-EMERG** | PROC-EMERG must not implement its own order creation. It creates an order record via PROC-ORDER's API after emergency approval. |
| **Compliance trail** | PROC-EMERG's justification documents are linked to the PROC-ORDER order record via `emergency_justification_id`. |

---

## 3. Shared Infrastructure

### Shared Components (Used by All Three Projects)

| Component | Owner | Used By |
|-----------|-------|---------|
| Supplier Directory | PROC-ORDER (read-only for others) | PROC-SERVICE, PROC-EMERG |
| Approval Engine (value-based matrix) | PROC-ORDER | PROC-SERVICE (standard), PROC-EMERG (expedited variant) |
| SOW Template Library | PROC-ORDER | PROC-SERVICE (service-specific templates) |
| Order Status Schema | PROC-ORDER | PROC-SERVICE (lifecycle_status extension), PROC-EMERG (emergency flag) |

### Integration Points

```
PROC-ORDER (Order Creation)
    │
    ├──→ PROC-SERVICE (Service Order Lifecycle)
    │       Reads: order header, supplier, SOW template
    │       Writes: SLA records, delivery milestones, acceptance checklists
    │       Status: updates lifecycle_status only
    │
    └──→ PROC-EMERG (Emergency Procurement)
            Reads: supplier directory, approval matrix
            Writes: emergency justification, expedited approval chain
            Creates: order record via PROC-ORDER API after approval
```

---

## 4. Issue Generation Guardrails

When generating issues for PROC-SERVICE or PROC-EMERG, use this checklist:

- [ ] Does this issue duplicate functionality already in PROC-ORDER? → If yes, remove from scope.
- [ ] Does this issue modify PROC-ORDER's core schema? → If yes, coordinate with PROC-ORDER team.
- [ ] Does this issue require data from PROC-ORDER? → If yes, document the data contract.
- [ ] Does this issue create a new order type? → If yes, it belongs in PROC-ORDER, not here.

---

## 5. Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-04-29 | Paperclip Orchestration System | Initial handoff document |

---

**Document Version**: 1.0
**Last Updated**: 2026-04-29
**Next Review**: 2026-05-29