---
title: "CPOST-VOICE-001 — Core voice call interface for post-award administration"
description: "Implement the VoiceCall modal for post-award, including number selection from contractor_contacts.phone and contract_admin_contacts.phone"
project: CPOST-VOICE
discipline: 00435-contracts-post-award
status: backlog
priority: medium
created: 2026-04-29
---

# CPOST-VOICE-001 — Core voice call interface for post-award administration

## Description

Implement the VoiceCall modal for post-award, including number selection from contractor_contacts.phone and contract_admin_contacts.phone

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
