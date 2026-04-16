# Procurement Discipline

## Overview

This directory contains all documentation, plans, and issues for the Procurement discipline within the Paperclip ecosystem.

## Repository Mapping

| Repository | Purpose |
|------------|---------|
| **docs-paperclip** | All procurement documentation, plans, and issues |
| **paperclip-render** | All procurement implementation code (APIs, services, UI components) |

## Directory Structure

```
docs-paperclip/disciplines/01900-procurement/
├── CODE-AND-DOC-PLACEMENT.md    ← Placement standards for this discipline
├── README.md                     ← This file
│
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md        ← Master knowledge base
│
├── projects/                    ← All procurement projects
│   └── {PROJECT-CODE}/
│       ├── README.md            ← Project overview
│       ├── plan.md              ← Project plan
│       ├── AGENTS.md            ← Project-specific agent instructions
│       │
│       ├── issues/              ← Non-platform-specific issues
│       │   └── {ISSUE-ID}.md
│       │
│       ├── desktop/             ← Desktop platform
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       │
│       ├── mobile/              ← Mobile platform
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       │
│       ├── web/                 ← Web platform
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       │
│       ├── shared/              ← Shared across platforms
│       │   ├── api/
│       │   ├── business-logic/
│       │   └── data-models/
│       │
│       └── knowledge/           ← Project-specific knowledge
│           └── PAGE-KNOWLEDGE.md
│
├── trigger/                     ← Automation triggers
│   └── {AUTO-PROJECT}/
│       └── issues/
│           └── {AUTO-PROJECT}-000-discipline-automation.md
│
├── procedures/                  ← Discipline-specific procedures
│
└── plans/                       ← Automation plans
```

## Key Files

- **CODE-AND-DOC-PLACEMENT.md**: Discipline-specific placement standards
- **README.md**: This overview document
- **knowledge/PAGE-KNOWLEDGE.md**: Master knowledge base for the discipline
- **projects/**: All procurement projects organized by platform

## Project Organization

Each project under `projects/` follows the standard structure:

```
projects/{PROJECT-CODE}/
├── README.md
├── plan.md
├── AGENTS.md
├── issues/
├── desktop/
├── mobile/
├── web/
├── shared/
└── knowledge/
```

## Issue Reference Format

All issues must reference both repositories:

```markdown
## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`

### Documentation (docs-paperclip)
- `docs-paperclip/disciplines/01900-procurement/projects/PROC-ORDER/desktop/issues/PROC-XXX.md`

### Code Implementation (paperclip-render)
- `paperclip-render/server/src/services/procurement-service.ts`
- `paperclip-render/ui/src/components/procurement/ProcurementForm.tsx`