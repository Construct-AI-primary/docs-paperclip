# LOG-VOICE — Orchestration Overview

## Architecture

```
LOG-VOICE (Override Spec)
    └── extends: VOICE-COMM (Shared Core)
            ├── VoiceCall Modal Container
            ├── State Machine (Idle → Dialing → Ringing → Connected → Disconnected)
            ├── Number Selection Engine
            ├── Document Attachment System
            └── VoiceForge AI Integration
```

## Override Points

| Override | LOG-VOICE Value |
|----------|-------------------|
| entityId source | Carrier/transport provider ID from 01700-logistics context |
| getPhoneNumbers() | Discipline-specific phone tables |
| getCallDocumentSources() | Discipline-specific document sources |
| triggerWorkflow | 01700 Dispatch & Coordination Workflow |
| roleGate | user.role >= 'dispatcher' |
| disciplineCode | 01700 |
| accentColour | #1565C0 |
