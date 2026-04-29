---
title: "ENG-VOICE Project Charter — Engineering Voice Call System"
description: "Project charter for the ENG-VOICE Engineering Voice Call System"
author: Paperclip Orchestration System
date: 2026-04-29
version: 1.0
status: active
project_code: ENG-VOICE
discipline: disciplines-shared/engineering
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
---

# ENG-VOICE Project Charter

## Project Overview

**Project Name**: Engineering Voice Call System
**Project Code**: ENG-VOICE
**Discipline**: disciplines-shared/engineering
**Extends**: VOICE-COMM — Core Voice Communication UI/UX Specification

## Scope

This project implements the discipline-specific overrides for the shared Voice Communication system. All core behaviour (modal container, state machine, number selection engine, document attachment system) is inherited from VOICE-COMM.

### In Scope
- Discipline-specific phone number sources (Consultant/subcontractor/discipline lead)
- Discipline-specific document sources for call context
- Integration with Engineering Design Coordination / RFI Workflow
- engineer+ role gate enforcement
- Post-call logging to discipline timeline
- Audit logging with discipline code

### Out of Scope
- Core modal container, state machine, or colour scheme (inherited from VOICE-COMM)
- VoiceForge AI integration (inherited from VOICE-COMM)
- HITL approval workflow (inherited from VOICE-COMM)

## Implementation Approach

This project implements the override contract defined in §F.2 of the VOICE-COMM specification. Each override point is documented in the UI-UX-SPECIFICATION.md.

---

**Document Version**: 1.0
**Last Updated**: 2026-04-29
