# CPOST-VOICE — Orchestration Overview

## Architecture

```
CPOST-VOICE (Override Spec)
    └── extends: VOICE-COMM (Shared Core)
            ├── VoiceCall Modal Container
            ├── State Machine (Idle → Dialing → Ringing → Connected → Disconnected)
            ├── Number Selection Engine
            ├── Document Attachment System
            └── VoiceForge AI Integration
```

## Override Points

| Override | CPOST-VOICE Value |
|----------|-------------------|
| entityId source | Contractor ID from 00435-contracts-post-award context |
| getPhoneNumbers() | Discipline-specific phone tables |
| getCallDocumentSources() | Discipline-specific document sources |
| triggerWorkflow | 00435 Contract Administration Workflow |
| roleGate | user.role >= 'contracts_officer' |
| disciplineCode | 00435 |
| accentColour | #7B1FA2 |
