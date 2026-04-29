---
title: "LOG-VOICE-002 — Document attachment for dispatch context"
description: "Implement document picker sourcing from shipment manifests, waybills, delivery instructions, and site access documents"
project: LOG-VOICE
discipline: 01700-logistics
status: backlog
priority: medium
created: 2026-04-29
---

# LOG-VOICE-002 — Document attachment for dispatch context

## Description

Implement document picker sourcing from shipment manifests, waybills, delivery instructions, and site access documents

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with 01700-logistics overrides
- [ ] Phone numbers sourced from correct discipline tables
- [ ] Document picker shows correct discipline-specific sources
- [ ] Role gate enforces dispatcher+ access
- [ ] Audit logs tagged with correct discipline code
- [ ] Post-call integration works with discipline workflow

## Dependencies

- VOICE-COMM-001: Core voice call interface
- VOICE-COMM-003: Document attachment system
- VOICE-COMM-004: Audit logging system

## Related Documents

- [UI-UX-SPECIFICATION.md](../UI-UX-SPECIFICATION.md)
- [VOICE-COMM Core](../../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
