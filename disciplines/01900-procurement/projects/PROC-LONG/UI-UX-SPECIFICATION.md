---
title: "PROC-LONG — Long-Lead Item Procurement Override Specification"
description: "Procurement-specific overrides for the 01900 Long-Lead Item Procurement system. This document defines what's unique to PROC-LONG — item identification, early procurement initiation, critical path integration, supplier relationship management, and inventory staging coordination. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-LONG
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - long-lead-item
  - critical-path
  - supplier-management
  - procurement-workflow
  - inventory-staging
  - override
---

# PROC-LONG — Long-Lead Item Procurement Override Specification

## Purpose

This document defines the **PROC-LONG Long-Lead Item Procurement overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `longLeadWorkflow` | Item Identification → Procurement Initiation → Critical Path Integration → Supplier Management → Staging Coordination | §2 |
| `roleGate` | `user.role >= 'editor'` for items; `>= 'reviewer'` for approval | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `leadTimeCategories` | Short (< 4wks), Medium (4-12wks), Long (12-26wks), Critical (> 26wks) | §2 |

---

## 2. Long-Lead Item Workflow Overrides

### 2.1 Lead Time Classification

| Category | Lead Time | Procurement Strategy | Risk Level |
|----------|-----------|---------------------|------------|
| Short | < 4 weeks | Standard order | Low |
| Medium | 4-12 weeks | Early planning | Medium |
| Long | 12-26 weeks | Advance procurement | High |
| Critical | > 26 weeks | Immediate initiation | Critical |

### 2.2 Critical Path Integration

The system integrates with the project schedule to identify long-lead items on the critical path:

| Feature | Description |
|---------|-------------|
| Schedule Integration | Imports project schedule (Gantt/MS Project) |
| Critical Path Detection | Identifies items on critical path |
| Float Analysis | Calculates available float for each item |
| Alert Threshold | Warns when procurement lead time exceeds available float |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Long-Lead Agents

| Agent | Role | Description |
|-------|------|-------------|
| Item Identification Agent | Long-lead item detection | Scans project schedules for long-lead items |
| Procurement Planner | Early procurement initiation | Initiates procurement early enough to meet deadlines |
| Critical Path Monitor | Schedule risk monitoring | Tracks critical path items and flags delays |

### 3.2 Upserts State — Long-Lead Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Identify Items** | `user.role >= 'editor'` | Opens ItemIdentification modal | `ItemIdentification` — 98vw |
| **Initiate Procurement** | `user.role >= 'editor'` | Opens EarlyProcurement modal | `EarlyProcurement` — 98vw |
| **Import Schedule** | `user.role >= 'editor'` | Opens ScheduleImport modal | `ScheduleImport` — 98vw |

### 3.3 Workspace State — Long-Lead Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Critical Path** | `user.role >= 'viewer'` | Opens CriticalPath modal | `CriticalPath` — 98vw |
| **Flag Delay** | `user.role >= 'editor'` | Opens DelayFlag modal | `DelayFlag` — 98vw |
| **Coordinate Staging** | `user.role >= 'editor'` | Opens StagingCoord modal | `StagingCoord` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Long-Lead Item Lifecycle
```
IDENTIFIED → PLANNED → PROCUREMENT_INITIATED → ORDER_PLACED → IN_TRANSIT → RECEIVED → STAGED
```

### 4.2 Supplier Engagement Timeline

| Milestone | Before Delivery | Action |
|-----------|----------------|--------|
| Initial Contact | Lead time + 2 weeks | RFQ sent, supplier pre-qualification |
| Order Placement | Lead time | PO issued, deposit scheduled |
| Progress Update | 50% of lead time | Production status check |
| Shipping Notification | 2 weeks before delivery | Logistics coordination |
| Receipt Inspection | Delivery date | Quality check, goods receipt |

---

## 5. Testing Checklist (PROC-LONG-specific)

- [ ] Item identification correctly classifies items by lead time category
- [ ] Critical path integration correctly identifies schedule impact
- [ ] Procurement initiation wizard calculates correct deadline dates
- [ ] Supplier engagement timeline generates correct milestones
- [ ] Delay flagging triggers alerts to relevant stakeholders
- [ ] Staging coordination modal shows correct inventory status
- [ ] Role gates enforce correct access at each workflow step

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-LONG override specification |

---

**Document Information**
- **Project**: PROC-LONG — Long-Lead Item Procurement
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
