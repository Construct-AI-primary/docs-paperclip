# Code and Documentation Placement Guide - 01850 Other Parties

This document defines the standard structure and placement for all code and documentation within the Other Parties discipline.

## Directory Structure

```
01850-other-parties/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Stakeholder procedures
│   ├── stakeholder-mapping.md
│   ├── third-party-management.md
│   ├── jv-coordination.md
│   └── partnership-governance.md
├── plans/                       # Stakeholder plans
│   └── stakeholder-engagement-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── PARTY-AUTO/            # Automated stakeholder workflows
│       └── issues/
│           └── PARTY-AUTO-000-stakeholder-automation.md
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
Location: `trigger/PARTY-AUTO/issues/`
- Covers automation for stakeholder management
- Includes engagement tracking, communication scheduling, and reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific stakeholder automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Stakeholder procedures:
- `stakeholder-mapping.md` - Stakeholder identification
- `third-party-management.md` - Third-party oversight
- `jv-coordination.md` - Joint venture coordination
- `partnership-governance.md` - Partnership management

### plans/
Stakeholder planning documents:
- `stakeholder-engagement-plan.md` - Engagement strategy

### knowledge/
Stakeholder knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for stakeholder knowledge

### projects/PROC-001/
Stakeholder management for procurement:
- `trigger/` - Project stakeholder triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
