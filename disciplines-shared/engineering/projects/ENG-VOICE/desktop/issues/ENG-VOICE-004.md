---
title: "ENG-VOICE-004 — Multi-discipline routing and audit logging"
description: "Implement disciplineCode-based routing (00825, 00835, 00850, 00850-L, 00855, 00860, 00870, 00871, 00872, 01000) with dynamic badge label resolution"
project: ENG-VOICE
discipline: disciplines-shared/engineering
status: backlog
priority: medium
created: 2026-04-29
---

# ENG-VOICE-004 — Multi-discipline routing and audit logging

## Description

Implement disciplineCode-based routing (00825, 00835, 00850, 00850-L, 00855, 00860, 00870, 00871, 00872, 01000) with dynamic badge label resolution

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with disciplines-shared/engineering overrides
- [ ] Phone numbers sourced from correct discipline tables
- [ ] Document picker shows correct discipline-specific sources
- [ ] Role gate enforces engineer+ access
- [ ] Audit logs tagged with correct discipline code
- [ ] Post-call integration works with discipline workflow

## Dependencies

- VOICE-COMM-001: Core voice call interface
- VOICE-COMM-003: Document attachment system
- VOICE-COMM-004: Audit logging system

## Related Documents

- [UI-UX-SPECIFICATION.md](../UI-UX-SPECIFICATION.md)
- [VOICE-COMM Core](../../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
