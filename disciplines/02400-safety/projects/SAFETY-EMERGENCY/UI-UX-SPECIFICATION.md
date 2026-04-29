---
title: "SAFETY-EMERGENCY — Emergency Response UI/UX Specification"
description: "Emergency response planning, drills, and incident command project under 02400 Safety."
version: 1.0
date: 2026-04-29
project_code: "SAFETY-EMERGENCY"
discipline: 02400-safety
extends: docs-paperclip/disciplines/02400-safety/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - safety
  - emergency-response
  - specification
---

# SAFETY-EMERGENCY — Emergency Response UI/UX Specification

## Purpose

This document defines the SAFETY-EMERGENCY project under the 02400 Safety discipline, focusing on Emergency Response. It extends the discipline-level specification with project-specific customisations. All core behaviours (three-state navigation, modal patterns, RAG status colours, HITL integration, AI model backend) are inherited from the parent discipline spec.

## Override Summary Table

| Override | Value |
|----------|-------|
| entityId source | Emergency plan ID from response workflow |
| getPhoneNumbers() | emergency_response_contacts.phone + incident_command.phone + emergency_services.phone |
| getCallDocumentSources() | Emergency response plans, drill reports, evacuation maps, incident command logs |
| triggerWorkflow | 02400 Emergency Response Workflow |
| roleGate | user.role >= safety_officer |
| disciplineCode | "02400" |
| accentColour | #D32F2F (Safety Red) |
| contextLabels | Response plan, Drill report, Evacuation map, Incident command log, Emergency contact |

## Entity & Number Source

### Entity ID Source

The VoiceCall modal receives the relevant entity ID from the 02400 Emergency Response Workflow.

### Phone Number Source

Entity contacts are sourced from project-specific directories: emergency_response_contacts.phone + incident_command.phone + emergency_services.phone.

## Document Sources

| Source | Description | Max Count |
|--------|-------------|-----------|
| Primary documents | Emergency response plans, drill reports, evacuation maps, incident command logs | All |
| Supporting records | Workflow-specific attachments | 10 |
| Manual upload | Drag-and-drop or file browse | Unlimited |

## Workflow-Specific Overrides

### Trigger Workflow

The VoiceCall modal is launched from the **02400 Emergency Response Workflow**.

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
    "workflow": "safety-emergency",
    "documents": []
  }
}
```

## Audit Log

All calls log with discipline: "02400" and workflow: "safety-emergency".

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial SAFETY-EMERGENCY specification |

## Document Information
- Project: SAFETY-EMERGENCY
- Discipline: 02400 Safety
- Date: 2026-04-29
- Status: Active
- Extends: 02400 Safety UI/UX Specification
