---
title: "ENV-VOICE-001 — Environmental voice call interface registration"
description: "Register the Environmental discipline (`01000`) as a consumer of the shared ENG-VOICE override spec"
project: ENV-VOICE
discipline: 01000-environmental
status: backlog
priority: low
created: 2026-04-29
extends: docs-paperclip/disciplines-shared/engineering/projects/ENG-VOICE/UI-UX-SPECIFICATION.md
---

# ENV-VOICE-001 — Environmental voice call interface registration

## Description

Register the Environmental discipline (`01000`) as a recognised consumer of the shared ENG-VOICE override specification. This ensures the discipline appears in the ENG-VOICE badge label lookup table and disciplineCode routing.

## Acceptance Criteria

- [ ] `01000` is confirmed as a valid `disciplineCode` in the ENG-VOICE override
- [ ] Badge label `"Environmental"` resolves correctly from the lookup table
- [ ] Integration test confirms discipline-specific routing works

## Dependencies

- ENG-VOICE-001: Core voice call interface for engineering coordination
- ENG-VOICE-004: Multi-discipline routing and audit logging
