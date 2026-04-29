---
title: "PROC-ORDER — Procurement Order Management Override Specification"
description: "Procurement-specific overrides for the 01900 Procurement Order Management system. This document defines what's unique to PROC-ORDER — order creation, sow template alignment, approval matrix integration, multi-discipline appendix handling, and procurement workflow orchestration. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-ORDER
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - procurement-order
  - order-creation
  - sow-template
  - approval-matrix
  - multi-discipline
  - procurement-workflow
  - override
---

# PROC-ORDER — Procurement Order Management Override Specification

## Purpose

This document defines the **PROC-ORDER Procurement Order Management overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, Spec Template Registry, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `orderWorkflow` | Order Creation → SOW Template Selection → Discipline Assignment → Approval Routing → Multi-Discipline Appendix → Document Assembly | §2 |
| `roleGate` | `user.role >= 'editor'` for order creation; `>= 'reviewer'` for approval | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `orderTypes` | Purchase Order (PO), Service Order (SO), Work Order (WO) | §2 |

---

## 2. Order Management Workflow Overrides

### 2.1 Order Types

| Type | Code | Description | Workflow Template |
|------|------|-------------|-------------------|
| Purchase Order | PO | Goods procurement | Standard procurement workflow |
| Service Order | SO | Service procurement | Service order workflow |
| Work Order | WO | Construction/work procurement | Work order workflow |

### 2.2 CreateOrderModal — Full 5-Phase Wizard

| Phase | Title | Components | Validation |
|-------|-------|------------|------------|
| 1 | Basic Order Info | Order type selector, project dropdown, supplier selector, description | All fields required |
| 2 | SOW Template Selection | Template picker filtered by order type from Spec Template Registry | Template required |
| 3 | Discipline Assignment | Required/optional discipline checkboxes from Document Ordering Management | At least required selected |
| 4 | Approval Configuration | Auto-generated approval matrix based on order value (see §4.2) | Chain must be complete |
| 5 | Review & Create | Summary panel with all phases, edit capability, submit button | Final validation |

### 2.3 SOW Template Alignment

When the user selects an order type in Phase 1, the SOW template picker in Phase 2 filters templates from the Spec Template Registry by:

| Filter | Source | Behaviour |
|--------|--------|-----------|
| Order Type | Template metadata | Only templates tagged with matching order_type |
| Discipline | Template metadata | Default to 01900, can be overridden |
| Region | User profile | Default to user's region, can be changed |

### 2.4 Multi-Discipline Appendix Handling

When an order involves multiple disciplines (Phase 3), the system:

1. Determines required appendices per discipline from Document Ordering Management
2. Presents Spec Template selector for each appendix (reusing the Spec Template Registry pattern)
3. Assigns each appendix to the appropriate discipline team
4. Routes appendix completion tasks to respective discipline agents

---

## 3. State-Specific Overrides

### 3.1 Agents State — Order Agents

| Agent | Role | Description |
|-------|------|-------------|
| Order Creation Agent | Order processing and validation | Guides users through the 5-phase order wizard |
| SOW Engineer | SOW template selection and customization | Matches SOW templates to order requirements |
| Discipline Coordinator | Multi-discipline task routing | Ensures correct discipline assignment and routing |
| Document Assembler | Final document package generation | Assembles all appendices into final procurement package |

### 3.2 Upserts State — Order Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create Order** | `user.role >= 'editor'` | Opens CreateOrder 5-phase wizard | `CreateOrder` — 98vw |
| **Import Orders** | `user.role >= 'editor'` | Opens BatchImport modal | `BatchImport` — 98vw, CSV/Excel |
| **Edit Order** | `user.role >= 'editor'` | Opens EditOrder modal | `EditOrder` — 98vw |
| **Clone Order** | `user.role >= 'editor'` | Inline clone with copy | No modal |
| **Delete Order** | `user.role === 'governance'` | Opens Confirmation modal | `Confirmation` — with impact warning |

### 3.3 Workspace State — Order Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Approve** | `user.role >= 'reviewer'` | Opens Approval modal | `Approval` — 98vw |
| **Reject** | `user.role >= 'reviewer'` | Opens Rejection modal | `Rejection` — 98vw |
| **Generate PO** | `user.role >= 'editor'` | Opens GeneratePO modal | `GeneratePO` — 98vw |
| **Manage Appendices** | `user.role >= 'editor'` | Opens AppendixManager modal | `AppendixManager` — 98vw |
| **View Order Status** | `user.role >= 'viewer'` | Opens OrderStatus modal | `OrderStatus` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Order Lifecycle
```
DRAFT → SUBMITTED → VALIDATED → APPROVED → ORDER_GENERATED → AWARDED → COMPLETED
         ↓                                      ↓
      CANCELLED                              REJECTED
```

### 4.2 Approval Matrix (Value-Based)

| Order Value | Approval Chain | Max Approval Time |
|-------------|---------------|-------------------|
| < 25K | Procurement Officer (single) | 24 hours |
| 25K - 250K | Officer + Department Head (parallel) | 48 hours |
| 250K - 1M | Officer → Manager → Director (sequential) | 5 business days |
| > 1M | Full chain + Executive (sequential) | 10 business days |

### 4.3 Document Assembly Package

When an order is fully approved, the Document Assembler generates:

| Document | Source | Format |
|----------|--------|--------|
| Purchase Order | Generated from order data | PDF (A-01900-po-template) |
| SOW | Spec Template Registry content | PDF (A-01900-sow-template) |
| Appendix A: Product Specs | Discipline-specific template | PDF (per spec template) |
| Appendix B: Safety Data Sheets | Discipline-specific template | PDF (per spec template) |
| Appendix C: Delivery Schedule | Generated from order data | PDF (A-01900-schedule-template) |
| Approvals Summary | Approval matrix results | Embedded in PO package |

---

## 5. Testing Checklist (PROC-ORDER-specific)

- [ ] CreateOrder 5-phase wizard navigates correctly through all phases
- [ ] Order type selection correctly filters SOW templates
- [ ] Discipline assignment shows required disciplines from Document Ordering Management
- [ ] Approval matrix auto-generates based on order value
- [ ] Multi-discipline appendix handling routes tasks to correct teams
- [ ] Document assembly generates complete package with all documents
- [ ] Order lifecycle transitions correctly through all states
- [ ] Batch import processes CSV/Excel files correctly
- [ ] Error feedback displayed on validation failures
- [ ] Rollback test: order creation failure does not create partial records

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-ORDER override specification |

---

**Document Information**
- **Project**: PROC-ORDER — Procurement Order Management
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
