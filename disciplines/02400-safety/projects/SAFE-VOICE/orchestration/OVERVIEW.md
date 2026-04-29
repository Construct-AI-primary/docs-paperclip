# SAFE-VOICE — Orchestration Overview

## Architecture

```
SAFE-VOICE (Override Spec)
    └── extends: VOICE-COMM (Shared Core)
            ├── VoiceCall Modal Container
            ├── State Machine (Idle → Dialing → Ringing → Connected → Disconnected)
            ├── Number Selection Engine
            ├── Document Attachment System
            └── VoiceForge AI Integration
```

## Override Points

| Override | SAFE-VOICE Value |
|----------|-------------------|
| entityId source | Contractor/emergency contact ID from 02400-safety context |
| getPhoneNumbers() | Discipline-specific phone tables |
| getCallDocumentSources() | Discipline-specific document sources |
| triggerWorkflow | 02400 Emergency Response / Incident Management Workflow |
| roleGate | user.role >= 'safety_officer' |
| disciplineCode | 02400 |
| accentColour | #E65100 |
