# Code and Documentation Placement Guide - 02075 Inspection

This document defines the standard structure and placement for all code and documentation within the Inspection discipline.

## Directory Structure

```
02075-inspection/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Inspection procedures
│   ├── inspection-planning.md
│   ├── quality-inspection.md
│   ├── testing-sampling.md
│   └── ncr-management.md
├── plans/                       # Inspection plans
│   └── inspection-operations-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── INSP-AUTO/            # Automated inspection workflows
│       └── issues/
│           └── INSP-AUTO-000-inspection-automation.md
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
Location: `trigger/INSP-AUTO/issues/`
- Covers automation for inspection processes
- Includes scheduling, NCR tracking, and certification workflows

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific inspection automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Inspection procedures:
- `inspection-planning.md` - Inspection scheduling
- `quality-inspection.md` - Inspection execution
- `testing-sampling.md` - Testing protocols
- `ncr-management.md` - NCR handling

### plans/
Inspection planning documents:
- `inspection-operations-plan.md` - Inspection strategy

### knowledge/
Inspection knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for inspection knowledge

### projects/PROC-001/
Inspection for procurement:
- `trigger/` - Project inspection triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
