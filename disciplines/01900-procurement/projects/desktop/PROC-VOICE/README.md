# Procurement Voice Project

## Overview

This directory contains voice-specific documentation, issues, and orchestration for the Procurement discipline.

## Repository Structure

```
docs-paperclip/disciplines/01900-procurement/projects/desktop/PROC-VOICE/
├── README.md            ← This file
├── plan.md              ← Project plan
├── AGENTS.md            ← Project-specific agent instructions
├── issues/              ← Non-platform-specific issues
│   └── {ISSUE-ID}.md
├── knowledge/           ← Project-specific knowledge
│   └── PAGE-KNOWLEDGE.md
└── orchestration/       ← Workflow orchestration
    └── OVERVIEW.md
```

## Key Files

- **README.md**: This overview document
- **plan.md**: Project timeline and milestones
- **AGENTS.md**: Agent assignments and responsibilities
- **issues/**: Project issues and requirements
- **knowledge/**: Project-specific knowledge base
- **orchestration/**: Workflow orchestration documentation

## Issue Reference Format

All issues must reference both repositories:

```markdown
## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`

### Documentation (docs-paperclip)
- `docs-paperclip/disciplines/01900-procurement/projects/desktop/PROC-VOICE/issues/PROC-VOICE-XXX.md`

### Code Implementation (paperclip-render)
- `paperclip-render/server/src/services/procurement-service.ts`
- `paperclip-render/ui/src/components/procurement/ProcurementForm.tsx`