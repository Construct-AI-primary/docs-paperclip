---
title: "GEO-VOICE-001 — Geotechnical voice call interface registration"
description: "Register the Geotechnical discipline (`00855`) as a consumer of the shared ENG-VOICE override spec"
project: GEO-VOICE
discipline: 00855-geotechnical-engineering
status: backlog
priority: low
created: 2026-04-29
extends: docs-paperclip/disciplines-shared/engineering/projects/ENG-VOICE/UI-UX-SPECIFICATION.md
---

# GEO-VOICE-001 — Geotechnical voice call interface registration

## Description

Register the Geotechnical discipline (`00855`) as a recognised consumer of the shared ENG-VOICE override specification. This ensures the discipline appears in the ENG-VOICE badge label lookup table and disciplineCode routing.

## Acceptance Criteria

- [ ] `00855` is confirmed as a valid `disciplineCode` in the ENG-VOICE override
- [ ] Badge label `"Geotechnical"` resolves correctly from the lookup table
- [ ] Integration test confirms discipline-specific routing works

## Dependencies

- ENG-VOICE-001: Core voice call interface for engineering coordination
- ENG-VOICE-004: Multi-discipline routing and audit logging
