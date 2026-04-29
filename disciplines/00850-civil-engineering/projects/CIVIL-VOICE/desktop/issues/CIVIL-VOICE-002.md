---
title: "CIVIL-VOICE-002 — Civil discipline code validation"
description: "Validate that disciplineCode `00850` is properly recognised by the ENG-VOICE routing system"
project: CIVIL-VOICE
discipline: 00850-civil-engineering
status: backlog
priority: low
created: 2026-04-29
---

# CIVIL-VOICE-002 — Civil discipline code validation

## Description

Verify that the Civil discipline code (`00850`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00850` maps to badge label `"Civil"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
