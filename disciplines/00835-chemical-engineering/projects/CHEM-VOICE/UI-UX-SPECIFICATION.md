---
title: "CHEM-VOICE — Chemical Engineering Voice Call Override Specification"
description: "Chemical Engineering-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from process safety contacts, HAZOP team members, and shift supervisors. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: CHEM-VOICE
discipline: 00835-chemical-engineering
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - process-safety
  - modal
  - chemical-engineering
  - override
---

# CHEM-VOICE — Chemical Engineering Voice Call Override Specification

## Purpose

This document defines the **00835 Chemical Engineering discipline overrides** for the shared Voice Communication system. All core behaviour (modal container, state machine, number selection engine, document attachment system, colours, screen states) is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the chemical-engineering-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Process unit / HAZOP study ID from current workflow context | §2 |
| `getPhoneNumbers()` | `process_safety_contacts.phone` + `shift_supervisors.phone` + `hazop_team.phone` | §3 |
| `getCallDocumentSources()` | P&IDs, HAZOP reports, process safety documents, shift logs | §4 |
| `triggerWorkflow` | 00835 Process Safety Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00835"` | §6 |
| `accentColour` | `#2E7D32` (Green — Engineering standard) | §7 |
| `contextLabels` | "P&ID reference", "HAZOP finding", "Process deviation", "Safety critical", "Shift handover" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

When the VoiceCall modal is triggered from the Process Safety Communication Workflow, the `processUnitId` or `hazopStudyId` is passed as a prop:

```typescript
interface VoiceCallProps {
  entityId: string;           // process_unit.id or hazop_study.id
  entityName: string;         // unit.name or study.title
  workflowId: string;         // communication.id
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `process_safety_contacts.phone` | Process safety officer line | 📞 Primary Contact |
| `shift_supervisors.phone` | Shift supervisor direct line | 👤 Contact Person |
| `hazop_team.phone` | HAZOP team member contact | 📱 Mobile Contact |

### 2.3 Number Format

International format with automatic masking. Country code defaults to `+27`.

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Process P&IDs | Piping and instrumentation diagrams for the unit | 10 |
| HAZOP study reports | HAZOP risk assessment and action tracking | All |
| Process safety docs | Safety data sheets, operating procedures | 15 |
| Shift logs | Recent shift handover notes and logs | 5 |

### 3.1 Chemical Engineering-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "P&ID reference" | Piping and instrumentation diagram reference |
| "HAZOP finding" | HAZOP study finding or recommendation |
| "Process deviation" | Recorded process deviation or upset |
| "Safety critical" | Safety-critical element or procedure |
| "Shift handover" | Shift handover notes and status |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00835 Process Safety Communication Workflow**. A "Call Safety Contact" button is rendered in the process safety panel.

### 4.2 Role Gate

`gate = user.role >= 'editor'`

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `commenter` | 1 | No |
| `editor` | 2 | Yes |
| `admin` | 3 | Yes |

### 4.3 Post-Call Workflow Integration

Optional note-entry prompt: *"Log call outcome?"* — posting duration, outcome, summary, and attached document IDs to the process safety communication timeline.

---

## 5. Integration Points

### 5.1 00835 Process Safety Directory

| Integration | Detail |
|-------------|--------|
| Data consumed | Process unit contacts, shift supervisor roster, HAZOP team directory |
| Direction | Read-only |
| Entry point | `useProcessUnit(id)` / `useHazopStudy(id)` hook |
| Fallback | Call button disabled if no numbers exist |

### 5.2 VoiceForge AI

Same as shared core with chemical engineering context payload.

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "context": {
    "entityId": "{{processUnitId}}",
    "discipline": "00835",
    "documents": []
  }
}
```

---

## 6. Audit Log Discipline Code

All calls placed from 00835 Chemical Engineering MUST log with `discipline: "00835"`.

---

## 7. Testing Checklist

- [ ] Phone numbers load from process safety, shift supervisor, HAZOP team sources
- [ ] Primary number auto-selected with correct source indicators
- [ ] Call button hidden when `user.role < 'editor'`
- [ ] Post-call prompt appears in process safety timeline
- [ ] Document picker shows P&IDs, HAZOP reports, safety docs, shift logs
- [ ] Audit log records `discipline: "00835"`
- [ ] Country code defaults to `+27`

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial CHEM-VOICE override specification |

---

**Document Information**
- **Discipline**: 00835 Chemical Engineering
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
