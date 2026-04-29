# ENG-VOICE — Orchestration Overview

## Architecture

```
ENG-VOICE (Override Spec)
    └── extends: VOICE-COMM (Shared Core)
            ├── VoiceCall Modal Container
            ├── State Machine (Idle → Dialing → Ringing → Connected → Disconnected)
            ├── Number Selection Engine
            ├── Document Attachment System
            └── VoiceForge AI Integration
```

## Override Points

| Override | ENG-VOICE Value |
|----------|-------------------|
| entityId source | Consultant/subcontractor/discipline lead ID from disciplines-shared/engineering context |
| getPhoneNumbers() | Discipline-specific phone tables |
| getCallDocumentSources() | Discipline-specific document sources |
| triggerWorkflow | Engineering Design Coordination / RFI Workflow |
| roleGate | user.role >= 'engineer' |
| disciplineCode | disciplines |
| accentColour | #2E7D32 |
