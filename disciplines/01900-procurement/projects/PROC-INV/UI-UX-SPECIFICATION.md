---
title: "PROC-INV — Invoice Processing & 3-Way Match Override Specification"
description: "Procurement-specific overrides for the 01900 Invoice Processing & 3-Way Match system. This document defines what's unique to PROC-INV — invoice receipt, matching algorithms, approval routing, exception handling, and payment integration. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-INV
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - invoice-processing
  - three-way-match
  - accounts-payable
  - payment-integration
  - procurement-workflow
  - override
---

# PROC-INV — Invoice Processing & 3-Way Match Override Specification

## Purpose

This document defines the **PROC-INV Invoice Processing overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `invoiceWorkflow` | Invoice Receipt → Validation → 3-Way Match → Approval → Payment | §2 |
| `roleGate` | `user.role >= 'viewer'` for view; `>= 'editor'` for invoice actions | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `matchStatus` | Full Match, Partial Match, Price Variance, Quantity Variance, Exception | §2 |

---

## 2. Invoice Workflow Overrides

### 2.1 3-Way Match Status Indicators

| Status | Colour | Description | Action Required |
|--------|--------|-------------|-----------------|
| Full Match | Green | PO = Receipt = Invoice | Auto-approve for payment |
| Partial Match | Yellow | Minor variances within tolerance | Manual review |
| Price Variance | Orange | Unit price mismatch | Supplier reconciliation |
| Quantity Variance | Orange | Quantity mismatch | Goods receipt verification |
| No PO Match | Red | No matching purchase order | Exception handling |
| No Receipt Match | Red | No matching goods receipt | Receipt verification |
| Exception | Red | Duplicate, invalid supplier, etc. | Investigation required |

### 2.2 Invoice Receipt Methods

| Method | Description | Processing Time |
|--------|-------------|-----------------|
| EDI | Electronic Data Interchange | Real-time |
| PDF Upload | Manual upload via Import modal | < 5 min |
| Email Capture | Automated extraction from email | < 10 min |
| Self-Billing | Generated from PO/receipt match | Real-time |
| Supplier Portal | Direct submission via portal | Real-time |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Invoice Agents

| Agent | Role | Description |
|-------|------|-------------|
| Invoice Capture Agent | Invoice receipt and data extraction | Processes incoming invoices via EDI, PDF, email |
| Matching Agent | 3-way match execution | Compares invoice, PO, and receipt line items |
| Exception Handler | Variance investigation and resolution | Manages exception queue and dispute process |
| Payment Scheduler | Payment processing and scheduling | Arranges payments based on due dates and cash flow |

### 3.2 Upserts State — Invoice Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Upload Invoice** | `user.role >= 'editor'` | Opens InvoiceUpload modal | `InvoiceUpload` — 98vw |
| **Manual Match** | `user.role >= 'editor'` | Opens ManualMatch modal | `ManualMatch` — 98vw |
| **Create Credit Note** | `user.role >= 'editor'` | Opens CreditNote modal | `CreditNote` — 98vw |

### 3.3 Workspace State — Invoice Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Approve Invoice** | `user.role >= 'reviewer'` | Opens Approval modal | `Approval` — 98vw |
| **Reject Invoice** | `user.role >= 'reviewer'` | Opens Rejection modal | `Rejection` — 98vw |
| **Schedule Payment** | `user.role >= 'editor'` | Opens PaymentSchedule modal | `PaymentSchedule` — 98vw |
| **View Match Detail** | `user.role >= 'viewer'` | Opens MatchDetail modal | `MatchDetail` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Invoice Lifecycle
```
RECEIVED → VALIDATING → MATCHING → PENDING_APPROVAL → APPROVED → SCHEDULED → PAID
                                          ↓              ↓
                                     REJECTED      EXCEPTION
```

### 4.2 Matching Tolerance Rules

| Variance Type | Tolerance | Auto-Approve |
|---------------|-----------|--------------|
| Price Variance | ± 2% | Yes |
| Quantity Variance | ± 5% | Yes |
| Tax Variance | Exact match | No |
| Freight Variance | ± 10% | No |
| Discount Variance | Exact match | No |

### 4.3 Approval Thresholds

| Invoice Amount | Approval Required |
|---------------|------------------|
| < 25K | Team Lead |
| 25K - 250K | Manager |
| > 250K | Director |
| > 1M | CFO |

---

## 5. Testing Checklist (PROC-INV-specific)

- [ ] Invoice data extraction works for PDF, image, and EDI formats
- [ ] 3-way match correctly identifies match status for all scenarios
- [ ] Variance calculations match expected tolerance rules
- [ ] Exception handling workflow routes correctly
- [ ] Payment scheduling respects due dates and approval status
- [ ] Invoice lifecycle transitions through all states correctly
- [ ] Role gates enforce correct access at each step

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-INV override specification |

---

**Document Information**
- **Project**: PROC-INV — Invoice Processing & 3-Way Match
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
