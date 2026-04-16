# Code and Documentation Placement Guide - 02200 Quality Assurance

This document defines the standard structure and placement for all code and documentation within the Quality Assurance discipline.

## Directory Structure

```
02200-quality-assurance/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # QA procedures
│   ├── qms-development.md
│   ├── process-assurance.md
│   ├── audit-management.md
│   └── capa-management.md
├── plans/                       # Quality plans
│   └── quality-assurance-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── QA-AUTO/              # Automated QA workflows
│       └── issues/
│           └── QA-AUTO-000-quality-assurance-automation.md
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
Location: `trigger/QA-AUTO/issues/`
- Covers automation for QA processes
- Includes audit scheduling, CAPA tracking, and metric reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific QA automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
QA procedures:
- `qms-development.md` - QMS development
- `process-assurance.md` - Process quality
- `audit-management.md` - Audit execution
- `capa-management.md` - CAPA handling

### plans/
Quality planning documents:
- `quality-assurance-plan.md` - Quality strategy

### knowledge/
Quality assurance knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for QA knowledge

### projects/PROC-001/
QA for procurement:
- `trigger/` - Project QA triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
