---
title: "PROC-001 — Standard Procurement Workflow Override Specification"
description: "Procurement-specific overrides for the 01900 Standard Procurement Workflow. This document defines what's unique to PROC-001 — order creation workflow, multi-level approval routing, supplier integration, and compliance automation. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-001
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - standard-procurement
  - order-creation
  - approval-routing
  - supplier-integration
  - compliance-automation
  - override
---

# PROC-001 — Standard Procurement Workflow Override Specification

## Purpose

This document defines the **PROC-001 Standard Procurement Workflow overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, spec template registry, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Procurement Order ID from current workflow context | §2 |
| `orderWorkflow` | Standard Procurement Order Creation (5-phase wizard) | §2 |
| `roleGate` | `user.role >= 'editor'` for creation; `>= 'reviewer'` for approval | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `stateLabels` | Agents, Upserts, Workspace (inherited) | §5 |

---

## 2. Order Creation Workflow Overrides

### 2.1 Five-Phase Order Wizard

The CreateOrderModal follows a 5-phase wizard specific to PROC-001:

| Phase | Title | Content |
|-------|-------|---------|
| 1 | Basic Order Info | Order type (PO/SO/WO), project dropdown, supplier dropdown, description |
| 2 | SOW Template Selection | Filtered templates by order type from Spec Template Registry |
| 3 | Discipline Assignment | Required/optional disciplines from Document Ordering Management |
| 4 | Approval Configuration | Auto-generated approval matrix based on order value |
| 5 | Review & Create | Summary of all phases, validation, submit |

### 2.2 Form Field Specification

```typescript
interface CreateOrderForm {
  orderType: 'PO' | 'SO' | 'WO';
  projectId: string;
  supplierId: string;
  description: string;
  sowTemplateId: string;
  disciplines: string[];
  approvalMatrix: ApprovalConfig;
}
```

### 2.3 Validation Rules

| Field | Rule | Error Message |
|-------|------|---------------|
| orderType | Required selection | "Select an order type" |
| projectId | Must be active project | "Select an active project" |
| supplierId | Must be approved supplier | "Select an approved supplier" |
| description | Min 10 characters | "Description must be at least 10 characters" |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Procurement Agent Cards

| Agent | Role | Status Indicator |
|-------|------|-----------------|
| Supplier Analyst | Supplier evaluation, qualification checks | ● Active / ○ Inactive |
| Tender Evaluator | Bid comparison, scoring, award recommendations | ● Active / ○ Inactive |
| Contract Admin | Contract creation, amendment processing, compliance | ● Active / ○ Inactive |

### 3.2 Upserts State — Record Creation

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create Order** | `user.role >= 'editor'` | Opens CreateOrder 5-phase wizard | `CreateOrder` — 98vw |
| **Import Orders** | `user.role >= 'editor'` | Opens Import modal | `ImportOrders` — 98vw |
| **Edit Order** | `user.role >= 'editor'` | Opens EditOrder modal | `EditOrder` — 98vw |
| **Delete Order** | `user.role === 'governance'` | Opens Confirmation modal | `Confirmation` — with impact warning |

### 3.3 Workspace State — Order Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Approve** | `user.role >= 'reviewer'` | Opens Approval modal | `Approval` — 98vw |
| **Reject** | `user.role >= 'reviewer'` | Opens Rejection modal | `Rejection` — 98vw |
| **Generate PO** | `user.role >= 'editor'` | Opens GeneratePO modal | `GeneratePO` — 98vw |
| **View Audit** | `user.role >= 'viewer'` | Opens AuditTrail modal | `AuditTrail` — 98vw |

---

## 4. Platform Adaptations

### 4.1 Desktop (1280px+)
- Full 5-phase wizard with sidebar progress indicator
- Split-pane order detail view
- Agent grid: 3 columns

### 4.2 Tablet (768px - 1279px)
- Wizard phases shown as stepper (collapsed)
- Agent grid: 2 columns

### 4.3 Mobile (< 768px)
- Wizard shown as single-column form with bottom "Next" button
- Agent grid: 1 column
- Touch targets minimum 48dp
- Offline order creation with SQLite local storage

---

## 5. Workflow-Specific Specifications

### 5.1 Order Lifecycle States
```
DRAFT → SUBMITTED → VALIDATED → APPROVED → ORDER_GENERATED → AWARDED → COMPLETED
         ↓
      REJECTED
```

### 5.2 Approval Chain

| Order Value | Approval Level | Required Approvers |
|-------------|---------------|-------------------|
| < 25K | Level 1 | Procurement Officer |
| 25K - 250K | Level 2 | Officer + Department Head (parallel) |
| > 250K | Level 3 | Officer → Manager → Executive (sequential) |

---

## 6. Testing Checklist (PROC-001-specific)

- [ ] CreateOrderModal: All 5 phases navigate correctly
- [ ] Project dropdown populates with active projects
- [ ] Supplier dropdown populates with approved suppliers
- [ ] SOW templates load and filter by selected order type
- [ ] Discipline assignment works in Phase 3
- [ ] Approval matrix auto-generates based on order value
- [ ] Order creation succeeds with valid data
- [ ] Error feedback displayed on failure
- [ ] Offline order creation stores to SQLite and syncs

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-001 override specification |

---

**Document Information**
- **Project**: PROC-001 — Standard Procurement Workflow
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
