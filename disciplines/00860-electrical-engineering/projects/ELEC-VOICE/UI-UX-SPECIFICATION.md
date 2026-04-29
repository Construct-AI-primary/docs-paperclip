---
title: "ELEC-VOICE — Electrical Engineering Voice Call Override Specification"
description: "Electrical Engineering-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from electrical engineers and utility providers. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: ELEC-VOICE
discipline: 00860-electrical-engineering
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - electrical-engineering
  - modal
  - utility-provider
  - override
---

# ELEC-VOICE — Electrical Engineering Voice Call Override Specification

## Purpose

This document defines the **00860 Electrical Engineering discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the electrical-engineering-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Electrical system / utility connection ID from current workflow | §2 |
| `getPhoneNumbers()` | `electrical_engineers.phone` + `utility_providers.phone` + `supplier_representatives.phone` | §3 |
| `getCallDocumentSources()` | Single-line diagrams, load schedules, cable schedules, utility letters | §4 |
| `triggerWorkflow` | 00860 Electrical & Utility Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00860"` | §6 |
| `accentColour` | `#2E7D32` (Green — Engineering standard) | §7 |
| `contextLabels` | "SLD reference", "Load schedule", "Cable schedule", "Utility letter", "Equipment specification" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

```typescript
interface VoiceCallProps {
  entityId: string;           // electrical_system.id or utility_connection.id
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `electrical_engineers.phone` | Electrical engineer direct line | 📞 Primary Contact |
| `utility_providers.phone` | Utility provider contact centre | 👤 Contact Person |
| `supplier_representatives.phone` | Equipment supplier rep mobile | 📱 Mobile Contact |

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Single-line diagrams | Electrical SLDs for the system | 10 |
| Load schedules | Connected load and demand calculations | All |
| Cable schedules | Cable routing and sizing schedules | 10 |
| Utility letters | Utility connection correspondence and approvals | 10 |

### 3.1 Electrical-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "SLD reference" | Single-line diagram sheet reference |
| "Load schedule" | Connected load and diversity calculation |
| "Cable schedule" | Cable routing, sizing, and type schedule |
| "Utility letter" | Utility provider letter or approval |
| "Equipment specification" | Electrical equipment data sheet or spec |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00860 Electrical & Utility Communication Workflow**.

### 4.2 Role Gate

`gate = user.role >= 'editor'`

---

## 5. Integration Points

`discipline: "00860"` in audit log.

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial ELEC-VOICE override specification |

---

**Document Information**
- **Discipline**: 00860 Electrical Engineering
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
