---
title: "PROC-NCR — Non-Conformance Resolution & Quality Management Override Specification"
description: "Procurement-specific overrides for the 01900 Non-Conformance Resolution & Quality Management system. This document defines what's unique to PROC-NCR — NCR initiation, root cause analysis, corrective action planning, effectiveness verification, and supplier quality tracking. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-NCR
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - non-conformance
  - quality-management
  - root-cause-analysis
  - corrective-action
  - supplier-quality
  - override
---

# PROC-NCR — Non-Conformance Resolution & Quality Management Override Specification

## Purpose

This document defines the **PROC-NCR Non-Conformance Resolution overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `ncrWorkflow` | NCR Initiation → Validation → Root Cause Analysis → Corrective Action → Effectiveness Verification → Closure | §2 |
| `roleGate` | `user.role >= 'editor'` for NCR creation; `>= 'reviewer'` for verification | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `ncrSeverity` | Critical, Major, Minor, Observation | §2 |

---

## 2. NCR Workflow Overrides

### 2.1 NCR Severity Levels

| Severity | Colour | Description | Response SLA |
|----------|--------|-------------|--------------|
| Critical | Red | Safety issue or major non-conformance | < 4 hours |
| Major | Orange | Significant quality or delivery impact | < 24 hours |
| Minor | Yellow | Minor non-conformance, no operational impact | < 5 days |
| Observation | Blue | Potential issue, no non-conformance yet | < 10 days |

### 2.2 Root Cause Analysis Methods

| Method | Description | Best For | UI Component |
|--------|-------------|----------|--------------|
| 5 Whys | Iterative questioning to find root cause | Simple issues | Structured form with 5 question fields |
| Fishbone (Ishikawa) | Causal diagram across categories | Complex issues | Interactive diagram builder |
| FMEA | Failure Mode and Effects Analysis | Process failures | Matrix with severity/occurrence/detection |
| Fault Tree | Top-down logical analysis | System failures | Tree diagram builder |

---

## 3. State-Specific Overrides

### 3.1 Agents State — NCR Agents

| Agent | Role | Description |
|-------|------|-------------|
| NCR Initiator | NCR creation and validation | Creates NCR records, validates defect descriptions |
| RCA Analyst | Root cause analysis execution | Conducts investigations using appropriate analysis methods |
| Corrective Action Manager | Action planning and tracking | Creates and monitors corrective/preventive actions |
| Quality Verifier | Effectiveness verification | Tests and verifies corrective action effectiveness |
| Supplier Quality Tracker | Supplier performance monitoring | Tracks supplier quality scores and trends |

### 3.2 Upserts State — NCR Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create NCR** | `user.role >= 'editor'` | Opens NCRCreation modal | `NCRCreation` — 98vw |
| **Conduct RCA** | `user.role >= 'editor'` | Opens RootCauseAnalysis modal | `RootCauseAnalysis` — 98vw |
| **Plan Corrective Action** | `user.role >= 'editor'` | Opens CorrectiveAction modal | `CorrectiveAction` — 98vw |

### 3.3 Workspace State — NCR Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Verify Effectiveness** | `user.role >= 'reviewer'` | Opens Verification modal | `Verification` — 98vw |
| **Approve Closure** | `user.role >= 'reviewer'` | Opens ClosureApproval modal | `ClosureApproval` — 98vw |
| **View Supplier Quality** | `user.role >= 'viewer'` | Opens SupplierQuality modal | `SupplierQuality` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 NCR Lifecycle
```
DRAFT → SUBMITTED → VALIDATING → INVESTIGATING → PLANNING → IMPLEMENTING → VERIFYING → CLOSED
                                                                                        ↓
                                                                                   CANCELLED
```

### 4.2 Supplier Quality Score Calculation

| Metric | Weight | Calculation |
|--------|--------|-------------|
| NCR Rate | 0.25 | NCRs per 100 deliveries |
| On-Time Delivery | 0.25 | % of deliveries on time |
| Quality Audit Score | 0.20 | Audit results score (0-100) |
| Corrective Action Completion | 0.15 | % of CAPAs completed on time |
| Response Time | 0.15 | Average hours to first response |

### 4.3 Supplier Grades

| Grade | Score Range | Action Required |
|-------|-------------|-----------------|
| A | 90-100 | Preferred supplier — automatic PO approval |
| B | 80-89 | Approved — standard processing |
| C | 70-79 | Conditional — enhanced monitoring |
| D | 60-69 | At-risk — development plan required |
| F | < 60 | Suspended — no new orders |

---

## 5. Testing Checklist (PROC-NCR-specific)

- [ ] NCR creation form validates all required fields based on severity
- [ ] Root cause analysis methods (5 Whys, Fishbone, FMEA) render correctly
- [ ] Corrective action planning generates recommendations from root causes
- [ ] Effectiveness verification tests execute according to test protocol
- [ ] Supplier quality score calculates correctly with all weighted metrics
- [ ] Supplier grade assignment matches score ranges
- [ ] NCR lifecycle transitions correctly through all states

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-NCR override specification |

---

**Document Information**
- **Project**: PROC-NCR — Non-Conformance Resolution & Quality Management
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
