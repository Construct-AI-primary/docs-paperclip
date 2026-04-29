---
title: "CON-VOICE-003 — Contract administration workflow integration"
description: "Integrate into 00400 Contract Administration Workflow with contracts_officer+ role gate"
project: CON-VOICE
discipline: 00400-contracts
status: backlog
priority: medium
created: 2026-04-29
---

# CON-VOICE-003 — Contract administration workflow integration

## Description

Integrate into 00400 Contract Administration Workflow with contracts_officer+ role gate

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with 00400-contracts overrides
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
