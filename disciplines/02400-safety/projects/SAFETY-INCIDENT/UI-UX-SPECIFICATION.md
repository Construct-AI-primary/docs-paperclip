---
title: "SAFETY-INCIDENT — Incident Reporting UI/UX Specification"
description: "Incident reporting, investigation, and corrective actions project under 02400 Safety."
version: 1.0
date: 2026-04-29
project_code: "SAFETY-INCIDENT"
discipline: 02400-safety
extends: docs-paperclip/disciplines/02400-safety/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - safety
  - incident-reporting
  - specification
---

# SAFETY-INCIDENT — Incident Reporting UI/UX Specification

## Purpose

This document defines the SAFETY-INCIDENT project under the 02400 Safety discipline, focusing on Incident Reporting. It extends the discipline-level specification with project-specific customisations. All core behaviours (three-state navigation, modal patterns, RAG status colours, HITL integration, AI model backend) are inherited from the parent discipline spec.

## Override Summary Table

| Override | Value |
|----------|-------|
| entityId source | Incident ID from reporting workflow |
| getPhoneNumbers() | incident_investigators.phone + site_managers.phone + safety_officers.phone |
| getCallDocumentSources() | Incident reports, investigation findings, root cause analyses, corrective action plans |
| triggerWorkflow | 02400 Incident Reporting Workflow |
| roleGate | user.role >= safety_officer |
| disciplineCode | "02400" |
| accentColour | #D32F2F (Safety Red) |
| contextLabels | Incident report, Investigation finding, Root cause analysis, Corrective action, Witness statement |

## Entity & Number Source

### Entity ID Source

The VoiceCall modal receives the relevant entity ID from the 02400 Incident Reporting Workflow.

### Phone Number Source

Entity contacts are sourced from project-specific directories: incident_investigators.phone + site_managers.phone + safety_officers.phone.

## Document Sources

| Source | Description | Max Count |
|--------|-------------|-----------|
| Primary documents | Incident reports, investigation findings, root cause analyses, corrective action plans | All |
| Supporting records | Workflow-specific attachments | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

## Workflow-Specific Overrides

### Trigger Workflow

The VoiceCall modal is launched from the **02400 Incident Reporting Workflow**.

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
    "workflow": "safety-incident",
    "documents": []
  }
}
```

## Audit Log

All calls log with discipline: "02400" and workflow: "safety-incident".

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial SAFETY-INCIDENT specification |

## Document Information
- Project: SAFETY-INCIDENT
- Discipline: 02400 Safety
- Date: 2026-04-29
- Status: Active
- Extends: 02400 Safety UI/UX Specification
