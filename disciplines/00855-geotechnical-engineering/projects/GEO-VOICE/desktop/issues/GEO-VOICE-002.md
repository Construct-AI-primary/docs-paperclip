---
title: "GEO-VOICE-002 — Geotechnical discipline code validation"
description: "Validate that disciplineCode `00855` is properly recognised by the ENG-VOICE routing system"
project: GEO-VOICE
discipline: 00855-geotechnical-engineering
status: backlog
priority: low
created: 2026-04-29
---

# GEO-VOICE-002 — Geotechnical discipline code validation

## Description

Verify that the Geotechnical discipline code (`00855`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00855` maps to badge label `"Geotechnical"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
