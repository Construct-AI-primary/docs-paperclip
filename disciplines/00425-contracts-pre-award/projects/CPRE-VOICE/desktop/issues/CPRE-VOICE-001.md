---
title: "CPRE-VOICE-001 — Core voice call interface for tender evaluation"
description: "Implement the VoiceCall modal for pre-award, including number selection from tenderer_contacts.phone and bidder_contacts.phone"
project: CPRE-VOICE
discipline: 00425-contracts-pre-award
status: backlog
priority: medium
created: 2026-04-29
---

# CPRE-VOICE-001 — Core voice call interface for tender evaluation

## Description

Implement the VoiceCall modal for pre-award, including number selection from tenderer_contacts.phone and bidder_contacts.phone

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
