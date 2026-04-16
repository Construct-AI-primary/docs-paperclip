# Code and Documentation Placement Guide - 02025 Quantity Surveying

This document defines the standard structure and placement for all code and documentation within the Quantity Surveying discipline.

## Directory Structure

```
02025-quantity-surveying/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Quantity surveying procedures
│   ├── measurement.md
│   ├── cost-planning.md
│   ├── valuations.md
│   └── final-accounts.md
├── plans/                       # Cost planning plans
│   └── qs-operations-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── QS-AUTO/               # Automated quantity surveying workflows
│       └── issues/
│           └── QS-AUTO-000-quantity-surveying-automation.md
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
Location: `trigger/QS-AUTO/issues/`
- Covers automation for quantity surveying
- Includes measurement, valuation, and payment workflows

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific QS automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Quantity surveying procedures:
- `measurement.md` - Measurement standards
- `cost-planning.md` - Cost planning methods
- `valuations.md` - Interim valuations
- `final-accounts.md` - Final account preparation

### plans/
Cost planning documents:
- `qs-operations-plan.md` - QS operations strategy

### knowledge/
Quantity surveying knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for QS knowledge

### projects/PROC-001/
Quantity surveying for procurement:
- `trigger/` - Project QS triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
