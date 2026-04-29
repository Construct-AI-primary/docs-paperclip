# CON-VOICE — Orchestration Overview

## Architecture

```
CON-VOICE (Override Spec)
    └── extends: VOICE-COMM (Shared Core)
            ├── VoiceCall Modal Container
            ├── State Machine (Idle → Dialing → Ringing → Connected → Disconnected)
            ├── Number Selection Engine
            ├── Document Attachment System
            └── VoiceForge AI Integration
```

## Override Points

| Override | CON-VOICE Value |
|----------|-------------------|
| entityId source | Contract party/contractor ID from 00400-contracts context |
| getPhoneNumbers() | Discipline-specific phone tables |
| getCallDocumentSources() | Discipline-specific document sources |
| triggerWorkflow | 00400 Contract Administration Workflow |
| roleGate | user.role >= 'contracts_officer' |
| disciplineCode | 00400 |
| accentColour | #283593 |
