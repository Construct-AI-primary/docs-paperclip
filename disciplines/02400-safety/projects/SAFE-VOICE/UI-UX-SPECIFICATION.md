---
title: "SAFE-VOICE — Safety Voice Call Override Specification"
description: "Safety-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines how Safety 02400 customises the modal for emergency contacts, incident response, and contractor safety coordination calls."
version: 1.0
date: 2026-04-29
project_code: SAFE-VOICE
discipline: 02400-safety
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - emergency-response
  - safety
  - incident-coordination
  - override
---

# SAFE-VOICE — Safety Voice Call Override Specification

## Purpose

This document defines the **02400 Safety discipline overrides** for the shared Voice Communication system. All core behaviour (modal container, state machine, number selection engine, document attachment system, colours, screen states) is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the safety-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Contractor/emergency contact ID from incident or vetting context | §2 |
| `getPhoneNumbers()` | `contractors.emergency_phone`, `contractor_contacts.phone`, emergency services directory | §2 |
| `getCallDocumentSources()` | HSSE evaluations, safety files, incident reports, contractor vetting docs | §3 |
| `triggerWorkflow` | 02400 Emergency Response / Incident Management Workflow | §4 |
| `roleGate` | `user.role >= 'safety_officer'` | §4 |
| `disciplineCode` | `"02400"` | §5 |
| `accentColour` | `#E65100` (Orange — Safety/Emergency) | §6 |
| `contextLabels` | "Incident report", "HSSE evaluation", "Contractor safety file", "Emergency protocol", "Site hazard notice" | §3 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

The VoiceCall modal may be triggered from:
1. **Incident Management Workflow** — passes `emergencyContactId` or `contractorId`
2. **Contractor Vetting Workflow** — passes `contractorId` from the vetting pipeline
3. **Quick-dial emergency panel** — predefined emergency services (Fire, Medical, HSSE)

```typescript
interface VoiceCallProps {
  entityId: string;           // contractor.id, emergencyContact.id, or emergency-service id
  entityName: string;         // contact or organisation name
  workflowId: string;         // incident.id or vetting.id
  userId: string;             // current user
  callPriority: 'standard' | 'urgent' | 'emergency';
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

Numbers are sourced from:

| Source Table | Field | Indicator | Priority |
|-------------|-------|-----------|----------|
| `contractors.emergency_phone` | Contractor emergency line | 📞 Primary Contact | High |
| `contractor_contacts.phone` | Site safety officer direct | 👤 Contact Person | High |
| `emergency_contacts.phone` | Emergency services (Fire, Medical) | 📞 Primary Contact | Highest |
| `contractor_sites.phone` | Site office | 🏢 Site Office | Normal |

When `callPriority === 'emergency'`, the modal auto-selects the emergency contact and bypasses the dropdown (user can still change).

### 2.3 Number Format

Country code defaults to `+27` (South Africa). Safety numbers should always display in full international format `+27 XX XXX XXXX` without masking to ensure clarity during emergencies.

---

## 3. Document Sources (getCallDocumentSources)

The safety document picker sources from:

| Source | Description |
|--------|-------------|
| HSSE evaluations | Active contractor HSSE evaluation documents |
| Safety files | Contractor safety files (SDS, risk assessments) |
| Incident reports | Current or related incident reports |
| Contractor vetting docs | Vet-02400 vetting records, POE, compliance docs |
| Manual upload | Drag-and-drop or file browse |

### 3.1 Purpose Labels

| Label | Description |
|-------|-------------|
| "Incident report" | The incident report being addressed |
| "HSSE evaluation" | Contractor HSSE evaluation for reference |
| "Contractor safety file" | Safety file with risk assessments |
| "Emergency protocol" | Relevant emergency protocol or evacuation plan |
| "Site hazard notice" | Active hazard notice for the site |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

The VoiceCall modal can be launched from:
1. **02400 Emergency Response Workflow** — "Call Emergency Contact" button
2. **02400 Incident Management Workflow** — "Contact Safety Officer" button
3. **Contractor Vetting Panel** — "Call Contractor" button during vetting
4. **Quick-dial bar** — Fixed emergency contacts (Fire, Medical, HSSE) always visible in the 02400 workspace header

### 4.2 Role Gate

```
gate = user.role >= 'safety_officer'
```

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `worker` | 1 | No |
| `safety_officer` | 2 | Yes |
| `admin` | 3 | Yes |

**Emergency override**: When `callPriority === 'emergency'`, ALL roles can place calls to pre-configured emergency numbers. The gate only applies to non-emergency calls.

### 4.3 Post-Call Integration

After a call from the Incident Management Workflow, a mandatory log entry is created:
> *"Log call outcome"* — recording duration, outcome, and notes. This is linked to the incident timeline.

---

## 5. Audit Log Discipline Code

All calls placed from 02400 Safety MUST log with `discipline: "02400"`. Emergency calls additionally tag `call_type: "emergency"` for audit filtering.

---

## 6. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#E65100` (Orange — Safety/Emergency) |
| Header badge label | `"Safety"` |
| Context label (emergency) | `"Emergency Call"` |
| Context label (standard) | `"Safety Coordination Call"` |
| Emergency indicator | Red flash pulse on modal border when `callPriority === 'emergency'` |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial safety voice call override |

---

**Document Information**
- **Discipline**: 02400 Safety (HSSE)
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)