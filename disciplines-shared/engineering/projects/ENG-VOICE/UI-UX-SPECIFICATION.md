---
title: "ENG-VOICE — Engineering Voice Call Override Specification"
description: "Shared engineering discipline overrides for the Voice Communication system (VOICE-COMM). Serves all 008xx engineering disciplines (Architectural, Chemical, Civil, Landscaping, Geotechnical, Electrical, Mechanical, Process, Structural) plus 01000 Environmental. Each discipline selects its accent via the `disciplineCode` passed at call init."
version: 1.0
date: 2026-04-29
project_code: ENG-VOICE
discipline-discipline-shared-engineering
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
serves:
  - 00825 Architectural
  - 00835 Chemical Engineering
  - 00850 Civil Engineering
  - 00850 Landscaping
  - 00855 Geotechnical Engineering
  - 00860 Electrical Engineering
  - 00870 Mechanical Engineering
  - 00871 Process Engineering
  - 00872 Structural
  - 01000 Environmental
gigabrain_tags:
  - voice-call
  - engineering
  - consultant-coordination
  - shared-engineering
  - override
---

# ENG-VOICE — Engineering Voice Call Override Specification

## Purpose

This document defines the **engineering discipline overrides** for the shared Voice Communication system. It serves all 008xx engineering disciplines + 01000 Environmental via a single override spec. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../voice-communication/UI-UX-SPECIFICATION.md)**

---

## 1. Override Summary

| Override | Value | § |
|----------|-------|---|
| `entityId` source | Consultant/subcontractor/discipline lead ID from engineering design coordination context | §2 |
| `getPhoneNumbers()` | `consultant_contacts.phone`, `discipline_leads.phone`, `site_supervisors.phone` | §2 |
| `getCallDocumentSources()` | Design drawings, specifications, reports, site instructions, RFIs | §3 |
| `triggerWorkflow` | Engineering design coordination / RFI workflow | §4 |
| `roleGate` | `user.role >= 'engineer'` | §4 |
| `disciplineCode` | Varies per calling discipline (e.g., `"00825"`, `"00860"`) | §5 |
| `accentColour` | `#2E7D32` (Green — Engineering) | §6 |
| `contextLabels` | "Design drawing", "Specification", "Design report", "RFI reference", "Site instruction" | §3 |
| `badgeLabel` | Varies per discipline (e.g., "Architectural", "Electrical", "Structural") | §6 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

Triggered from the Engineering Design Coordination Workflow or RFI workflow — passes `disciplinePartnerId`:

```typescript
interface VoiceCallProps {
  entityId: string;              // consultant.id, discipline_lead.id, or subcontractor.id
  entityName: string;            // organisation or person name
  workflowId: string;            // design_coordination.id or rfi.id
  userId: string;
  disciplineCode: string;        // e.g., "00825", "00860" — passed by calling discipline
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `consultant_contacts.phone` | Primary consultant office line | 📞 Primary Contact |
| `discipline_leads.phone` | Lead engineer direct line | 👤 Contact Person |
| `site_supervisors.phone` | Site supervisor mobile | 📱 Mobile Contact |
| `consultant_sites.phone` | Site office | 🏢 Site Office |

### 2.3 Number Format

Default country code: `+27`. Display: `(XXX) XXX-XXXX` with automatic masking.

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description |
|--------|-------------|
| Design drawings | Current set of discipline design drawings |
| Specifications | Discipline-specific technical specifications |
| Design reports | Design reports, calculations, studies |
| RFI log | Active RFI entries referencing the call |
| Site instructions | Issued site instructions requiring clarification |
| Manual upload | Drag-and-drop or file browse |

### 3.1 Purpose Labels

| Label | Description |
|-------|-------------|
| "Design drawing" | Drawing reference requiring discussion |
| "Specification" | Technical specification clause |
| "Design report" | Design report / calculation note |
| "RFI reference" | RFI being addressed |
| "Site instruction" | Site instruction requiring coordination |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **Engineering Design Coordination Workflow** or **RFI Management Workflow**.

### 4.2 Role Gate

```
gate = user.role >= 'engineer'
```

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `technician` | 1 | No |
| `engineer` | 2 | Yes |
| `lead_engineer` | 3 | Yes |
| `admin` | 4 | Yes |

### 4.3 Post-Call Integration

Optional log-entry prompt to post call outcome to the design coordination timeline or RFI log.

---

## 5. Audit Log & Discipline Routing

The calling discipline passes its `disciplineCode` in the call init payload:

```json
{
  "to": "...",
  "context": {
    "discipline": "{{disciplineCode}}"
  }
}
```

Valid discipline codes: `00825`, `00835`, `00850` (Civil), `00850` (Landscaping, distinguished by `entityType`), `00855`, `00860`, `00870`, `00871`, `00872`, `01000`.

---

## 6. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#2E7D32` (Green) |
| Header badge label | Dynamic — set to calling discipline name (e.g., "Architectural", "Electrical") |
| Context label | `"Design Coordination Call"` |

The badge label is resolved from a lookup table:

| disciplineCode | Badge Label |
|----------------|-------------|
| 00825 | "Architectural" |
| 00835 | "Chemical" |
| 00850 | "Civil" |
| 00850-L | "Landscaping" |
| 00855 | "Geotechnical" |
| 00860 | "Electrical" |
| 00870 | "Mechanical" |
| 00871 | "Process" |
| 00872 | "Structural" |
| 01000 | "Environmental" |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial shared engineering voice call override |

---

**Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../voice-communication/UI-UX-SPECIFICATION.md)