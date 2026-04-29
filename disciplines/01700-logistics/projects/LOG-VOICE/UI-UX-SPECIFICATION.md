---
title: "LOG-VOICE — Logistics Voice Call Override Specification"
description: "Logistics-specific overrides for the shared Voice Communication system (VOICE-COMM). Defines how Logistics 01700 customises the modal for carrier dispatch, shipment tracking, and supplier coordination calls."
version: 2.0
date: 2026-04-29
project_code: LOG-VOICE
discipline: 01700-logistics
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - carrier-dispatch
  - logistics
  - shipment-coordination
  - override
---

# LOG-VOICE — Logistics Voice Call Override Specification

## Purpose

This document defines the **01700 Logistics discipline overrides** for the shared Voice Communication system. All core behaviour (modal container, state machine, number selection engine, document attachment system, colours, screen states) is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the logistics-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Carrier/transport provider ID from dispatch context | §2 |
| `getPhoneNumbers()` | `carriers.phone`, `carrier_sites.phone`, `carrier_contacts.mobile` | §2 |
| `getCallDocumentSources()` | Shipment manifests, waybills, delivery instructions, site access docs | §3 |
| `triggerWorkflow` | 01700 Dispatch & Coordination Workflow | §4 |
| `roleGate` | `user.role >= 'dispatcher'` | §4 |
| `disciplineCode` | `"01700"` | §5 |
| `accentColour` | `#1565C0` (Blue — 01700 Logistics standard) | §6 |
| `contextLabels` | "Shipment manifest", "Delivery instructions", "Waybill ref", "Site access", "Schedule change" | §3 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

When the VoiceCall modal is triggered from the Dispatch & Coordination Workflow, the `carrierId` is passed from the dispatch panel:

```typescript
interface VoiceCallProps {
  entityId: string;           // carrier.id from 01700 Carrier Directory
  entityName: string;         // carrier.business_name
  workflowId: string;         // dispatch.id
  userId: string;             // current user
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

Numbers are sourced from the 01700 Carrier Directory:

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `carriers.phone` | Carrier head office | 📞 Primary Contact |
| `carrier_contacts.mobile` | Dispatcher direct line | 📱 Mobile Contact |
| `carrier_sites.phone` | Depot/site office | 🏢 Site Office |
| `carrier_contacts.phone` | Contact person office line | 👤 Contact Person |

### 2.3 Number Format

Numbers are expected in international format but displayed as `(XXX) XXX-XXXX` with automatic masking. Country code prefix defaults to `+27` (South Africa — primary logistics market) but the user can change it via the country code dropdown.

---

## 3. Document Sources (getCallDocumentSources)

The logistics document picker populates from these sources:

| Source | Description | Max Count |
|--------|-------------|-----------|
| Active dispatch manifests | Shipment manifests for current dispatch | 20 |
| Waybills | Current waybill references | All |
| Delivery instructions | Site-specific delivery or offload instructions | 10 |
| Site access docs | Gate codes, access permits, site maps | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

### 3.1 Logistics-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "Shipment manifest" | Load or delivery manifest being coordinated |
| "Delivery instructions" | Site-specific delivery or offload instructions |
| "Waybill ref" | Waybill/reference for the shipment |
| "Site access" | Gate code, access permit, or site map |
| "Schedule change" | Updated ETA, delivery slot, or route change |
| "Load confirmation" | Proof of load or delivery confirmation |

### 3.2 Document Code Examples (Logistics Context)

When VoiceForge AI processes attached documents, the logistics agent's script templates reference specific document labels:

> "I'm referring to the **Shipment manifest** you uploaded — could you confirm the pallet count on load 4?"
>
> "Regarding the **Delivery instructions** attached, please note the site requires hard hats and steel-toe boots for offloading."
>
> "The **Waybill ref** shows a different destination than what our dispatch system has — can we clarify?"
>
> "Per the **Site access** document, the gate code is valid only until 18h00, so we'll need to coordinate arrival accordingly."
>
> "I see a **Schedule change** on this load — has the ETA shifted, or are we still on track for the original window?"

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

The VoiceCall modal is launched from the **01700 Dispatch & Coordination Workflow** (see `docs-construct-ai/disciplines/01700_logistics/workflow_docs/0000_IMPORT_EXPORT_WORKFLOW.md`).

- A **"Call Carrier"** button is rendered in the dispatch panel's action bar.
- Clicking it opens the VoiceCall modal with the carrier ID and current dispatch context.

### 4.2 Role Gate

```
gate = user.role >= 'dispatcher'
```

Role hierarchy (reusing 01700's existing role model):

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `driver` | 1 | No |
| `dispatcher` | 2 | Yes |
| `admin` | 3 | Yes |

Users below `dispatcher` see the button as disabled with tooltip: *"You need Dispatcher access to place calls."*

### 4.3 Post-Call Workflow Integration

After a successful call (Disconnected → Idle), an optional note-entry prompt appears:

> *"Log call outcome?"* — posting a structured note back to the dispatch timeline with:
  - Duration
  - Outcome
  - Call summary (free text)
  - Attached document IDs

---

## 5. Discipline-Specific Integration Points

### 5.1 01700 Carrier Directory

| Integration | Detail |
|-------------|--------|
| Data consumed | Carrier entity primary phone, depot numbers, contact person mobile, business hours, time zone |
| Direction | Read-only (modal reads, never writes) |
| Entry point | `useCarrier(id)` hook provided by 01700 context |
| Fallback | If no phone numbers exist, Call button disabled with tooltip |

### 5.2 01700 Dispatch & Coordination Workflow

| Integration | Detail |
|-------------|--------|
| Trigger | Dispatch workflow passes carrier ID to modal |
| Embedding | "Call Carrier" button in dispatch panel action bar |
| Gate | `user.role >= 'dispatcher'` |
| Post-call | Optional note-entry prompt to log call outcome to dispatch timeline |

### 5.3 VoiceForge AI

Same as shared core (see VOICE-COMM §F.1) with logistics-specific context payload:

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "from": "{{platformOutboundId}}",
  "context": {
    "entityId": "{{carrierId}}",
    "workflowId": "{{dispatchId}}",
    "userId": "{{currentUserId}}",
    "discipline": "01700",
    "documents": []
  }
}
```

---

## 6. Audit Log Discipline Code

All calls placed from 01700 Logistics MUST log with `discipline: "01700"` so audit reports can be filtered by discipline. See VOICE-COMM §F.3 for the full audit log schema.

---

## 7. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#1565C0` (Blue — 01700 Logistics standard) |
| Header badge label | `"Logistics"` |
| Context label | `"Dispatch Call"` |

---

## 8. Testing Checklist (Logistics-specific)

- [ ] Phone numbers load from `carriers.phone`, `carrier_contacts.mobile`, `carrier_sites.phone`, and `carrier_contacts.phone`
- [ ] Primary number auto-selected; dropdown shows all numbers with source indicators
- [ ] Call button hidden when `user.role < 'dispatcher'`
- [ ] Post-call note prompt appears in dispatch timeline
- [ ] Document picker shows shipment manifests, waybills, delivery instructions, site access docs
- [ ] Attached documents appear in call log for future reference
- [ ] Audit log records `discipline: "01700"`
- [ ] Country code defaults to `+27` (South Africa)
- [ ] Visual accent colour renders as `#1565C0` (Blue)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial logistics voice call override |
| 2.0 | 2026-04-29 | Refactored to match PROC-VOICE v2.0 pattern: added max counts, code examples, integration points, VoiceForge AI context payload, testing checklist |

---

**Document Information**
- **Discipline**: 01700 Logistics
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)