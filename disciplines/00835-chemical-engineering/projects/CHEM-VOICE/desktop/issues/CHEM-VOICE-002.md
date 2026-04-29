---
title: "CHEM-VOICE-002 — Chemical discipline code validation"
description: "Validate that disciplineCode `00835` is properly recognised by the ENG-VOICE routing system"
project: CHEM-VOICE
discipline: 00835-chemical-engineering
status: backlog
priority: low
created: 2026-04-29
---

# CHEM-VOICE-002 — Chemical discipline code validation

## Description

Verify that the Chemical discipline code (`00835`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00835` maps to badge label `"Chemical"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
