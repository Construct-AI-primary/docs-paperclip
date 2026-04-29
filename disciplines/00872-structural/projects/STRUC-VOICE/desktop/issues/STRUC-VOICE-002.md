---
title: "STRUC-VOICE-002 — Structural discipline code validation"
description: "Validate that disciplineCode `00872` is properly recognised by the ENG-VOICE routing system"
project: STRUC-VOICE
discipline: 00872-structural
status: backlog
priority: low
created: 2026-04-29
---

# STRUC-VOICE-002 — Structural discipline code validation

## Description

Verify that the Structural discipline code (`00872`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00872` maps to badge label `"Structural"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
