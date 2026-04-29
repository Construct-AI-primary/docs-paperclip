---
title: "STRUC-VOICE — Structural Engineering Voice Call Override Specification"
description: "Structural Engineering-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from structural engineers and steel fabricators. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: STRUC-VOICE
discipline: 00872-structural
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - structural-engineering
  - modal
  - steel-fabrication
  - override
---

# STRUC-VOICE — Structural Engineering Voice Call Override Specification

## Purpose

This document defines the **00872 Structural Engineering discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the structural-engineering-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Structure / steel package ID from current workflow | §2 |
| `getPhoneNumbers()` | `structural_engineers.phone` + `steel_fabricators.phone` + `concrete_suppliers.phone` | §3 |
| `getCallDocumentSources()` | Structural drawings, steel shop drawings, reinforcement schedules, connection details | §4 |
| `triggerWorkflow` | 00872 Structural Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00872"` | §6 |
| `accentColour` | `#2E7D32` (Green — Engineering standard) | §7 |
| `contextLabels` | "Structural drawing", "Shop drawing", "Reinforcement schedule", "Connection detail", "Load calculation" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

```typescript
interface VoiceCallProps {
  entityId: string;           // structure.id or steel_package.id
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `structural_engineers.phone` | Structural engineer direct line | 📞 Primary Contact |
| `steel_fabricators.phone` | Steel fabrication yard contact | 👤 Contact Person |
| `concrete_suppliers.phone` | Ready-mix concrete supplier | 🏢 Site Office |

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Structural drawings | GA drawings, foundation plans, framing plans | 20 |
| Steel shop drawings | Fabrication and erection drawings | All |
| Reinforcement schedules | Bar bending schedules and detailing | 10 |
| Connection details | Standard and special connection details | 10 |

### 3.1 Structural-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Structural drawing" | General arrangement or structural plan |
| "Shop drawing" | Steel fabrication or erection drawing |
| "Reinforcement schedule" | Bar bending or reinforcement schedule |
| "Connection detail" | Bolted or welded connection detail |
| "Load calculation" | Structural loading or analysis calculation |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00872 Structural Communication Workflow**.

### 4.2 Role Gate

`gate = user.role >= 'editor'`

---

## 5. Audit Log

All calls log with `discipline: "00872"`.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial STRUC-VOICE override specification |

---

**Document Information**
- **Discipline**: 00872 Structural
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
