# Code and Documentation Placement Guide - 01300 Governance

This document defines the standard structure and placement for all code and documentation within the Governance discipline.

## Directory Structure

```
01300-governance/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Governance procedures
│   ├── governance-framework.md
│   ├── policy-management.md
│   ├── compliance-monitoring.md
│   └── board-support.md
├── plans/                       # Governance plans
│   └── governance-annual-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── GOV-AUTO/               # Automated governance workflows
│       └── issues/
│           └── GOV-AUTO-000-governance-automation.md
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
Location: `trigger/GOV-AUTO/issues/`
- Covers automation for governance processes
- Includes compliance tracking, policy updates, and reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific governance automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Governance procedures:
- `governance-framework.md` - Framework development
- `policy-management.md` - Policy lifecycle
- `compliance-monitoring.md` - Compliance tracking
- `board-support.md` - Board coordination

### plans/
Governance planning documents:
- `governance-annual-plan.md` - Yearly governance strategy

### knowledge/
Governance knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for governance knowledge

### projects/PROC-001/
Governance for procurement:
- `trigger/` - Project governance triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
