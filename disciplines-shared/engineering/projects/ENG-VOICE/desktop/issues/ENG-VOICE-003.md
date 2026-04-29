---
title: "ENG-VOICE-003 — Engineering design coordination workflow integration"
description: "Integrate into Engineering Design Coordination and RFI Management Workflows with engineer+ role gate and dynamic badge label lookup"
project: ENG-VOICE
discipline: disciplines-shared/engineering
status: backlog
priority: medium
created: 2026-04-29
---

# ENG-VOICE-003 — Engineering design coordination workflow integration

## Description

Integrate into Engineering Design Coordination and RFI Management Workflows with engineer+ role gate and dynamic badge label lookup

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
