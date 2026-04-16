# Code and Documentation Placement Guide - 01000 Environmental

This document defines the standard structure and placement for all code and documentation within the Environmental discipline.

## Directory Structure

```
01000-environmental/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Environmental management procedures
│   ├── environmental-impact.md
│   ├── sustainability.md
│   ├── waste-management.md
│   └── compliance.md
├── plans/                       # Environmental plans
│   └── environmental-management-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── ENV-AUTO/               # Automated environmental workflows
│       └── issues/
│           └── ENV-AUTO-000-environmental-automation.md
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
Location: `trigger/ENV-AUTO/issues/`
- Covers automation for environmental management
- Includes compliance tracking, monitoring, and reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific environmental automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Environmental management procedures:
- `environmental-impact.md` - EIA procedures
- `sustainability.md` - Sustainability initiatives
- `waste-management.md` - Waste reduction and recycling
- `compliance.md` - Regulatory compliance

### plans/
Environmental planning documents:
- `environmental-management-plan.md` - Overall environmental strategy

### knowledge/
Environmental knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for environmental knowledge

### projects/PROC-001/
Environmental management for procurement:
- `trigger/` - Project environmental triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
