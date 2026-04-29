---
title: "SAFE-VOICE-003 — Document attachment for incident context"
description: "Implement document picker sourcing from HSSE evaluations, safety files, incident reports, and contractor vetting docs"
project: SAFE-VOICE
discipline: 02400-safety
status: backlog
priority: medium
created: 2026-04-29
---

# SAFE-VOICE-003 — Document attachment for incident context

## Description

Implement document picker sourcing from HSSE evaluations, safety files, incident reports, and contractor vetting docs

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with 02400-safety overrides
- [ ] Phone numbers sourced from correct discipline tables
- [ ] Document picker shows correct discipline-specific sources
- [ ] Role gate enforces safety_officer+ access
- [ ] Audit logs tagged with correct discipline code
- [ ] Post-call integration works with discipline workflow

## Dependencies

- VOICE-COMM-001: Core voice call interface
- VOICE-COMM-003: Document attachment system
- VOICE-COMM-004: Audit logging system

## Related Documents

- [UI-UX-SPECIFICATION.md](../UI-UX-SPECIFICATION.md)
- [VOICE-COMM Core](../../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
