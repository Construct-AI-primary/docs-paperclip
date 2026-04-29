# ENV-VOICE — Orchestration Overview

## Architecture

```
ENV-VOICE (Environmental — 01000-environmental)
    └── references: ENG-VOICE (Shared Engineering Override)
            └── extends: VOICE-COMM (Shared Core)
```

This project is a discipline-level reference that consumes the shared ENG-VOICE override with `disciplineCode = "01000"`.
