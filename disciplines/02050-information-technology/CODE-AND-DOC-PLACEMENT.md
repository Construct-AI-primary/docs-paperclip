# Code and Documentation Placement Guide - 02050 Information Technology

This document defines the standard structure and placement for all code and documentation within the Information Technology discipline.

## Directory Structure

```
02050-information-technology/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # IT procedures
│   ├── infrastructure.md
│   ├── software-development.md
│   ├── cybersecurity.md
│   └── service-management.md
├── plans/                       # IT strategic plans
│   └── it-strategic-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── IT-AUTO/               # Automated IT workflows
│       └── issues/
│           └── IT-AUTO-000-it-automation.md
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
Location: `trigger/IT-AUTO/issues/`
- Covers automation for IT processes
- Includes system monitoring, security alerts, and deployment automation

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific IT automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
IT procedures:
- `infrastructure.md` - Infrastructure management
- `software-development.md` - Development lifecycle
- `cybersecurity.md` - Security practices
- `service-management.md` - ITSM processes

### plans/
IT planning documents:
- `it-strategic-plan.md` - IT strategy

### knowledge/
IT knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for IT knowledge

### projects/PROC-001/
IT for procurement:
- `trigger/` - Project IT triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
