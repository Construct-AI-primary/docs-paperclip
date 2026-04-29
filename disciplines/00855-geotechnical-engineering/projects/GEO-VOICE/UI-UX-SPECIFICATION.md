---
title: "GEO-VOICE — Geotechnical Engineering Voice Call Override Specification"
description: "Geotechnical Engineering-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from site investigation teams and drilling contractors. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: GEO-VOICE
discipline: 00855-geotechnical-engineering
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - site-investigation
  - modal
  - geotechnical-engineering
  - override
---

# GEO-VOICE — Geotechnical Engineering Voice Call Override Specification

## Purpose

This document defines the **00855 Geotechnical Engineering discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the geotechnical-engineering-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Site investigation / borehole ID from current workflow | §2 |
| `getPhoneNumbers()` | `site_investigation_team.phone` + `drilling_contractors.phone` + `geotech_lab.phone` | §3 |
| `getCallDocumentSources()` | Borehole logs, lab test reports, geotechnical reports, site photos | §4 |
| `triggerWorkflow` | 00855 Geotechnical Site Investigation Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00855"` | §6 |
| `accentColour` | `#2E7D32` (Green — Engineering standard) | §7 |
| `contextLabels` | "Borehole log", "Lab test result", "Geotechnical report", "Site photo", "Drilling instruction" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

```typescript
interface VoiceCallProps {
  entityId: string;           // investigation.id or borehole.id
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `site_investigation_team.phone` | Investigation team lead | 📞 Primary Contact |
| `drilling_contractors.phone` | Drilling contractor contact | 👤 Contact Person |
| `geotech_lab.phone` | Geotechnical laboratory line | 🏢 Site Office |

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Borehole logs | Stratigraphic logs from investigation | All |
| Lab test reports | Soil and rock laboratory test results | 10 |
| Geotechnical reports | Factual and interpretative reports | 10 |
| Site photos | Borehole location and site condition photos | 20 |

### 3.1 Geotechnical-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Borehole log" | Borehole stratigraphic log reference |
| "Lab test result" | Laboratory compaction, triaxial, or index test |
| "Geotechnical report" | Factual or interpretative geotechnical report |
| "Site photo" | Borehole location or site condition photo |
| "Drilling instruction" | Drilling specification or instruction |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00855 Geotechnical Site Investigation Workflow**.

### 4.2 Role Gate

`gate = user.role >= 'editor'`

---

## 5. Integration Points

### 5.1 VoiceForge AI

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "context": {
    "entityId": "{{investigationId}}",
    "discipline": "00855",
    "documents": []
  }
}
```

---

## 6. Audit Log

All calls log with `discipline: "00855"`.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial GEO-VOICE override specification |

---

**Document Information**
- **Discipline**: 00855 Geotechnical Engineering
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
