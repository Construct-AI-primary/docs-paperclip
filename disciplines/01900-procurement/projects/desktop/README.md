# Procurement Desktop Project

## Overview

This directory contains desktop-specific documentation, issues, and orchestration for the Procurement discipline.

## Repository Structure

```
docs-paperclip/disciplines/01900-procurement/projects/desktop/
├── README.md            ← This file
├── plan.md              ← Project plan
├── AGENTS.md            ← Project-specific agent instructions
├── issues/              ← Non-platform-specific issues
│   └── {ISSUE-ID}.md
├── desktop/             ← Desktop-specific implementation
│   ├── issues/
│   ├── learning/
│   └── orchestration/
├── mobile/              ← Mobile platform (if applicable)
├── web/                 ← Web platform (if applicable)
├── shared/              ← Shared components
└── knowledge/           ← Project-specific knowledge
    └── PAGE-KNOWLEDGE.md
```

## Key Files

- **README.md**: This overview document
- **plan.md**: Project timeline and milestones
- **AGENTS.md**: Agent assignments and responsibilities
- **issues/**: Project issues and requirements
- **desktop/**: Desktop-specific implementation and tracking

## Issue Reference Format

All issues must reference both repositories:

```markdown
## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`

### Documentation (docs-paperclip)
- `docs-paperclip/disciplines/01900-procurement/projects/desktop/issues/PROC-XXX.md`

### Code Implementation (paperclip-render)
- `paperclip-render/server/src/services/procurement-service.ts`
- `paperclip-render/ui/src/components/procurement/ProcurementForm.tsx`