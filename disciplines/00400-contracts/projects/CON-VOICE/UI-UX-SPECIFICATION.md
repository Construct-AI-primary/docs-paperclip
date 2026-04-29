---
title: "CON-VOICE — Contracts Voice Call Override Specification"
description: "Contracts-specific overrides (00400) for the shared Voice Communication system (VOICE-COMM). Defines how the Contracts discipline customises the modal for contractor/partner coordination calls during contract administration."
version: 1.0
date: 2026-04-29
project_code: CON-VOICE
discipline: 00400-contracts
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - contracts
  - contractor-coordination
  - override
---

# CON-VOICE — Contracts Voice Call Override Specification

## Purpose

This document defines the **00400 Contracts discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

---

## 1. Override Summary

| Override | Value | § |
|----------|-------|---|
| `entityId` source | Contractor/contract party ID from contract administration context | §2 |
| `getPhoneNumbers()` | `contract_parties.phone`, `contractor_contacts.phone` | §2 |
| `getCallDocumentSources()` | Contract documents, variations, correspondence, site instructions | §3 |
| `triggerWorkflow` | 00400 Contract Administration Workflow | §4 |
| `roleGate` | `user.role >= 'contracts_officer'` | §4 |
| `disciplineCode` | `"00400"` | §5 |
| `accentColour` | `#283593` (Indigo) | §6 |
| `contextLabels` | "Contract scope", "Variation order", "Site instruction", "Correspondence ref", "Schedule milestone" | §3 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

Triggered from the Contract Administration Workflow — passes `partyId`:

```typescript
interface VoiceCallProps {
  entityId: string;           // party.id from 00400 Contract Register
  entityName: string;         // party.name (contractor, consultant, partner)
  workflowId: string;         // contract.id
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `contract_parties.phone` | Primary contract party line | 📞 Primary Contact |
| `contractor_contacts.phone` | Key contact direct line | 👤 Contact Person |
| `contract_parties.mobile` | Mobile/WhatsApp | 📱 Mobile Contact |

### 2.3 Number Format

Default country code: `+27`. Display: `(XXX) XXX-XXXX` with automatic masking.

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description |
|--------|-------------|
| Contract documents | Signed contract, schedules, appendices |
| Variation orders | Active variation/deed of amendment |
| Site instructions | Issued site instructions referenced in call |
| Correspondence | Formal correspondence log |
| Manual upload | Drag-and-drop or file browse |

### 3.1 Purpose Labels

| Label | Description |
|-------|-------------|
| "Contract scope" | Contract scope of work reference |
| "Variation order" | Variation or amendment being discussed |
| "Site instruction" | Site instruction requiring clarification |
| "Correspondence ref" | Formal correspondence letter reference |
| "Schedule milestone" | Programme or milestone schedule |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00400 Contract Administration Workflow**.

### 4.2 Role Gate

```
gate = user.role >= 'contracts_officer'
```

| Role | Level | Can Call? |
|------|-------|-----------|
| `viewer` | 0 | No |
| `observer` | 1 | No |
| `contracts_officer` | 2 | Yes |
| `admin` | 3 | Yes |

### 4.3 Post-Call Integration

Optional log-entry prompt to post outcome to contract timeline.

---

## 5. Audit Log Discipline Code

All calls log with `discipline: "00400"`.

---

## 6. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#283593` (Indigo) |
| Header badge label | `"Contracts"` |
| Context label | `"Contract Coordination Call"` |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial contracts voice call override |

---

**Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)