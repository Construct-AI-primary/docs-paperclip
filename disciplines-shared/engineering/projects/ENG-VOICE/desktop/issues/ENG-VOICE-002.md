---
title: "ENG-VOICE-002 — Document attachment for design context"
description: "Implement document picker sourcing from design drawings, specifications, design reports, RFI log, and site instructions"
project: ENG-VOICE
discipline: disciplines-shared/engineering
status: backlog
priority: medium
created: 2026-04-29
---

# ENG-VOICE-002 — Document attachment for design context

## Description

Implement document picker sourcing from design drawings, specifications, design reports, RFI log, and site instructions

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
