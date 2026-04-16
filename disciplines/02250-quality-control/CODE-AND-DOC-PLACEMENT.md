# Code and Documentation Placement Guide - 02250 Quality Control

This document defines the standard structure and placement for all code and documentation within the Quality Control discipline.

## Directory Structure

```
02250-quality-control/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # QC procedures
│   ├── material-testing.md
│   ├── quality-testing.md
│   ├── defect-management.md
│   └── hold-points.md
├── plans/                       # QC plans
│   └── quality-control-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── QC-AUTO/              # Automated QC workflows
│       └── issues/
│           └── QC-AUTO-000-quality-control-automation.md
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
Location: `trigger/QC-AUTO/issues/`
- Covers automation for QC processes
- Includes test scheduling, defect tracking, and hold point management

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific QC automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
QC procedures:
- `material-testing.md` - Material verification
- `quality-testing.md` - Quality testing
- `defect-management.md` - Defect handling
- `hold-points.md` - Hold point management

### plans/
QC planning documents:
- `quality-control-plan.md` - QC strategy

### knowledge/
Quality control knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for QC knowledge

### projects/PROC-001/
QC for procurement:
- `trigger/` - Project QC triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
