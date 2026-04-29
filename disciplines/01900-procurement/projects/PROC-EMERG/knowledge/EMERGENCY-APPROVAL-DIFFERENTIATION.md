---
title: PROC-EMERG Emergency Approval Differentiation
description: Documents why emergency procurement is a distinct process from standard order creation, and defines the boundary with PROC-ORDER
author: Paperclip Orchestration System
date: 2026-04-29
version: 1.0
status: active
---

# Emergency Approval Differentiation: PROC-EMERG vs. PROC-ORDER

## Purpose

This document validates that PROC-EMERG (Emergency Procurement & Single-Source Justification) is a genuinely distinct process from PROC-ORDER's standard order creation workflow. It defines the boundary, the handoff point, and the shared infrastructure.

---

## 1. Why Emergency Procurement Is Not a "Fast-Track Mode" of PROC-ORDER

### Process Differences

| Aspect | PROC-ORDER (Standard) | PROC-EMERG (Emergency) |
|--------|----------------------|------------------------|
| **Trigger** | Planned requisition | Urgent/unforeseen need |
| **Supplier Selection** | Competitive bidding / multi-quote | Single-source justification |
| **Approval Routing** | Value-based matrix (standard tiers) | Compressed hierarchy (<4 hours) |
| **Validation Time** | Days (standard review cycles) | <2 hours (emergency validation) |
| **Documentation** | Standard SOW + contract | Single-source justification + post-award compliance |
| **Compliance Model** | Pre-award compliance checks | Post-award compliance documentation |
| **Order Type** | PO, WO, or SO (user-selected) | Any type, but always flagged as emergency |

### Key Differentiators

1. **Single-Source Justification**: PROC-EMERG requires a formal justification document explaining why competitive bidding was bypassed. This is a unique artifact not present in standard procurement.

2. **Compressed Approval Timeline**: Standard approvals can take 24+ hours. Emergency approvals must complete in <4 hours, requiring a different routing mechanism (parallel notifications, escalation timers, override capabilities).

3. **Post-Award Compliance**: Standard procurement validates compliance before order creation. Emergency procurement creates the order first, then documents compliance afterward. This is a fundamentally different compliance model.

4. **Emergency Supplier Engagement**: PROC-EMERG needs rapid supplier identification (pre-qualified emergency contacts, 24/7 availability checks) that differs from standard supplier selection.

---

## 2. Boundary with PROC-ORDER

### Handoff Point

```
PROC-EMERG (Emergency Path)
    │
    │  1. Emergency request submitted
    │  2. Emergency validation (<2 hours)
    │  3. Single-source justification created
    │  4. Expedited approval routing (<4 hours)
    │  5. Supplier contacted (emergency engagement)
    │
    ▼
PROC-ORDER (Standard Order Creation)
    │
    │  6. Order record created via PROC-ORDER API
    │     (flagged as emergency, linked to justification)
    │  7. Standard order tracking applies
    │
    ▼
Post-Award Compliance (PROC-EMERG)
    │
    │  8. Post-award documentation completed
    │  9. Compliance audit trail finalized
```

### Boundary Rules

| Rule | Description |
|------|-------------|
| **Emergency path is separate** | PROC-EMERG implements its own request validation, justification, and expedited approval flows. These are NOT modifications to PROC-ORDER's standard workflow. |
| **Order record goes to PROC-ORDER** | After emergency approval, the resulting order is created via PROC-ORDER's standard API with an `emergency_flag = true` and `emergency_justification_id` link. |
| **No standard order creation in PROC-EMERG** | PROC-EMERG must not implement its own order creation wizard. It delegates to PROC-ORDER for the final order record. |
| **Shared supplier directory** | PROC-EMERG reads from the same supplier directory as PROC-ORDER, but may add emergency-specific contact fields (24/7 phone, escalation contacts). |

---

## 3. Shared Infrastructure

### Components PROC-EMERG Reuses from PROC-ORDER

| Component | Usage | Modification Needed? |
|-----------|-------|---------------------|
| Supplier Directory | Read supplier contacts for emergency engagement | Add emergency contact fields (24/7 phone, escalation) |
| Approval Engine | Base approval matrix for reference | PROC-EMERG implements its own compressed routing |
| Order Status Schema | Final order record uses standard schema | Add `emergency_flag` boolean, `emergency_justification_id` FK |
| SOW Template Library | Reference for emergency orders | No modification needed |

### Components PROC-EMERG Implements Independently

| Component | Description |
|-----------|-------------|
| Emergency Request Intake | Rapid submission form with minimal required fields |
| Single-Source Justification Template | Formal justification document with approval chain |
| Expedited Approval Router | Compressed approval routing with escalation timers |
| Emergency Supplier Lookup | 24/7 supplier contact database |
| Post-Award Compliance Tracker | Documentation completion monitoring |

---

## 4. Issue Generation Guardrails for PROC-EMERG

When generating issues for PROC-EMERG, use this checklist:

- [ ] Does this issue duplicate PROC-ORDER's order creation wizard? → If yes, remove. PROC-EMERG creates orders via PROC-ORDER API.
- [ ] Does this issue modify PROC-ORDER's core approval matrix? → If yes, coordinate. PROC-EMERG uses its own compressed routing.
- [ ] Does this issue require a new order type? → If yes, it belongs in PROC-ORDER.
- [ ] Is this a standard procurement feature disguised as emergency? → If yes, route to PROC-ORDER.
- [ ] Does this issue handle post-award compliance? → If yes, this is valid PROC-EMERG scope.

---

## 5. Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-04-29 | Paperclip Orchestration System | Initial differentiation document |

---

**Document Version**: 1.0
**Last Updated**: 2026-04-29
**Next Review**: 2026-05-29