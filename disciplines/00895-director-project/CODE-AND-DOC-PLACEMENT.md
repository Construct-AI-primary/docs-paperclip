# Code and Documentation Placement Guide - 00895 Project Director

This document defines the standard structure and placement for all code and documentation within the Project Director discipline.

## Directory Structure

```
00895-director-project/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Project leadership procedures
│   ├── project-leadership.md
│   ├── quality-assurance.md
│   ├── change-management.md
│   └── client-management.md
├── plans/                       # Project plans
│   └── project-excellence-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── PDIR-AUTO/              # Automated project director workflows
│       └── issues/
│           └── PDIR-AUTO-000-project-director-automation.md
├── knowledge/                   # Knowledge base
│   └── PAGE-KNOWLEDGE.md
└── projects/                    # Project implementations
    └── PROC-001/                # Standard Procurement Workflow
        ├── trigger/            # Project-level triggers
        ├── desktop/            # Desktop platform
        ├── mobile/             # Mobile platform
        ├── web/                # Web platform
        └── shared/             # Shared resources
```

## Trigger Placement

### Discipline-Level Triggers
Location: `trigger/PDIR-AUTO/issues/`
- Covers automation for project leadership
- Includes client reporting, quality tracking, and delivery workflows

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific leadership automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Project leadership procedures:
- `project-leadership.md` - Leadership standards
- `quality-assurance.md` - Quality control methods
- `change-management.md` - Change control processes
- `client-management.md` - Client relationship management

### plans/
Project planning documents:
- `project-excellence-plan.md` - Quality and delivery strategy

### knowledge/
Project leadership knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for leadership knowledge

### projects/PROC-001/
Project implementation:
- `trigger/` - Project automation triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
