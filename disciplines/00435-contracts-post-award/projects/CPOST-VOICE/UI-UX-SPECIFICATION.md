---
title: "CPOST-VOICE — Contracts Post-Award Voice Call Override Specification"
description: "Contracts Post-Award-specific overrides (00435) for the shared Voice Communication system (VOICE-COMM). Defines how Post-Award disciplines handle contract administration calls during the contract execution phase."
version: 1.0
date: 2026-04-29
project_code: CPOST-VOICE
discipline: 00435-contracts-post-award
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - contracts-post-award
  - contract-administration
  - override
---

# CPOST-VOICE — Contracts Post-Award Voice Call Override Specification

## Purpose

This document defines the **00435 Contracts Post-Award discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

---

## 1. Override Summary

| Override | Value | § |
|----------|-------|---|
| `entityId` source | Contractor/party ID from contract administration context | §2 |
| `getPhoneNumbers()` | `contractor_contacts.phone`, `contract_admin_contacts.phone` | §2 |
| `getCallDocumentSources()` | Contract documents, payment certificates, variation orders, completion docs | §3 |
| `triggerWorkflow` | 00435 Contract Administration Workflow | §4 |
| `roleGate` | `user.role >= 'contracts_officer'` | §4 |
| `disciplineCode` | `"00435"` | §5 |
| `accentColour` | `#7B1FA2` (Purple) | §6 |
| `contextLabels` | "Payment cert", "Variation order", "Completion doc", "Defects list", "Handover doc" | §3 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

Triggered from the Post-Award Contract Administration Workflow:

```typescript
interface VoiceCallProps {
  entityId: string;           // contractor.id from 00435 Contract Register
  entityName: string;         // contractor.organisation_name
  workflowId: string;         // contract_admin.id
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `contractor_contacts.phone` | Primary contractor office | 📞 Primary Contact |
| `contract_admin_contacts.phone` | Contract admin direct line | 👤 Contact Person |
| `contractor_sites.phone` | Site office | 🏢 Site Office |

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description |
|--------|-------------|
| Contract documents | Signed contract, schedules |
| Payment certificates | Current/outstanding payment certificates |
| Variation orders | Post-award variation/deed of amendment |
| Completion documents | Practical completion, defects lists |
| Handover documentation | As-built, O&M manuals |
| Manual upload | Drag-and-drop or file browse |

### 3.1 Purpose Labels

| Label | Description |
|-------|-------------|
| "Payment cert" | Payment certificate being discussed |
| "Variation order" | Variation order needing clarification |
| "Completion doc" | Completion or handover document |
| "Defects list" | Defects list / snag items |
| "Handover doc" | Handover documentation reference |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00435 Contract Administration Workflow**.

### 4.2 Role Gate

```
gate = user.role >= 'contracts_officer'
```

### 4.3 Post-Call Integration

Optional log-entry prompt to post outcome to contract administration timeline.

---

## 5. Audit Log Discipline Code

All calls log with `discipline: "00435"`.

---

## 6. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#7B1FA2` (Purple) |
| Header badge label | `"Post-Award"` |
| Context label | `"Contract Administration Call"` |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial post-award voice call override |

---

**Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)