---
title: "CPOST-VOICE-004 — Post-call logging to contract admin timeline"
description: "Implement optional call outcome logging to contract administration timeline"
project: CPOST-VOICE
discipline: 00435-contracts-post-award
status: backlog
priority: medium
created: 2026-04-29
---

# CPOST-VOICE-004 — Post-call logging to contract admin timeline

## Description

Implement optional call outcome logging to contract administration timeline

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with 00435-contracts-post-award overrides
- [ ] Phone numbers sourced from correct discipline tables
- [ ] Document picker shows correct discipline-specific sources
- [ ] Role gate enforces contracts_officer+ access
- [ ] Audit logs tagged with correct discipline code
- [ ] Post-call integration works with discipline workflow

## Dependencies

- VOICE-COMM-001: Core voice call interface
- VOICE-COMM-003: Document attachment system
- VOICE-COMM-004: Audit logging system

## Related Documents

- [UI-UX-SPECIFICATION.md](../UI-UX-SPECIFICATION.md)
- [VOICE-COMM Core](../../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
