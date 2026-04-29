---
title: "SAFETY-INSPECTION — Safety Inspections UI/UX Specification"
description: "Safety inspections, audits, and checklists project under 02400 Safety."
version: 1.0
date: 2026-04-29
project_code: "SAFETY-INSPECTION"
discipline: 02400-safety
extends: docs-paperclip/disciplines/02400-safety/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - safety
  - safety-inspections
  - specification
---

# SAFETY-INSPECTION — Safety Inspections UI/UX Specification

## Purpose

This document defines the SAFETY-INSPECTION project under the 02400 Safety discipline, focusing on Safety Inspections. It extends the discipline-level specification with project-specific customisations. All core behaviours (three-state navigation, modal patterns, RAG status colours, HITL integration, AI model backend) are inherited from the parent discipline spec.

## Override Summary Table

| Override | Value |
|----------|-------|
| entityId source | Inspection ID from audit workflow |
| getPhoneNumbers() | inspection_team.phone + audit_leads.phone + area_managers.phone |
| getCallDocumentSources() | Inspection checklists, audit reports, non-conformance records, close-out reports |
| triggerWorkflow | 02400 Safety Inspection Workflow |
| roleGate | user.role >= safety_officer |
| disciplineCode | "02400" |
| accentColour | #D32F2F (Safety Red) |
| contextLabels | Inspection checklist, Audit report, Non-conformance, Close-out report, Observation card |

## Entity & Number Source

### Entity ID Source

The VoiceCall modal receives the relevant entity ID from the 02400 Safety Inspection Workflow.

### Phone Number Source

Entity contacts are sourced from project-specific directories: inspection_team.phone + audit_leads.phone + area_managers.phone.

## Document Sources

| Source | Description | Max Count |
|--------|-------------|-----------|
| Primary documents | Inspection checklists, audit reports, non-conformance records, close-out reports | All |
| Supporting records | Workflow-specific attachments | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

## Workflow-Specific Overrides

### Trigger Workflow

The VoiceCall modal is launched from the **02400 Safety Inspection Workflow**.

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
    "workflow": "safety-inspection",
    "documents": []
  }
}
```

## Audit Log

All calls log with discipline: "02400" and workflow: "safety-inspection".

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial SAFETY-INSPECTION specification |

## Document Information
- Project: SAFETY-INSPECTION
- Discipline: 02400 Safety
- Date: 2026-04-29
- Status: Active
- Extends: 02400 Safety UI/UX Specification
