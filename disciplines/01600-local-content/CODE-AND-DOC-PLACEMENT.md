# Code and Documentation Placement Guide - 01600 Local Content

This document defines the standard structure and placement for all code and documentation within the Local Content discipline.

## Directory Structure

```
01600-local-content/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Local content procedures
│   ├── local-sourcing.md
│   ├── indigenous-participation.md
│   ├── community-benefits.md
│   └── supplier-development.md
├── plans/                       # Local content plans
│   └── local-content-strategy.md
├── trigger/                     # Discipline-level automation triggers
│   └── LC-AUTO/                # Automated local content workflows
│       └── issues/
│           └── LC-AUTO-000-local-content-automation.md
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
Location: `trigger/LC-AUTO/issues/`
- Covers automation for local content management
- Includes sourcing tracking, compliance reporting, and benefit monitoring

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific local content automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Local content procedures:
- `local-sourcing.md` - Local procurement
- `indigenous-participation.md` - Indigenous engagement
- `community-benefits.md` - Community programs
- `supplier-development.md` - Local supplier growth

### plans/
Local content planning documents:
- `local-content-strategy.md` - Overall local content strategy

### knowledge/
Local content knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for local content knowledge

### projects/PROC-001/
Local content for procurement:
- `trigger/` - Project local content triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
