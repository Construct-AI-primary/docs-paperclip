---
title: "SAFETY-PPE — PPE Management UI/UX Specification"
description: "PPE management, issuance, and tracking project under 02400 Safety."
version: 1.0
date: 2026-04-29
project_code: "SAFETY-PPE"
discipline: 02400-safety
extends: docs-paperclip/disciplines/02400-safety/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - safety
  - ppe-management
  - specification
---

# SAFETY-PPE — PPE Management UI/UX Specification

## Purpose

This document defines the SAFETY-PPE project under the 02400 Safety discipline, focusing on PPE Management. It extends the discipline-level specification with project-specific customisations. All core behaviours (three-state navigation, modal patterns, RAG status colours, HITL integration, AI model backend) are inherited from the parent discipline spec.

## Override Summary Table

| Override | Value |
|----------|-------|
| entityId source | PPE record ID from issuance workflow |
| getPhoneNumbers() | ppe_store.phone + safety_officers.phone + supplier_contacts.phone |
| getCallDocumentSources() | PPE registers, issuance records, inspection logs, supplier catalogs |
| triggerWorkflow | 02400 PPE Management Workflow |
| roleGate | user.role >= safety_officer |
| disciplineCode | "02400" |
| accentColour | #D32F2F (Safety Red) |
| contextLabels | PPE register, Issuance record, Inspection log, Supplier catalog, Training record |

## Entity & Number Source

### Entity ID Source

The VoiceCall modal receives the relevant entity ID from the 02400 PPE Management Workflow.

### Phone Number Source

Entity contacts are sourced from project-specific directories: ppe_store.phone + safety_officers.phone + supplier_contacts.phone.

## Document Sources

| Source | Description | Max Count |
|--------|-------------|-----------|
| Primary documents | PPE registers, issuance records, inspection logs, supplier catalogs | All |
| Supporting records | Workflow-specific attachments | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

## Workflow-Specific Overrides

### Trigger Workflow

The VoiceCall modal is launched from the **02400 PPE Management Workflow**.

### Role Gate

gate = user.role >= safety_officer

| Role | Level | Can Call? |
|------|-------|-----------|
| viewer | 0 | No |
| editor | 1 | No |
| safety_officer | 2 | Yes |
| admin | 3 | Yes |

### Post-Call Integration

Optional note-entry prompt: "Log call outcome?" posting duration, outcome, summary, and attached document IDs to the workflow timeline.

## VoiceForge AI Payload

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "context": {
    "entityId": "{{entityId}}",
    "discipline": "02400",
    "workflow": "safety-ppe",
    "documents": []
  }
}
```

## Audit Log

All calls log with discipline: "02400" and workflow: "safety-ppe".

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial SAFETY-PPE specification |

## Document Information
- Project: SAFETY-PPE
- Discipline: 02400 Safety
- Date: 2026-04-29
- Status: Active
- Extends: 02400 Safety UI/UX Specification
