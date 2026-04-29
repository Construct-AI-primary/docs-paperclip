---
title: "PROC-SUPP — Supplier Qualification & Performance Monitoring Override Specification"
description: "Procurement-specific overrides for the 01900 Supplier Qualification & Performance Monitoring system. This document defines what's unique to PROC-SUPP — supplier registration, pre-qualification workflow, performance monitoring, quality incident management, and compliance assessment. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-SUPP
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - supplier-qualification
  - performance-monitoring
  - compliance-automation
  - quality-incident
  - supplier-development
  - override
---

# PROC-SUPP — Supplier Qualification & Performance Monitoring Override Specification

## Purpose

This document defines the **PROC-SUPP Supplier Qualification & Performance Monitoring overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `supplierWorkflow` | Supplier Registration → Pre-Qualification → Performance Monitoring → Quality Incident → Development Plans | §2 |
| `roleGate` | `user.role >= 'viewer'` for view; `>= 'editor'` for supplier management | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `supplierStatus` | Pending, Approved, Suspended, Blacklisted | §2 |

---

## 2. Supplier Qualification Workflow Overrides

### 2.1 Supplier Registration Form

| Section | Fields | Validation |
|---------|--------|------------|
| Business Information | Business name, registration number, tax ID, BBBEE level | All required, tax ID format |
| Contact Details | Email, phone, physical address, postal address | Email format, phone min 10 digits |
| Qualifications | Industry certifications, CIDB grading, professional registrations | At least 1 certification |
| Financial Information | Banking details, credit reference, financial statements | Bank account validation |
| Compliance | Tax clearance, COIDA, insurance, safety file | All required for approval |

### 2.2 Pre-Qualification Assessment

| Assessment Area | Criteria | Pass Score |
|----------------|----------|------------|
| Financial Stability | Credit score, liquidity ratio, D&B rating | > 60/100 |
| Technical Capability | Equipment, personnel, experience | > 70/100 |
| Safety Record | Incident rate, safety file completeness | > 80/100 |
| Quality System | ISO certification, quality records | Certified or equivalent |
| BBBEE Compliance | BBBEE level verification | Level 1-4 preferred |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Supplier Agents

| Agent | Role | Description |
|-------|------|-------------|
| Registration Agent | Supplier onboarding | Processes supplier registration applications |
| Qualification Assessor | Pre-qualification evaluation | Evaluates supplier against qualification criteria |
| Performance Monitor | Ongoing performance tracking | Monitors supplier KPIs and generates scorecards |
| Compliance Officer | Compliance verification | Verifies tax clearance, BBBEE, safety compliance |
| Development Manager | Supplier development planning | Creates and tracks supplier development plans |

### 3.2 Upserts State — Supplier Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Register Supplier** | `user.role >= 'editor'` | Opens SupplierRegistration modal | `SupplierRegistration` — 98vw |
| **Run Qualification** | `user.role >= 'editor'` | Opens QualificationAssessment modal | `QualificationAssessment` — 98vw |
| **Create Development Plan** | `user.role >= 'editor'` | Opens DevelopmentPlan modal | `DevelopmentPlan` — 98vw |

### 3.3 Workspace State — Supplier Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Scorecard** | `user.role >= 'viewer'` | Opens SupplierScorecard modal | `SupplierScorecard` — 98vw |
| **Approve Supplier** | `user.role >= 'reviewer'` | Opens SupplierApproval modal | `SupplierApproval` — 98vw |
| **Suspend Supplier** | `user.role >= 'manager'` | Opens Suspension modal | `Suspension` — 98vw |
| **Log Incident** | `user.role >= 'editor'` | Opens QualityIncident modal | `QualityIncident` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Supplier Lifecycle
```
PENDING_REGISTRATION → SUBMITTED → UNDER_REVIEW → QUALIFIED → APPROVED → ACTIVE → SUSPENDED → BLACKLISTED
                                                                                               ↓
                                                                                          REINSTATED
```

### 4.2 Performance Scorecard Categories

| Category | Weight | Metrics |
|----------|--------|---------|
| Delivery Performance | 0.25 | On-time delivery rate, lead time compliance |
| Quality Performance | 0.25 | NCR rate, defect percentage, rework rate |
| Commercial | 0.20 | Pricing competitiveness, invoice accuracy |
| Compliance | 0.15 | Regulatory compliance, safety record, BBBEE |
| Relationship | 0.15 | Communication, responsiveness, cooperation |

### 4.3 Supplier Development Plans

| Development Area | Typical Actions | Review Period |
|-----------------|----------------|---------------|
| Quality Improvement | Process improvement, training | 3 months |
| Capacity Building | Equipment investment, staff training | 6 months |
| Compliance Enhancement | Safety system, quality management | 3 months |
| BBBEE Improvement | Ownership, management control | 12 months |

---

## 5. Testing Checklist (PROC-SUPP-specific)

- [ ] Supplier registration form validates all fields correctly
- [ ] Pre-qualification assessment calculates weighted scores accurately
- [ ] Performance scorecard generates with correct category weights
- [ ] Quality incident logging routes to correct handlers
- [ ] Supplier approval workflow enforces correct role gates
- [ ] Supplier development plan tracks progress against milestones
- [ ] Supplier lifecycle transitions correctly through all states
- [ ] Role gates restrict suspension/blacklist to managers+

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-SUPP override specification |

---

**Document Information**
- **Project**: PROC-SUPP — Supplier Qualification & Performance Monitoring
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
