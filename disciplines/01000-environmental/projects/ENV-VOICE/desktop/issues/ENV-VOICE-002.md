---
title: "ENV-VOICE-002 — Environmental discipline code validation"
description: "Validate that disciplineCode `01000` is properly recognised by the ENG-VOICE routing system"
project: ENV-VOICE
discipline: 01000-environmental
status: backlog
priority: low
created: 2026-04-29
---

# ENV-VOICE-002 — Environmental discipline code validation

## Description

Verify that the Environmental discipline code (`01000`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `01000` maps to badge label `"Environmental"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
