---
title: "QS-VOICE-003 — Measurement and valuation workflow integration"
description: "Integrate into 02025 Measurement & Valuation Workflow with quantity_surveyor+ role gate"
project: QS-VOICE
discipline: 02025-quantity-surveying
status: backlog
priority: medium
created: 2026-04-29
---

# QS-VOICE-003 — Measurement and valuation workflow integration

## Description

Integrate into 02025 Measurement & Valuation Workflow with quantity_surveyor+ role gate

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with 02025-quantity-surveying overrides
- [ ] Phone numbers sourced from correct discipline tables
- [ ] Document picker shows correct discipline-specific sources
- [ ] Role gate enforces quantity_surveyor+ access
- [ ] Audit logs tagged with correct discipline code
- [ ] Post-call integration works with discipline workflow

## Dependencies

- VOICE-COMM-001: Core voice call interface
- VOICE-COMM-003: Document attachment system
- VOICE-COMM-004: Audit logging system

## Related Documents

- [UI-UX-SPECIFICATION.md](../UI-UX-SPECIFICATION.md)
- [VOICE-COMM Core](../../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
