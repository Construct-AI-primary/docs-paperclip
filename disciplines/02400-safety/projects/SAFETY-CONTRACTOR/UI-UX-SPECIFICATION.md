---
title: "SAFETY-CONTRACTOR — Contractor Safety Management UI/UX Specification"
description: "Contractor safety management project under 02400 Safety. Covers contractor vetting, safety onboarding, performance monitoring, and compliance tracking. Extends the discipline-level 02400 Safety specification with contractor-specific overrides."
version: 1.0
date: 2026-04-29
project_code: SAFETY-CONTRACTOR
discipline: 02400-safety
extends: docs-paperclip/disciplines/02400-safety/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - safety
  - contractor-safety
  - contractor-vetting
  - compliance
  - specification
---

# SAFETY-CONTRACTOR — Contractor Safety Management UI/UX Specification

## Purpose

This document defines the **SAFETY-CONTRACTOR** project under the 02400 Safety discipline. It extends the discipline-level specification with contractor safety management-specific customisations. All core behaviours (three-state navigation, modal patterns, RAG status colours, HITL integration, AI model backend) are inherited from the parent discipline spec.

---

## 1. Override Summary Table

| Override | Value | Where Defined |
|----------|-------|---------------|
| entityId source | Contractor ID from prequalification workflow | §3 |
| getPhoneNumbers() | contractor_safety_officers.phone + site_supervisors.phone + contractor_24hr.phone | §3 |
| getCallDocumentSources() | Safety files, method statements, risk assessments, insurance certs | §4 |
| triggerWorkflow | 02400 Contractor Onboarding & Vetting Workflow | §5 |
| roleGate | user.role >= vetting_officer for approvals | §5 |
| disciplineCode | "02400" | §6 |
| accentColour | #D32F2F (Safety Red) | Inherited |
| contextLabels | "Safety file", "Method statement", "Risk assessment", "Insurance cert", "Site induction" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

```typescript
interface VoiceCallProps {
  entityId: string;
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| contractor_safety_officers.phone | Contractor safety officer | Primary Contact |
| site_supervisors.phone | Site supervisor direct line | Contact Person |
| contractor_24hr.phone | 24-hour contractor helpline | Mobile Contact |

---

## 3. Document Sources

| Source | Description | Max Count |
|--------|-------------|-----------|
| Contractor safety files | Current safety file and compliance docs | All |
| Method statements | Safe work method statements (SWMS) | 20 |
| Risk assessments | Activity-specific risk assessments | 20 |
| Insurance certificates | Public liability and COID certs | 5 |

### 3.1 Contractor-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Safety file" | Contractor safety file reference |
| "Method statement" | Safe work method statement |
| "Risk assessment" | Activity risk assessment |
| "Insurance cert" | Insurance or COID certificate |
| "Site induction" | Site-specific induction record |

---

## 4. Workflow-Specific Overrides

### 4.1 Contractor Vetting Workflow

| Element | Override |
|---------|----------|
| Entity source | Contractor prequalification data, safety compliance records |
| Phone sources | Contractor safety officer, 24hr helpline |
| Document sources | Safety files, insurance certs, training records |
| Key actions | Vet contractor, approve prequalification, issue access |
| Role gate | user.role >= vetting_officer |
| Trigger | New contractor application or renewal |

### 4.2 Contractor Monitoring Workflow

| Element | Override |
|---------|----------|
| Entity source | On-site contractor performance records |
| Phone sources | Site supervisor, contractor safety officer |
| Document sources | Inspection reports, incident records, observation cards |
| Key actions | Review performance, schedule audit, issue non-compliance |
| Role gate | user.role >= safety_officer |
| Trigger | Scheduled review or reported incident |

---

## 5. Role Gates

| Action | Gate |
|--------|------|
| View contractor list | user.role >= viewer |
| Edit contractor record | user.role >= editor |
| Vet/approve contractor | user.role >= vetting_officer |
| Issue non-compliance | user.role >= safety_officer |
| Suspend contractor access | user.role >= admin |

### 5.1 Contractor-specific Role Definitions

| Role | Level | Can Call? |
|------|-------|-----------|
| viewer | 0 | No |
| editor | 1 | Yes (standard records) |
| safety_officer | 2 | Yes |
| vetting_officer | 2 | Yes |
| admin | 3 | Yes |

Users below safety_officer see call buttons disabled with tooltip: "You need Safety Officer access to place calls."

---

## 6. Trigger Workflow Integration

The VoiceCall modal is launched from the **02400 Contractor Onboarding & Vetting Workflow**.

### 6.1 Post-Call Integration

After call completion, optional note-entry prompt: "Log call outcome?" posting duration, outcome, summary, and attached document IDs to the contractor communication timeline.

---

## 7. Discipline Integration Points

### 7.1 VoiceForge AI Payload

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "context": {
    "entityId": "{{contractorId}}",
    "discipline": "02400",
    "workflow": "contractor_vetting",
    "documents": []
  }
}
```

---

## 8. Audit Log

All calls log with discipline: "02400" and workflow: "contractor-safety".

---

## 9. Testing Checklist

- Phone numbers load from contractor safety officers, site supervisors, 24hr helpline
- Primary number auto-selected; dropdown shows all numbers with source indicators
- Call button hidden when user.role < safety_officer
- Post-call note prompt appears in contractor timeline
- Document picker shows safety files, method statements, risk assessments, insurance certs
- Audit log records discipline: "02400" with workflow: "contractor-safety"

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial SAFETY-CONTRACTOR specification |

---

**Document Information**
- Project: SAFETY-CONTRACTOR
- Discipline: 02400 Safety
- Date: 2026-04-29
- Status: Active
- Extends: 02400 Safety UI/UX Specification
