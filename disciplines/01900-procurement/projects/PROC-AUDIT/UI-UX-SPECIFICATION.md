---
title: "PROC-AUDIT — Procurement Audit Workflow Override Specification"
description: "Procurement-specific overrides for the 01900 Procurement Audit Workflow. This document defines what's unique to PROC-AUDIT — audit trail implementation, compliance assessment, control review, and regulatory reporting. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-AUDIT
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - procurement-audit
  - compliance-automation
  - audit-trail
  - control-review
  - regulatory-reporting
  - override
---

# PROC-AUDIT — Procurement Audit Workflow Override Specification

## Purpose

This document defines the **PROC-AUDIT Procurement Audit Workflow overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `auditWorkflow` | Audit Trail → Compliance Assessment → Control Review → Regulatory Reporting | §2 |
| `roleGate` | `user.role >= 'viewer'` for read; `>= 'auditor'` for audit actions | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `auditEventTypes` | Order Created, Approved, Rejected, Compliance Checked, Control Tested | §2 |

---

## 2. Audit Workflow Overrides

### 2.1 Audit Event Types

| Event Type | Source | Trigger |
|------------|--------|---------|
| ORDER_CREATED | CreateOrder modal | Order submitted |
| ORDER_APPROVED | Approval modal | Approve action completed |
| ORDER_REJECTED | Rejection modal | Reject action completed |
| COMPLIANCE_CHECKED | Compliance engine | Automated compliance check |
| CONTROL_TESTED | Control review system | Manual or automated control test |
| AMENDMENT_REQUESTED | Amendment modal | Amendment submitted |
| INVOICE_MATCHED | 3-way match engine | Match completed |
| PAYMENT_EXECUTED | Payment engine | Payment processed |

### 2.2 Audit Trail Search Interface

| Search Criteria | Type | Example |
|----------------|------|---------|
| Date Range | Date picker | Last 30 days |
| Event Type | Multi-select dropdown | ORDER_CREATED, ORDER_APPROVED |
| User ID | Autocomplete | name@example.com |
| Entity ID | Text input | PO-2026-0042 |
| Platform | Dropdown | Desktop, Mobile, Web |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Audit Agents

| Agent | Role | Description |
|-------|------|-------------|
| Audit Trail Monitor | Real-time event capture | Captures and indexes all procurement events |
| Compliance Assessor | Automated compliance checking | Runs compliance rules against procurement data |
| Control Reviewer | Internal control testing | Executes control tests and records results |

### 3.2 Upserts State — Audit Configuration

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Configure Audit Rules** | `user.role >= 'admin'` | Opens AuditRuleConfig modal | `AuditRuleConfig` — 98vw |
| **Generate Report** | `user.role >= 'auditor'` | Opens AuditReport modal | `AuditReport` — 98vw |

### 3.3 Workspace State — Audit Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Audit Trail** | `user.role >= 'viewer'` | Opens AuditTrailSearch modal | `AuditTrailSearch` — 98vw |
| **Run Compliance Check** | `user.role >= 'auditor'` | Opens ComplianceCheck modal | `ComplianceCheck` — 98vw |
| **Execute Control Test** | `user.role >= 'auditor'` | Opens ControlTest modal | `ControlTest` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Compliance Assessment Categories

| Category | Rules | Frequency |
|----------|-------|-----------|
| Financial Compliance | PO vs budget, invoice vs PO match | Per transaction |
| Regulatory Compliance | CIDB, BBBEE, tax clearance verification | Per supplier engagement |
| Policy Compliance | Approval chain adherence, role-based access | Continuous |
| Documentation Compliance | Required documents per order type | Per order creation |

### 4.2 Control Test Types

| Test Type | Description | Frequency |
|-----------|-------------|-----------|
| Segregation of Duties | Verify creator ≠ approver | Monthly |
| Approval Limit Check | Verify approvals within authority limits | Per approval |
| Access Control Review | Verify correct role assignments | Quarterly |
| Data Integrity Check | Verify checksums on audit events | Daily |

---

## 5. Testing Checklist (PROC-AUDIT-specific)

- [ ] All audit events captured with correct checksums
- [ ] Audit trail search filters work for all criteria
- [ ] Compliance assessment rules produce correct pass/fail results
- [ ] Control tests execute and record results accurately
- [ ] Regulatory report generates correct format and content
- [ ] Audit trail export (PDF, CSV) produces complete data
- [ ] Role gates restrict audit actions to authorized users

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-AUDIT override specification |

---

**Document Information**
- **Project**: PROC-AUDIT — Procurement Audit Workflow
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
