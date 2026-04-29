---
title: "ARCH-VOICE — Architectural Voice Call Override Specification"
description: "Architectural-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from design team and consultant contacts. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: ARCH-VOICE
discipline: 00825-architectural
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - design-team
  - modal
  - architectural
  - override
---

# ARCH-VOICE — Architectural Voice Call Override Specification

## Purpose

This document defines the **00825 Architectural discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the architectural-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Design package / consultant ID from current workflow | §2 |
| `getPhoneNumbers()` | `design_team.phone` + `consultant_contacts.phone` + `project_architect.phone` | §3 |
| `getCallDocumentSources()` | Drawing sets, specifications, design briefs, RFI responses | §4 |
| `triggerWorkflow` | 00825 Design Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00825"` | §6 |
| `accentColour` | `#2E7D32` (Green — Engineering standard) | §7 |
| `contextLabels` | "Drawing reference", "Specification clause", "Design brief", "RFI response", "Material selection" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

```typescript
interface VoiceCallProps {
  entityId: string;           // design_package.id or consultant.id
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `design_team.phone` | Design team lead direct line | 📞 Primary Contact |
| `consultant_contacts.phone` | Consultant contact number | 👤 Contact Person |
| `project_architect.phone` | Project architect mobile | 📱 Mobile Contact |

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Drawing sets | Architectural drawings under review | 20 |
| Specifications | Material and workmanship specifications | All |
| Design briefs | Current design briefs and scope documents | 10 |
| RFI responses | Responses to requests for information | All |

### 3.1 Architectural-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Drawing reference" | Architectural drawing sheet reference |
| "Specification clause" | Specification section being discussed |
| "Design brief" | Design intent or scope brief |
| "RFI response" | Response to a request for information |
| "Material selection" | Material or finish selection query |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00825 Design Communication Workflow**.

### 4.2 Role Gate

`gate = user.role >= 'editor'`

---

## 5. Integration Points

### 5.1 VoiceForge AI

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "context": {
    "entityId": "{{designPackageId}}",
    "discipline": "00825",
    "documents": []
  }
}
```

---

## 6. Audit Log

All calls log with `discipline: "00825"`.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial ARCH-VOICE override specification |

---

**Document Information**
- **Discipline**: 00825 Architectural
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
