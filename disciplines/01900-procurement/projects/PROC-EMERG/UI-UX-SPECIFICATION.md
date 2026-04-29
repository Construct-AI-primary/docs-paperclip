---
title: "PROC-EMERG — Emergency Procurement & Single-Source Justification Override Specification"
description: "Procurement-specific overrides for the 01900 Emergency Procurement & Single-Source Justification system. This document defines what's unique to PROC-EMERG — emergency classification, rapid validation, single-source justification, and expedited approval routing. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-EMERG
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - emergency-procurement
  - single-source-justification
  - fast-track-approval
  - compliance-automation
  - procurement-workflow
  - override
---

# PROC-EMERG — Emergency Procurement & Single-Source Justification Override Specification

## Purpose

This document defines the **PROC-EMERG Emergency Procurement overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `emergencyWorkflow` | Emergency Classification → Rapid Validation → Single-Source Justification → Expedited Approval → Documentation | §2 |
| `roleGate` | `user.role >= 'editor'` for requests; `>= 'manager'` for emergency approval | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `emergencyCategories` | Critical (<1hr), Urgent (<4hrs), Expedited (<24hrs) | §2 |

---

## 2. Emergency Workflow Overrides

### 2.1 Emergency Classification System

| Category | Response Time | Approval Level | Documentation Required |
|----------|--------------|----------------|----------------------|
| Critical (A) | < 1 hour | Level 1 (Manager) | Minimal — justification + photo |
| Urgent (B) | < 4 hours | Level 2 (Director) | Standard — justification + quote |
| Expedited (C) | < 24 hours | Level 1 (Manager) | Full — justification + 3 quotes |

### 2.2 Emergency Request Form

| Field | Type | Validation |
|-------|------|------------|
| Emergency Category | Radio (A/B/C) | Required |
| Description of Emergency | Textarea | Required, min 20 chars |
| Estimated Value | Currency input | Required |
| Single Source Reason | Dropdown | Required if single source |
| Supporting Evidence | File upload | Required for Category A |
| Impact Assessment | Textarea | Required |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Emergency Agents

| Agent | Role | Description |
|-------|------|-------------|
| Emergency Triage | Classification and routing | Assesses emergency level and routes appropriately |
| Single-Source Reviewer | Justification validation | Reviews and validates single-source justifications |
| Expedited Approver | Fast-track approval processing | Processes emergency approvals with priority routing |

### 3.2 Upserts State — Emergency Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **New Emergency Request** | `user.role >= 'editor'` | Opens EmergencyRequest modal | `EmergencyRequest` — 98vw |
| **Upload Documentation** | `user.role >= 'editor'` | Opens DocumentUpload modal | `DocumentUpload` — 98vw |

### 3.3 Workspace State — Emergency Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Approve Emergency** | `user.role >= 'manager'` | Opens EmergencyApproval modal | `EmergencyApproval` — 98vw |
| **Request Clarification** | `user.role >= 'reviewer'` | Opens Clarification modal | `Clarification` — 98vw |
| **View Emergency Log** | `user.role >= 'viewer'` | Opens EmergencyLog modal | `EmergencyLog` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Emergency Lifecycle
```
DRAFT → CLASSIFIED → VALIDATED → APPROVED → PROCUREMENT_INITIATED → COMPLETED
         ↓              ↓
      CANCELLED      REJECTED
```

### 4.2 Single-Source Justification Reasons

| Reason | Description | Audit Requirement |
|--------|-------------|-------------------|
| Extreme Urgency | Time constraints prevent competitive process | Full justification required |
| Sole Supplier | Only one supplier can provide the goods/services | Market research evidence |
| Standardization | Compatibility with existing equipment/systems | Technical justification |
| Patent/Proprietary | Protected intellectual property | Legal verification |
| Additional Work | Extension of existing contract | Reference to original contract |

### 4.3 Post-Emergency Documentation Requirements

| Category | Documentation Deadline | Audit Trail |
|----------|----------------------|-------------|
| Critical (A) | 48 hours | Full incident report + retrospective justification |
| Urgent (B) | 5 business days | Standard documentation package |
| Expedited (C) | 10 business days | Complete procurement file |

---

## 5. Testing Checklist (PROC-EMERG-specific)

- [ ] Emergency classification correctly categorizes by response time
- [ ] Emergency request form validates all required fields
- [ ] Single-source justification reasons display correctly
- [ ] Expedited approval routes to correct approver level
- [ ] Post-emergency documentation deadlines trigger correctly
- [ ] Emergency log shows complete lifecycle history
- [ ] Role gates restrict emergency approval to managers+

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-EMERG override specification |

---

**Document Information**
- **Project**: PROC-EMERG — Emergency Procurement & Single-Source Justification
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
