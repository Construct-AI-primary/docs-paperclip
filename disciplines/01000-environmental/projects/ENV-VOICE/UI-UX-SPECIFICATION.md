---
title: "ENV-VOICE — Environmental Voice Call Override Specification"
description: "Environmental-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from environmental officers and regulatory agencies. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: ENV-VOICE
discipline: 01000-environmental
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - environmental-compliance
  - modal
  - environmental
  - override
---

# ENV-VOICE — Environmental Voice Call Override Specification

## Purpose

This document defines the **01000 Environmental discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the environmental-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Environmental permit / site ID from current workflow | §2 |
| `getPhoneNumbers()` | `environmental_officers.phone` + `regulatory_agencies.phone` + `consultants.phone` | §3 |
| `getCallDocumentSources()` | Environmental permits, EIA reports, monitoring data, compliance records | §4 |
| `triggerWorkflow` | 01000 Environmental Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"01000"` | §6 |
| `accentColour` | `#2E7D32` (Green — Environmental theme) | §7 |
| `contextLabels` | "Permit condition", "EIA report", "Monitoring data", "Compliance record", "Regulatory submission" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

```typescript
interface VoiceCallProps {
  entityId: string;           // permit.id or site.id
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `environmental_officers.phone` | Environmental officer direct line | 📞 Primary Contact |
| `regulatory_agencies.phone` | Agency contact centre | 👤 Contact Person |
| `consultants.phone` | Environmental consultant mobile | 📱 Mobile Contact |

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Environmental permits | Current permits and licence conditions | 10 |
| EIA reports | Environmental impact assessment reports | All |
| Monitoring data | Air, water, noise monitoring records | 20 |
| Compliance records | Compliance audit and inspection records | 10 |

### 3.1 Environmental-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Permit condition" | Permit condition or licence requirement |
| "EIA report" | Environmental impact assessment reference |
| "Monitoring data" | Environmental monitoring result |
| "Compliance record" | Compliance or non-compliance record |
| "Regulatory submission" | Regulatory submission or correspondence |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **01000 Environmental Communication Workflow**.

### 4.2 Role Gate

`gate = user.role >= 'editor'`

---

## 5. Audit Log

All calls log with `discipline: "01000"`.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial ENV-VOICE override specification |

---

**Document Information**
- **Discipline**: 01000 Environmental
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
