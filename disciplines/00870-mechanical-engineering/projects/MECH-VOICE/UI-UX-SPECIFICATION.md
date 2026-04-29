---
title: "MECH-VOICE — Mechanical Engineering Voice Call Override Specification"
description: "Mechanical Engineering-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines unique entity sources, phone number sourcing from equipment suppliers and maintenance contractors. All core modal, state machine, and number selection behaviours are inherited from the shared core."
version: 1.0
date: 2026-04-29
project_code: MECH-VOICE
discipline: 00870-mechanical-engineering
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - equipment-supplier
  - modal
  - mechanical-engineering
  - override
---

# MECH-VOICE — Mechanical Engineering Voice Call Override Specification

## Purpose

This document defines the **00870 Mechanical Engineering discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the mechanical-engineering-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Equipment / supplier ID from current workflow context | §2 |
| `getPhoneNumbers()` | `equipment_suppliers.phone` + `maintenance_contractors.phone` + `service_engineers.phone` | §3 |
| `getCallDocumentSources()` | Equipment specs, maintenance schedules, service reports, warranty docs | §4 |
| `triggerWorkflow` | 00870 Equipment & Maintenance Communication Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"00870"` | §6 |
| `accentColour` | `#2E7D32` (Green — Engineering standard) | §7 |
| `contextLabels` | "Equipment spec", "Maintenance schedule", "Service report", "Warranty query", "Part number reference" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

Triggered from the Equipment & Maintenance Communication Workflow, the `equipmentId` or `supplierId` is passed as a prop:

```typescript
interface VoiceCallProps {
  entityId: string;           // equipment.id or supplier.id
  entityName: string;         // equipment.name or supplier.business_name
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `equipment_suppliers.phone` | Supplier primary contact | 📞 Primary Contact |
| `maintenance_contractors.phone` | Maintenance contractor line | 👤 Contact Person |
| `service_engineers.phone` | Field service engineer mobile | 📱 Mobile Contact |

### 2.3 Number Format

International format with automatic masking. Country code defaults to `+27`.

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description | Max Count |
|--------|-------------|-----------|
| Equipment specifications | Technical datasheets and cut sheets | 10 |
| Maintenance schedules | Planned maintenance and service intervals | All |
| Service reports | Recent inspection and repair reports | 10 |
| Warranty documents | Warranty terms and claim forms | 5 |

### 3.1 Mechanical Engineering-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Equipment spec" | Technical specification of equipment |
| "Maintenance schedule" | Planned maintenance timeline |
| "Service report" | Recent service or inspection report |
| "Warranty query" | Warranty coverage question |
| "Part number reference" | Part number for ordering or replacement |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00870 Equipment & Maintenance Communication Workflow**. A "Call Supplier" / "Call Service Engineer" button is rendered in the equipment management panel.

### 4.2 Role Gate

```
gate = user.role >= 'editor'
```

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `commenter` | 1 | No |
| `editor` | 2 | Yes |
| `admin` | 3 | Yes |

---

## 5. Integration Points

### 5.1 00870 Equipment & Supplier Directory

| Integration | Detail |
|-------------|--------|
| Data consumed | Equipment supplier contacts, maintenance contractor directory |
| Direction | Read-only |
| Entry point | `useEquipment(id)` / `useSupplier(id)` hook |
| Fallback | Call button disabled if no numbers exist |

### 5.2 VoiceForge AI

Same as shared core with mechanical engineering context payload.

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "context": {
    "entityId": "{{equipmentId}}",
    "discipline": "00870",
    "documents": []
  }
}
```

---

## 6. Audit Log Discipline Code

All calls placed from 00870 Mechanical Engineering MUST log with `discipline: "00870"`.

---

## 7. Testing Checklist

- [ ] Phone numbers load from equipment suppliers, maintenance contractors, service engineers
- [ ] Primary number auto-selected with correct source indicators
- [ ] Call button hidden when `user.role < 'editor'`
- [ ] Document picker shows equipment specs, maintenance schedules, service reports, warranty docs
- [ ] Audit log records `discipline: "00870"`
- [ ] Country code defaults to `+27`

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial MECH-VOICE override specification |

---

**Document Information**
- **Discipline**: 00870 Mechanical Engineering
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
