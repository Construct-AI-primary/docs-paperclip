---
title: "MECH-VOICE-002 — Mechanical discipline code validation"
description: "Validate that disciplineCode `00870` is properly recognised by the ENG-VOICE routing system"
project: MECH-VOICE
discipline: 00870-mechanical-engineering
status: backlog
priority: low
created: 2026-04-29
---

# MECH-VOICE-002 — Mechanical discipline code validation

## Description

Verify that the Mechanical discipline code (`00870`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00870` maps to badge label `"Mechanical"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
