---
title: "PROC-TRACK — Order Tracking & Expediting Override Specification"
description: "Procurement-specific overrides for the 01900 Order Tracking & Expediting system. This document defines what's unique to PROC-TRACK — order tracking dashboard, delay detection, expediting workflow, customer communication, and supplier performance tracking. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-TRACK
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - order-tracking
  - delay-detection
  - expediting
  - customer-communication
  - procurement-tracking
  - override
---

# PROC-TRACK — Order Tracking & Expediting Override Specification

## Purpose

This document defines the **PROC-TRACK Order Tracking & Expediting overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `trackingWorkflow` | Order Tracking → Delay Detection → Expediting → Customer Communication → Status Reporting | §2 |
| `roleGate` | `user.role >= 'viewer'` for tracking; `>= 'editor'` for expediting actions | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `trackingStatus` | On Track, At Risk, Delayed, Critical, Completed | §2 |

---

## 2. Order Tracking Workflow Overrides

### 2.1 Tracking Status Indicators

| Status | Colour | Description | Action Required |
|--------|--------|-------------|-----------------|
| On Track | Green | Order proceeding as scheduled | None — monitor |
| At Risk | Yellow | Minor delay detected, within float | Review mitigation options |
| Delayed | Orange | Confirmed delay beyond tolerance | Initiate expediting |
| Critical | Red | Delay impacting critical path | Escalate to management |
| Completed | Blue | Order delivered and accepted | Close out |

### 2.2 Delay Detection Engine

| Detection Method | Data Source | Alert Triggers |
|-----------------|-------------|----------------|
| Supplier Promise Date | Order line item dates | Promise date + 1 day past due |
| Production Milestones | Supplier progress updates | Milestone missed by > 2 days |
| Shipping Status | Carrier tracking integration | No update in > 48 hours |
| Schedule Integration | Project schedule (Gantt) | Float consumed > 50% |
| Manual Flag | User input | Immediate escalation |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Tracking Agents

| Agent | Role | Description |
|-------|------|-------------|
| Tracking Monitor | Real-time order status monitoring | Tracks all orders, detects delays automatically |
| Expediting Agent | Supplier expediting and escalation | Manages expediting actions and supplier communication |
| Customer Communicator | Customer status reporting | Generates and distributes order status reports |

### 3.2 Upserts State — Tracking Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Register Order for Tracking** | `user.role >= 'editor'` | Opens RegisterOrder modal | `RegisterOrder` — 98vw |
| **Update Status** | `user.role >= 'editor'` | Opens StatusUpdate modal | `StatusUpdate` — 98vw |
| **Import Tracking Data** | `user.role >= 'editor'` | Opens TrackingImport modal | `TrackingImport` — 98vw |

### 3.3 Workspace State — Tracking Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Initiate Expediting** | `user.role >= 'editor'` | Opens Expediting modal | `Expediting` — 98vw |
| **Send Status Report** | `user.role >= 'viewer'` | Opens StatusReport modal | `StatusReport` — 98vw |
| **Flag Delay** | `user.role >= 'editor'` | Opens DelayFlag modal | `DelayFlag` — 98vw |
| **View Order Timeline** | `user.role >= 'viewer'` | Opens OrderTimeline modal | `OrderTimeline` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Expediting Actions

| Expediting Level | Actions | Escalation |
|-----------------|---------|------------|
| Level 1 — Reminder | Automated email reminder to supplier | System-generated |
| Level 2 — Follow-up | Personal call/email from expediter | Expediter action |
| Level 3 — Escalation | Supplier management contact | Procurement Manager |
| Level 4 — Critical | Supplier executive contact, alternative sourcing | Procurement Director |

### 4.2 Customer Communication Templates

| Template | Trigger | Content |
|----------|---------|---------|
| Order Confirmed | Order placed | Order number, supplier, expected delivery |
| Status Update | Weekly or on change | Current status, next milestone, any alerts |
| Delay Notification | Delay detected | Reason for delay, revised delivery, impact |
| Resolution Notice | Delay resolved | Corrective action taken, updated timeline |
| Completion Notice | Order delivered | Delivery confirmation, next steps |

---

## 5. Testing Checklist (PROC-TRACK-specific)

- [ ] Tracking dashboard shows all orders with correct status indicators
- [ ] Delay detection engine triggers alerts at correct thresholds
- [ ] Expediting workflow escalates through correct levels
- [ ] Customer communication templates render with correct variable substitution
- [ ] Order timeline shows all events in chronological order
- [ ] Status report generation includes all relevant data
- [ ] Role gates enforce correct access for expediting actions

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-TRACK override specification |

---

**Document Information**
- **Project**: PROC-TRACK — Order Tracking & Expediting
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
