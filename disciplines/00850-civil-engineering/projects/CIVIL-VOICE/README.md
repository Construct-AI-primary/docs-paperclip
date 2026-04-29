# CIVIL-VOICE — Civil Engineering Voice Call System

## Overview

This is a **discipline-level reference project** that consumes the shared **ENG-VOICE** engineering voice call override specification.

| Property | Value |
|----------|-------|
| Project Code | CIVIL-VOICE |
| Discipline | 00850-civil-engineering |
| Discipline Code | 00850 |
| Badge Label | Civil |
| Shared Override | [ENG-VOICE](../../../../disciplines-shared/engineering/projects/ENG-VOICE/UI-UX-SPECIFICATION.md) |
| Shared Core | [VOICE-COMM](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md) |

## Key Documents

- [ENG-VOICE Override](../../../../disciplines-shared/engineering/projects/ENG-VOICE/UI-UX-SPECIFICATION.md) — Shared engineering voice call override
- [VOICE-COMM Core](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md) — Core voice call specification

## How This Project Works

1. **VOICE-COMM** defines the core modal, state machine, number selection engine, and colour scheme
2. **ENG-VOICE** defines the shared engineering overrides (all 008xx + 01000 disciplines)
3. **CIVIL-VOICE** defines which discipline-specific `disciplineCode` to pass when calling the shared override
