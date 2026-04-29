---
title: "PROC-AMEND — Contract Amendment Workflow Override Specification"
description: "Procurement-specific overrides for the 01900 Contract Amendment Workflow. This document defines what's unique to PROC-AMEND — amendment request processing, impact assessment, approval routing, and document update implementation. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-AMEND
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - contract-amendment
  - approval-routing
  - document-automation
  - impact-assessment
  - procurement-workflow
  - override
---

# PROC-AMEND — Contract Amendment Workflow Override Specification

## Purpose

This document defines the **PROC-AMEND Contract Amendment Workflow overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Contract ID from contract registry | §2 |
| `amendmentWorkflow` | Amendment Request → Validation → Impact Assessment → Approval → Document Update → Communication | §2 |
| `roleGate` | `user.role >= 'editor'` for requests; `>= 'reviewer'` for approval | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `stateLabels` | Agents, Upserts, Workspace (inherited) | §5 |

---

## 2. Amendment Workflow Overrides

### 2.1 Amendment Request Types

The AmendmentRequest modal supports these specific types for PROC-AMEND:

| Type | Description | Approval Level Required |
|------|-------------|------------------------|
| Scope Change | Modification of contract scope/deliverables | Level 3+ |
| Price Adjustment | Change in contract value | Level 2+ (value-dependent) |
| Term Extension | Extension of contract duration | Level 2 |
| Delivery Modification | Change to delivery schedule/milestones | Level 1 |
| Party Addition | Adding a new contracting party | Level 4 |
| Termination | Early termination of contract | Level 5 (Board) |

### 2.2 Amendment Wizard

The CreateAmendmentModal follows a 5-step wizard:

| Step | Title | Content |
|------|-------|---------|
| 1 | Request Details | Amendment type selector, contract selector, justification |
| 2 | Impact Assessment | Automatic impact scoring across financial, operational, legal, technical, scheduling, resource categories |
| 3 | Approval Routing | Dynamic approval matrix generated based on amendment type and value |
| 4 | Document Updates | Section-level changes with version control, AI-powered amendment location detection |
| 5 | Communication | Notification templates, stakeholder distribution, review and submit |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Amendment Agents

| Agent | Role | Description |
|-------|------|-------------|
| Amendment Analyst | Request validation and triage | Classifies and routes amendment requests |
| Impact Assessor | Stakeholder consultation and impact scoring | Drives impact assessment workflow |
| Document Engineer | Automated document update processing | Applies amendments to contract documents |

### 3.2 Upserts State — Amendment Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **New Amendment** | `user.role >= 'editor'` | Opens CreateAmendment 5-step wizard | `CreateAmendment` — 98vw |
| **Import Amendment** | `user.role >= 'editor'` | Opens Import modal | `ImportAmendment` — 98vw |
| **View History** | `user.role >= 'viewer'` | Opens AmendmentHistory modal | `AmendmentHistory` — 98vw |

### 3.3 Workspace State — Amendment Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Approve** | `user.role >= 'reviewer'` | Opens Approval modal | `Approval` — 98vw |
| **Reject** | `user.role >= 'reviewer'` | Opens Rejection modal | `Rejection` — 98vw, required feedback |
| **Assign** | `user.role >= 'coordinator'` | Opens Assign modal | `Assign` — 98vw |
| **Compare Versions** | `user.role >= 'viewer'` | Opens VersionDiff modal | `VersionDiff` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Amendment Lifecycle
```
DRAFT → SUBMITTED → VALIDATING → ASSESSING → PENDING_APPROVAL → APPROVED → IMPLEMENTING → COMPLETED
         ↓                                      ↓
      CANCELLED                              DENIED
```

### 4.2 Impact Categories
| Category | Scoring Method | Weight |
|----------|---------------|--------|
| Financial | Value delta as percentage of contract | 0.30 |
| Operational | Disruption level assessment | 0.25 |
| Legal | Compliance/regulatory exposure | 0.20 |
| Technical | Implementation complexity | 0.15 |
| Scheduling | Schedule impact in days | 0.10 |

### 4.3 Approval Thresholds
| Amendment Type | < 25K | 25K - 250K | > 250K |
|---------------|-------|------------|--------|
| Scope Change | Level 2 | Level 3 | Level 4 |
| Price Adjustment | Level 1 | Level 2 | Level 3 |
| Term Extension | Level 1 | Level 2 | Level 2 |
| Party Addition | Level 4 | Level 4 | Level 5 |

---

## 5. Testing Checklist (PROC-AMEND-specific)

- [ ] Amendment request form validates all required fields
- [ ] Impact assessment generates correct scoring across all categories
- [ ] Approval matrix dynamically adjusts based on amendment type and value
- [ ] Document update engine correctly identifies amendment locations
- [ ] Version control creates proper diffs between document versions
- [ ] Communication templates render with correct variable substitution
- [ ] Amendment lifecycle transitions correctly through all states

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-AMEND override specification |

---

**Document Information**
- **Project**: PROC-AMEND — Contract Amendment Workflow
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
