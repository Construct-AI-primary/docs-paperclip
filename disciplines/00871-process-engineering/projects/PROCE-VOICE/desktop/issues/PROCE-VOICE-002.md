---
title: "PROCE-VOICE-002 — Process discipline code validation"
description: "Validate that disciplineCode `00871` is properly recognised by the ENG-VOICE routing system"
project: PROCE-VOICE
discipline: 00871-process-engineering
status: backlog
priority: low
created: 2026-04-29
---

# PROCE-VOICE-002 — Process discipline code validation

## Description

Verify that the Process discipline code (`00871`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00871` maps to badge label `"Process"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
