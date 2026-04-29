---
title: "QS-VOICE — Quantity Surveying Voice Call Override Specification"
description: "Quantity Surveying-specific overrides (02025) for the shared Voice Communication system (VOICE-COMM). Defines how the QS discipline handles cost-related coordination calls during measurement, valuation, and cost management."
version: 1.0
date: 2026-04-29
project_code: QS-VOICE
discipline: 02025-quantity-surveying
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - quantity-surveying
  - cost-management
  - measurement
  - override
---

# QS-VOICE — Quantity Surveying Voice Call Override Specification

## Purpose

This document defines the **02025 Quantity Surveying discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

---

## 1. Override Summary

| Override | Value | § |
|----------|-------|---|
| `entityId` source | Contractor/consultant/subcontractor ID from cost management context | §2 |
| `getPhoneNumbers()` | `contractor_contacts.phone`, `subcontractor_contacts.phone` | §2 |
| `getCallDocumentSources()` | BOQ documents, payment valuations, cost reports, measurement schedules | §3 |
| `triggerWorkflow` | 02025 Measurement & Valuation Workflow | §4 |
| `roleGate` | `user.role >= 'quantity_surveyor'` | §4 |
| `disciplineCode` | `"02025"` | §5 |
| `accentColour` | `#00838F` (Cyan) | §6 |
| `contextLabels` | "BOQ item", "Payment valuation", "Cost report", "Measurement schedule", "Rate query" | §3 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

Triggered from the Measurement & Valuation Workflow or Cost Management Workflow:

```typescript
interface VoiceCallProps {
  entityId: string;           // contractor.id or subcontractor.id from 02025 Register
  entityName: string;         // organisation name
  workflowId: string;         // valuation.id or cost_report.id
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `contractor_contacts.phone` | Contractor QS direct line | 👤 Contact Person |
| `subcontractor_contacts.phone` | Subcontractor contact | 👤 Contact Person |
| `contractor_sites.phone` | Site office | 🏢 Site Office |
| `contractor_contacts.mobile` | Mobile/WhatsApp | 📱 Mobile Contact |

### 2.3 Number Format

Default country code: `+27`. Display: `(XXX) XXX-XXXX` with automatic masking.

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description |
|--------|-------------|
| BOQ documents | Bill of quantities for current work package |
| Payment valuations | Monthly/progress payment valuations |
| Cost reports | Cost management reports and forecasts |
| Measurement schedules | Quantity measurement schedules |
| Variation pricing | Variation order pricing documentation |
| Manual upload | Drag-and-drop or file browse |

### 3.1 Purpose Labels

| Label | Description |
|-------|-------------|
| "BOQ item" | Bill of quantities item reference |
| "Payment valuation" | Progress payment valuation being discussed |
| "Cost report" | Cost management report or forecast |
| "Measurement schedule" | Measurement schedule requiring verification |
| "Rate query" | Rate or unit price clarification |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **02025 Measurement & Valuation Workflow**.

### 4.2 Role Gate

```
gate = user.role >= 'quantity_surveyor'
```

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `assistant_qs` | 1 | No |
| `quantity_surveyor` | 2 | Yes |
| `senior_qs` | 3 | Yes |

### 4.3 Post-Call Integration

Optional log-entry prompt to post outcome to the valuation or cost report timeline.

---

## 5. Audit Log Discipline Code

All calls log with `discipline: "02025"`.

---

## 6. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#00838F` (Cyan) |
| Header badge label | `"Quantity Surveying"` |
| Context label | `"Cost Coordination Call"` |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial QS voice call override |

---

**Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)