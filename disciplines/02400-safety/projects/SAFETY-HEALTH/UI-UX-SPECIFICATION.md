---
title: "SAFETY-HEALTH — Occupational Health UI/UX Specification"
description: "Occupational health monitoring and medical surveillance project under 02400 Safety."
version: 1.0
date: 2026-04-29
project_code: "SAFETY-HEALTH"
discipline: 02400-safety
extends: docs-paperclip/disciplines/02400-safety/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - safety
  - occupational-health
  - specification
---

# SAFETY-HEALTH — Occupational Health UI/UX Specification

## Purpose

This document defines the SAFETY-HEALTH project under the 02400 Safety discipline, focusing on Occupational Health. It extends the discipline-level specification with project-specific customisations. All core behaviours (three-state navigation, modal patterns, RAG status colours, HITL integration, AI model backend) are inherited from the parent discipline spec.

## Override Summary Table

| Override | Value |
|----------|-------|
| entityId source | Health record ID from medical surveillance workflow |
| getPhoneNumbers() | occupational_health.phone + medical_officers.phone + clinic_staff.phone |
| getCallDocumentSources() | Health surveillance records, medical certificates, exposure monitoring reports |
| triggerWorkflow | 02400 Occupational Health Workflow |
| roleGate | user.role >= safety_officer |
| disciplineCode | "02400" |
| accentColour | #D32F2F (Safety Red) |
| contextLabels | Health record, Medical certificate, Exposure report, Fitness assessment, Clinic referral |

## Entity & Number Source

### Entity ID Source

The VoiceCall modal receives the relevant entity ID from the 02400 Occupational Health Workflow.

### Phone Number Source

Entity contacts are sourced from project-specific directories: occupational_health.phone + medical_officers.phone + clinic_staff.phone.

## Document Sources

| Source | Description | Max Count |
|--------|-------------|-----------|
| Primary documents | Health surveillance records, medical certificates, exposure monitoring reports | All |
| Supporting records | Workflow-specific attachments | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

## Workflow-Specific Overrides

### Trigger Workflow

The VoiceCall modal is launched from the **02400 Occupational Health Workflow**.

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
    "workflow": "safety-health",
    "documents": []
  }
}
```

## Audit Log

All calls log with discipline: "02400" and workflow: "safety-health".

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial SAFETY-HEALTH specification |

## Document Information
- Project: SAFETY-HEALTH
- Discipline: 02400 Safety
- Date: 2026-04-29
- Status: Active
- Extends: 02400 Safety UI/UX Specification
