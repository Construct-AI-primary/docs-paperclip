---
title: "PROC-VOICE — Procurement Voice Call Override Specification"
description: "Procurement-specific overrides for the shared Voice Communication system (VOICE-COMM). This document only defines what's unique to 01900 Procurement — modal container, state machine, number selection, and document attachment behaviours are inherited from the shared core."
version: 2.0
date: 2026-04-29
project_code: PROC-VOICE
discipline: 01900-procurement
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - supplier-outreach
  - modal
  - procurement-platform
  - override
---

# PROC-VOICE — Procurement Voice Call Override Specification

## Purpose

This document defines the **01900 Procurement discipline overrides** for the shared Voice Communication system. All core behaviour (modal container, state machine, number selection engine, document attachment system, colours, screen states) is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

Only the procurement-specific customisations listed below differ from the shared core.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `entityId` source | Supplier ID from current outreach workflow context | §2 |
| `getPhoneNumbers()` | `supplier_contacts` table + `supplier_sites.phone` | §3 |
| `getCallDocumentSources()` | Workspace docs, outreach workflow files, supplier profile, manual upload | §4 |
| `triggerWorkflow` | 01900 Supplier Outreach Workflow | §5 |
| `roleGate` | `user.role >= 'editor'` | §5 |
| `disciplineCode` | `"01900"` | §6 |
| `accentColour` | `#00897B` (Teal — 01900 Procurement standard) | §7 |
| `contextLabels` | "RFQ reference", "BOQ clarification", "Site instructions", "Schedule change", "Compliance query" | §4 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

When the VoiceCall modal is triggered from the Supplier Outreach Workflow, the `supplierId` is passed as a prop from the outreach panel's current context:

```typescript
// Provided by parent (01900 Supplier Outreach Workflow)
interface VoiceCallProps {
  entityId: string;           // supplier.id from 01900 Supplier Directory
  entityName: string;         // supplier.business_name
  workflowId: string;         // outreach.id
  userId: string;             // current user
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

Numbers are sourced from the 01900 Supplier Directory:

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `suppliers.primary_phone` | Primary office phone | 📞 Primary Contact |
| `supplier_contacts.phone` | Contact person phone | 👤 Contact Person |
| `supplier_sites.phone` | Site office phone | 🏢 Site Office |

The `getPhoneNumbers(supplierId)` function queries these three sources and returns an array of `PhoneNumberOption` as defined in the shared core.

### 2.3 Number Format

Numbers are expected in international format but displayed as `(XXX) XXX-XXXX` with automatic masking. Country code prefix defaults to `+27` (South Africa — primary procurement market) but the user can change it via the country code dropdown.

---

## 3. Document Sources (getCallDocumentSources)

The procurement document picker populates from these sources:

| Source | Description | Max Count |
|--------|-------------|-----------|
| Recent workspace docs | Procurement documents modified in the last 30 days | 20 |
| Outreach workflow files | Documents linked to the current outreach workflow | All |
| Supplier profile docs | Documents in the supplier's profile (e.g., tax clearance, POE) | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

### 3.1 Procurement-specific Purpose Labels

| Label | Description |
|-------|-------------|
| "RFQ reference" | The RFQ or tender document being discussed |
| "BOQ clarification" | Bill of quantities requiring clarification |
| "Site instructions" | Site-specific instructions for the supplier |
| "Schedule change" | Updated delivery or milestone schedule |
| "Compliance query" | Compliance or regulatory query (CIDB, BBBEE) |
| "POE request" | Request for proof of experience/qualifications |

### 3.2 Document Code Examples (Procurement Context)

When VoiceForge AI processes attached documents, the procurement agent's script templates reference specific document labels:

> "Referencing the **RFQ reference** you uploaded, I'd like to clarify section 3.2 regarding delivery timelines..."
>
> "With regard to the **BOQ clarification** attached, could you confirm the unit rate for item 4.1?"

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

The VoiceCall modal is launched from the **01900 Supplier Outreach Workflow** (see `docs-construct-ai/disciplines/01900_procurement/workflow_docs/orders/1900_PROCUREMENT_SUPPLIER_OUTREACH_WORKFLOW.MD`).

- A "Call Supplier" button is rendered in the outreach panel's action bar.
- Clicking it opens the VoiceCall modal with the outgoing outreach context.

### 4.2 Role Gate

```
gate = user.role >= 'editor'
```

Role hierarchy (reusing 01900's existing role model):

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `commenter` | 1 | No |
| `editor` | 2 | Yes |
| `admin` | 3 | Yes |

Users below `editor` see the button as disabled with tooltip: *"You need Editor access to place calls."*

### 4.3 Post-Call Workflow Integration

After a successful call (Disconnected → Idle), an optional note-entry prompt appears:

> *"Log call outcome?"* — posting a structured note back to the outreach workflow timeline with:
  - Duration
  - Outcome
  - Call summary (free text)
  - Attached document IDs

---

## 5. Discipline-Specific Integration Points

### 5.1 01900 Supplier Directory

| Integration | Detail |
|-------------|--------|
| Data consumed | Supplier entity primary phone, secondary numbers, business hours, time zone |
| Direction | Read-only (modal reads, never writes) |
| Entry point | `useSupplier(id)` hook provided by 01900 context |
| Fallback | If no phone numbers exist, Call button disabled with tooltip |

### 5.2 01900 Supplier Outreach Workflow

| Integration | Detail |
|-------------|--------|
| Trigger | Outreach workflow passes supplier ID to modal |
| Embedding | "Call Supplier" button in outreach panel action bar |
| Gate | `user.role >= 'editor'` |
| Post-call | Optional note-entry prompt to log call outcome |

### 5.3 VoiceForge AI

Same as shared core (see VOICE-COMM §F.1) with procurement-specific context payload:

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "from": "{{platformOutboundId}}",
  "context": {
    "entityId": "{{supplierId}}",
    "workflowId": "{{outreachId}}",
    "userId": "{{currentUserId}}",
    "discipline": "01900",
    "documents": []
  }
}
```

---

## 6. Audit Log Discipline Code

All calls placed from 01900 Procurement MUST log with `discipline: "01900"` so audit reports can be filtered by discipline. See VOICE-COMM §F.3 for the full audit log schema.

---

## 7. Testing Checklist (Procurement-specific)

- [ ] Phone numbers load from `suppliers.primary_phone`, `supplier_contacts.phone`, and `supplier_sites.phone`
- [ ] Primary number auto-selected; dropdown shows all numbers with source indicators
- [ ] Call button hidden when `user.role < 'editor'`
- [ ] Post-call note prompt appears in outreach workflow timeline
- [ ] Document picker shows workspace docs, workflow files, supplier profile docs
- [ ] Attached documents appear in call log for future reference
- [ ] Audit log records `discipline: "01900"`
- [ ] Country code defaults to `+27` (South Africa)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-VOICE spec (full standalone) |
| 2.0 | 2026-04-29 | Refactored to override-only: shared core extracted to VOICE-COMM |

---

**Document Information**
- **Discipline**: 01900 Procurement
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)