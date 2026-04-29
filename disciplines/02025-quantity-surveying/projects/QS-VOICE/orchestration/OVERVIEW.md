# QS-VOICE — Orchestration Overview

## Architecture

```
QS-VOICE (Override Spec)
    └── extends: VOICE-COMM (Shared Core)
            ├── VoiceCall Modal Container
            ├── State Machine (Idle → Dialing → Ringing → Connected → Disconnected)
            ├── Number Selection Engine
            ├── Document Attachment System
            └── VoiceForge AI Integration
```

## Override Points

| Override | QS-VOICE Value |
|----------|-------------------|
| entityId source | Contractor/subcontractor ID from 02025-quantity-surveying context |
| getPhoneNumbers() | Discipline-specific phone tables |
| getCallDocumentSources() | Discipline-specific document sources |
| triggerWorkflow | 02025 Measurement & Valuation Workflow |
| roleGate | user.role >= 'quantity_surveyor' |
| disciplineCode | 02025 |
| accentColour | #00838F |
