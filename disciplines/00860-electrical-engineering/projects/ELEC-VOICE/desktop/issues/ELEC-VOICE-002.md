---
title: "ELEC-VOICE-002 — Electrical discipline code validation"
description: "Validate that disciplineCode `00860` is properly recognised by the ENG-VOICE routing system"
project: ELEC-VOICE
discipline: 00860-electrical-engineering
status: backlog
priority: low
created: 2026-04-29
---

# ELEC-VOICE-002 — Electrical discipline code validation

## Description

Verify that the Electrical discipline code (`00860`) is correctly routed through the shared ENG-VOICE system with the correct accent colour, badge label, and entity sources.

## Acceptance Criteria

- [ ] `00860` maps to badge label `"Electrical"`
- [ ] Accent colour `#2E7D32` (Engineering Green) is applied
- [ ] Entity sources resolve to `consultant_contacts`, `discipline_leads`, `site_supervisors`
- [ ] Role gate enforces `engineer+` access
