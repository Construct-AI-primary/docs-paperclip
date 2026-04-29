---
title: "PROC-SERVICE — Service Order Management Override Specification"
description: "Procurement-specific overrides for the 01900 Service Order Management system. This document defines what's unique to PROC-SERVICE — service specification, provider selection, SLA development, delivery monitoring, and acceptance workflow. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-SERVICE
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - service-procurement
  - provider-selection
  - sla-management
  - delivery-monitoring
  - acceptance-workflow
  - override
---

# PROC-SERVICE — Service Order Management Override Specification

## Purpose

This document defines the **PROC-SERVICE Service Order Management overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `serviceWorkflow` | Service Specification → Provider Selection → SLA Development → Delivery Monitoring → Acceptance | §2 |
| `roleGate` | `user.role >= 'editor'` for service orders; `>= 'reviewer'` for acceptance | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `serviceTypes` | Consulting, Maintenance, Installation, Training, Support | §2 |

---

## 2. Service Order Workflow Overrides

### 2.1 Service Types

| Type | Description | Typical SLA Requirements |
|------|-------------|------------------------|
| Consulting | Professional advisory services | Deliverable-based milestones |
| Maintenance | Ongoing equipment/facility maintenance | Response time, uptime guarantees |
| Installation | Equipment/system installation | Completion timeline, handover criteria |
| Training | Skills transfer and capability building | Training hours, competency assessment |
| Support | Technical support and helpdesk | Response time, resolution time |

### 2.2 Service Provider Qualification

| Qualification Criteria | Weight | Verification Method |
|----------------------|--------|-------------------|
| Relevant Experience | 0.30 | Case studies, client references |
| Certifications | 0.20 | Professional certifications, industry accreditations |
| Resource Availability | 0.20 | Staff allocation plan, CVs |
| Financial Stability | 0.15 | Financial statements, credit check |
| Safety Record | 0.15 | Safety statistics, insurance coverage |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Service Agents

| Agent | Role | Description |
|-------|------|-------------|
| Service Specifier | Service requirement definition | Creates detailed service specifications |
| Provider Qualifier | Provider evaluation and selection | Assesses and qualifies service providers |
| SLA Manager | Service level agreement development | Drafts and manages SLAs with providers |
| Delivery Monitor | Service delivery tracking | Monitors service delivery against SLAs |
| Acceptance Officer | Service acceptance and sign-off | Manages acceptance testing and sign-off |

### 3.2 Upserts State — Service Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create Service Order** | `user.role >= 'editor'` | Opens ServiceOrder modal | `ServiceOrder` — 98vw |
| **Define SLA** | `user.role >= 'editor'` | Opens SLADefinition modal | `SLADefinition` — 98vw |
| **Qualify Provider** | `user.role >= 'editor'` | Opens ProviderQualification modal | `ProviderQualification` — 98vw |

### 3.3 Workspace State — Service Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Accept Service** | `user.role >= 'reviewer'` | Opens Acceptance modal | `Acceptance` — 98vw |
| **Log Delivery Issue** | `user.role >= 'editor'` | Opens DeliveryIssue modal | `DeliveryIssue` — 98vw |
| **View SLA Compliance** | `user.role >= 'viewer'` | Opens SLACompliance modal | `SLACompliance` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Service Order Lifecycle
```
DRAFT → SPECIFIED → PROVIDER_SELECTED → SLA_SIGNED → IN_PROGRESS → DELIVERED → ACCEPTED → COMPLETED
                                                                                        ↓
                                                                                   CANCELLED
```

### 4.2 SLA Compliance Monitoring

| SLA Metric | Target | Monitoring Method |
|------------|--------|-------------------|
| Response Time | < 4 hours | Automated ticket tracking |
| Resolution Time | < 24 hours | Automated ticket tracking |
| Uptime | > 99.5% | System monitoring |
| Quality Score | > 4.0/5.0 | Customer satisfaction surveys |
| Milestone Completion | On schedule | Project tracking |

---

## 5. Testing Checklist (PROC-SERVICE-specific)

- [ ] Service order creation wizard captures all required specification fields
- [ ] Provider qualification evaluates all weighted criteria correctly
- [ ] SLA definition modal captures all required service levels
- [ ] Delivery monitoring dashboard shows real-time SLA compliance
- [ ] Acceptance workflow captures sign-off with correct role gate
- [ ] Service lifecycle transitions correctly through all states
- [ ] Role gates enforce correct access at each workflow step

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-SERVICE override specification |

---

**Document Information**
- **Project**: PROC-SERVICE — Service Order Management
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)
