---
title: "LAND-VOICE — Landscaping Voice Call Override Specification"
description: "Landscaping-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from landscape architects and nursery suppliers. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: LAND-VOICE
discipline: 00850-landscaping
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - landscape-architecture
  - modal
  - landscaping
  - override
---

# LAND-VOICE — Landscaping Voice Call Override Specification

## Purpose

This document defines the **00850 Landscaping discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the landscaping-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Planting area / supplier ID from current workflow context | §2 |
| `getPhoneNumbers()` | `landscape_architects.phone` + `nursery_suppliers.phone` + `contractors.phone` | §3 |
| `getCallDocumentSources()` | Planting plans, irrigation designs, species schedules, supplier catalogues | §4 |
| `triggerWorkflow` | 00850 Landscaping Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00850-landscaping"` | §6 |
| `accentColour` | `#2E7D32` (Green — Landscaping theme) | §7 |
| `contextLabels` | "Planting plan", "Irrigation detail", "Species schedule", "Supplier catalogue", "Maintenance schedule" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

```typescript
interface VoiceCallProps {
  entityId: string;           // planting_area.id or supplier.id
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `landscape_architects.phone` | Landscape architect direct line | 📞 Primary Contact |
| `nursery_suppliers.phone` | Nursery supplier contact | 👤 Contact Person |
| `contractors.phone` | Landscaping contractor mobile | 📱 Mobile Contact |

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Planting plans | Landscape planting and layout plans | 10 |
| Irrigation designs | Irrigation system design drawings | All |
| Species schedules | Plant species and quantities schedules | 10 |
| Supplier catalogues | Nursery catalogues and pricing | 10 |

### 3.1 Landscaping-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Planting plan" | Landscape planting plan reference |
| "Irrigation detail" | Irrigation system detail or specification |
| "Species schedule" | Plant species and quantities schedule |
| "Supplier catalogue" | Nursery product or pricing catalogue |
| "Maintenance schedule" | Landscape maintenance programme |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00850 Landscaping Communication Workflow**.

### 4.2 Role Gate

`gate = user.role >= 'editor'`

---

## 5. Audit Log

All calls log with `discipline: "00850-landscaping"`.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial LAND-VOICE override specification |

---

**Document Information**
- **Discipline**: 00850 Landscaping
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
