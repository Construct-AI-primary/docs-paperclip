---
title: "CIVIL-VOICE — Civil Engineering Voice Call Override Specification"
description: "Civil Engineering-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing, document context, trigger workflows, and role gates for the 00850 Civil Engineering discipline. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: CIVIL-VOICE
discipline: 00850-civil-engineering
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - project-site-communication
  - modal
  - civil-engineering
  - override
---

# CIVIL-VOICE — Civil Engineering Voice Call Override Specification

## Purpose

This document defines the **00850 Civil Engineering discipline overrides** for the shared Voice Communication system. All core behaviour (modal container, state machine, number selection engine, document attachment system, colours, screen states) is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the civil-engineering-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Project/Site context ID from current workflow | §2 |
| `getPhoneNumbers()` | `site_contacts.phone` + `project_stakeholders.phone` + `site_office.phone` | §3 |
| `getCallDocumentSources()` | Project docs, site investigation reports, drawing sets, manual upload | §4 |
| `triggerWorkflow` | 00850 Civil Engineering Site Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00850"` | §6 |
| `accentColour` | `#2E7D32` (Green — Engineering standard) | §7 |
| `contextLabels` | "Site instruction", "Drawing clarification", "Survey reference", "Schedule change", "Material query" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

When the VoiceCall modal is triggered from the Site Communication Workflow, the `projectId` or `siteId` is passed as a prop from the current site context:

```typescript
// Provided by parent (00850 Site Communication Workflow)
interface VoiceCallProps {
  entityId: string;           // project.id or site.id from 00850 Project Directory
  entityName: string;         // project.name or site.name
  workflowId: string;         // communication.id
  userId: string;             // current user
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

Numbers are sourced from the 00850 Project/Site context:

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `site_contacts.phone` | Site contact direct line | 📞 Primary Contact |
| `project_stakeholders.phone` | Stakeholder directory number | 👤 Contact Person |
| `site_office.phone` | Site office switchboard | 🏢 Site Office |

The `getPhoneNumbers(entityId)` function queries these three sources and returns an array of `PhoneNumberOption` as defined in the shared core.

### 2.3 Number Format

Numbers are expected in international format with automatic masking. Country code prefix defaults to `+27` (South Africa). The user may override via the country code dropdown.

---

## 3. Document Sources (getCallDocumentSources)

The civil engineering document picker populates from these sources:

| Source | Description | Max Count |
|--------|-------------|-----------|
| Project document register | Civil engineering drawings, specs, and reports linked to the project | 20 |
| Site investigation reports | Geotechnical and survey documents for the current site | All |
| Site communication history | Previous call logs, meeting notes, instructions | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

### 3.1 Civil Engineering-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Site instruction" | Site instruction or direction being discussed |
| "Drawing clarification" | Civil drawing or detail requiring clarification |
| "Survey reference" | Survey data or benchmark reference |
| "Schedule change" | Updated construction programme or milestone |
| "Material query" | Material specification or delivery query |
| "RFI reference" | Request for Information reference number |

### 3.2 Document Code Examples (Civil Engineering Context)

When VoiceForge AI processes attached documents, the civil engineering agent's script templates reference specific document labels:

> "Referencing the **Site instruction** you uploaded, I'd like to confirm the bulk earthworks sequence for section 4..."
>
> "With regard to the **Drawing clarification** attached, could you confirm the finished floor level at grid B2?"

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

The VoiceCall modal is launched from the **00850 Civil Engineering Site Communication Workflow**.

- A "Call Site Contact" button is rendered in the site communication panel's action bar.
- Clicking it opens the VoiceCall modal with the current site/project context.

### 4.2 Role Gate

```
gate = user.role >= 'editor'
```

Role hierarchy (reusing 00850's existing role model):

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `commenter` | 1 | No |
| `editor` | 2 | Yes |
| `admin` | 3 | Yes |

Users below `editor` see the button as disabled with tooltip: *"You need Editor access to place calls."*

### 4.3 Post-Call Workflow Integration

After a successful call (Disconnected → Idle), an optional note-entry prompt appears:

> *"Log call outcome?"* — posting a structured note back to the site communication timeline with:
  - Duration
  - Outcome
  - Call summary (free text)
  - Attached document IDs

---

## 5. Discipline-Specific Integration Points

### 5.1 00850 Project/Site Directory

| Integration | Detail |
|-------------|--------|
| Data consumed | Project entity, site contacts, stakeholder phone numbers |
| Direction | Read-only (modal reads, never writes) |
| Entry point | `useProject(id)` / `useSite(id)` hook provided by 00850 context |
| Fallback | If no phone numbers exist, Call button disabled with tooltip |

### 5.2 VoiceForge AI

Same as shared core (see VOICE-COMM §F.1) with civil-engineering-specific context payload:

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "from": "{{platformOutboundId}}",
  "context": {
    "entityId": "{{siteId}}",
    "workflowId": "{{communicationId}}",
    "userId": "{{currentUserId}}",
    "discipline": "00850",
    "documents": []
  }
}
```

---

## 6. Audit Log Discipline Code

All calls placed from 00850 Civil Engineering MUST log with `discipline: "00850"` so audit reports can be filtered by discipline. See VOICE-COMM §F.3 for the full audit log schema.

---

## 7. Testing Checklist (Civil Engineering-specific)

- [ ] Phone numbers load from `site_contacts.phone`, `project_stakeholders.phone`, and `site_office.phone`
- [ ] Primary number auto-selected; dropdown shows all numbers with source indicators
- [ ] Call button hidden when `user.role < 'editor'`
- [ ] Post-call note prompt appears in site communication timeline
- [ ] Document picker shows project docs, site investigation reports, communication history
- [ ] Attached documents appear in call log for future reference
- [ ] Audit log records `discipline: "00850"`
- [ ] Country code defaults to `+27` (South Africa)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial CIVIL-VOICE override specification |

---

**Document Information**
- **Discipline**: 00850 Civil Engineering
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
