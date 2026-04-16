# Code and Documentation Placement Guide - 02000 Project Controls

This document defines the standard structure and placement for all code and documentation within the Project Controls discipline.

## Directory Structure

```
02000-project-controls/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Project controls procedures
│   ├── scheduling.md
│   ├── cost-control.md
│   ├── progress-measurement.md
│   └── evm.md
├── plans/                       # Project controls plans
│   └── project-controls-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── PC-AUTO/               # Automated project controls workflows
│       └── issues/
│           └── PC-AUTO-000-project-controls-automation.md
├── knowledge/                   # Knowledge base
│   └── PAGE-KNOWLEDGE.md
└── projects/                    # Project implementations
    └── PROC-001/               # Standard Procurement Workflow
        ├── trigger/            # Project-level triggers
        ├── desktop/            # Desktop platform
        ├── mobile/             # Mobile platform
        ├── web/                # Web platform
        └── shared/             # Shared resources
```

## Trigger Placement

### Discipline-Level Triggers
Location: `trigger/PC-AUTO/issues/`
- Covers automation for project controls
- Includes status updates, cost tracking, and reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific controls automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Project controls procedures:
- `scheduling.md` - Schedule management
- `cost-control.md` - Cost control methods
- `progress-measurement.md` - Progress tracking
- `evm.md` - Earned value management

### plans/
Project controls planning documents:
- `project-controls-plan.md` - Controls strategy

### knowledge/
Project controls knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for project controls knowledge

### projects/PROC-001/
Project controls for procurement:
- `trigger/` - Project controls triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
