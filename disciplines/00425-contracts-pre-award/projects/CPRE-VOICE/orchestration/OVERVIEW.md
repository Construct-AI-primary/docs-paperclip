# CPRE-VOICE — Orchestration Overview

## Architecture

```
CPRE-VOICE (Override Spec)
    └── extends: VOICE-COMM (Shared Core)
            ├── VoiceCall Modal Container
            ├── State Machine (Idle → Dialing → Ringing → Connected → Disconnected)
            ├── Number Selection Engine
            ├── Document Attachment System
            └── VoiceForge AI Integration
```

## Override Points

| Override | CPRE-VOICE Value |
|----------|-------------------|
| entityId source | Tenderer/bidder ID from 00425-contracts-pre-award context |
| getPhoneNumbers() | Discipline-specific phone tables |
| getCallDocumentSources() | Discipline-specific document sources |
| triggerWorkflow | 00425 Tender Evaluation Workflow |
| roleGate | user.role >= 'evaluation_officer' |
| disciplineCode | 00425 |
| accentColour | #4527A0 |
