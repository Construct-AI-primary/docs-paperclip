---
title: "LAND-VOICE-002 — Landscaping discipline code validation"
description: "Validate that disciplineCode `00850-L` is properly recognised by the ENG-VOICE routing system"
project: LAND-VOICE
discipline: 00850-landscaping
status: backlog
priority: low
created: 2026-04-29
---

# LAND-VOICE-002 — Landscaping discipline code validation

## Description

Verify that the Landscaping discipline code (`00850-L`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00850-L` maps to badge label `"Landscaping"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
