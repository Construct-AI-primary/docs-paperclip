---
title: "ENG-VOICE-001 — Core voice call interface for engineering coordination"
description: "Implement the VoiceCall modal for engineering, including number selection from consultant_contacts.phone, discipline_leads.phone, and site_supervisors.phone with dynamic disciplineCode routing"
project: ENG-VOICE
discipline: disciplines-shared/engineering
status: backlog
priority: medium
created: 2026-04-29
---

# ENG-VOICE-001 — Core voice call interface for engineering coordination

## Description

Implement the VoiceCall modal for engineering, including number selection from consultant_contacts.phone, discipline_leads.phone, and site_supervisors.phone with dynamic disciplineCode routing

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
