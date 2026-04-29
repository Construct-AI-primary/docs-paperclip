---
title: "CPRE-VOICE-002 — Document attachment for tender context"
description: "Implement document picker sourcing from tender documents, evaluation reports, bid responses, and clarification queries"
project: CPRE-VOICE
discipline: 00425-contracts-pre-award
status: backlog
priority: medium
created: 2026-04-29
---

# CPRE-VOICE-002 — Document attachment for tender context

## Description

Implement document picker sourcing from tender documents, evaluation reports, bid responses, and clarification queries

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with 00425-contracts-pre-award overrides
- [ ] Phone numbers sourced from correct discipline tables
- [ ] Document picker shows correct discipline-specific sources
- [ ] Role gate enforces evaluation_officer+ access
- [ ] Audit logs tagged with correct discipline code
- [ ] Post-call integration works with discipline workflow

## Dependencies

- VOICE-COMM-001: Core voice call interface
- VOICE-COMM-003: Document attachment system
- VOICE-COMM-004: Audit logging system

## Related Documents

- [UI-UX-SPECIFICATION.md](../UI-UX-SPECIFICATION.md)
- [VOICE-COMM Core](../../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
