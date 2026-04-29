---
title: "ARCH-VOICE-002 — Architect discipline code validation"
description: "Validate that disciplineCode `00825` is properly recognised by the ENG-VOICE routing system"
project: ARCH-VOICE
discipline: 00825-architectural
status: backlog
priority: low
created: 2026-04-29
---

# ARCH-VOICE-002 — Architect discipline code validation

## Description

Verify that the Architect discipline code (`00825`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00825` maps to badge label `"Architect"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
