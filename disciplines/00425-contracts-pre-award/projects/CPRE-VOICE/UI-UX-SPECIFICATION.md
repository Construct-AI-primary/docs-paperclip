---
title: "CPRE-VOICE — Contracts Pre-Award Voice Call Override Specification"
description: "Contracts Pre-Award-specific overrides (00425) for the shared Voice Communication system (VOICE-COMM). Defines how Pre-Award disciplines handle tenderer coordination calls during the bidding and evaluation phase."
version: 1.0
date: 2026-04-29
project_code: CPRE-VOICE
discipline: 00425-contracts-pre-award
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - contracts-pre-award
  - tender
  - bid-coordination
  - override
---

# CPRE-VOICE — Contracts Pre-Award Voice Call Override Specification

## Purpose

This document defines the **00425 Contracts Pre-Award discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

---

## 1. Override Summary

| Override | Value | § |
|----------|-------|---|
| `entityId` source | Tenderer/bidder ID from tender evaluation context | §2 |
| `getPhoneNumbers()` | `tenderer_contacts.phone`, `bidder_contacts.phone` | §2 |
| `getCallDocumentSources()` | Tender documents, evaluation reports, bid responses, queries | §3 |
| `triggerWorkflow` | 00425 Tender Evaluation Workflow | §4 |
| `roleGate` | `user.role >= 'evaluation_officer'` | §4 |
| `disciplineCode` | `"00425"` | §5 |
| `accentColour` | `#4527A0` (Deep Purple) | §6 |
| `contextLabels` | "Tender enquiry", "Bid response query", "Evaluation clarification", "Compliance question", "Pricing query" | §3 |

---

## 2. Entity & Number Source

### 2.1 Entity ID Source

Triggered from the Tender Evaluation Workflow — passes `tendererId`:

```typescript
interface VoiceCallProps {
  entityId: string;           // tenderer.id from 00425 Tender Register
  entityName: string;         // tenderer.organisation_name
  workflowId: string;         // evaluation.id
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `tenderer_contacts.phone` | Tenderer primary contact | 📞 Primary Contact |
| `bidder_contacts.phone` | Bid response contact | 👤 Contact Person |
| `tenderer_contacts.mobile` | Mobile/WhatsApp | 📱 Mobile Contact |

### 2.3 Number Format

Default country code: `+27`. Display: `(XXX) XXX-XXXX` with automatic masking.

---

## 3. Document Sources (getCallDocumentSources)

| Source | Description |
|--------|-------------|
| Tender documents | RFP, RFT, RFQ notices |
| Evaluation reports | Evaluation committee reports |
| Bid responses | Submitted bid response documents |
| Clarification queries | Formal clarification correspondence |
| Manual upload | Drag-and-drop or file browse |

### 3.1 Purpose Labels

| Label | Description |
|-------|-------------|
| "Tender enquiry" | Enquiry about tender document scope |
| "Bid response query" | Clarification on submitted bid |
| "Evaluation clarification" | Evaluation criteria clarification |
| "Compliance question" | Compliance or eligibility question |
| "Pricing query" | Pricing schedule clarification |

---

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **00425 Tender Evaluation Workflow**.

### 4.2 Role Gate

```
gate = user.role >= 'evaluation_officer'
```

### 4.3 Post-Call Integration

Call outcome logged to evaluation timeline for audit trail.

---

## 5. Audit Log Discipline Code

All calls log with `discipline: "00425"`.

---

## 6. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#4527A0` (Deep Purple) |
| Header badge label | `"Pre-Award"` |
| Context label | `"Tender Coordination Call"` |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial pre-award voice call override |

---

**Extends**: [VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)