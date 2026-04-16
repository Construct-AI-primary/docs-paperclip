# Code and Documentation Placement Guide - 03000 Landscaping

This document defines the standard structure and placement for all code and documentation within the Landscaping discipline.

## Directory Structure

```
03000-landscaping/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Landscaping procedures
│   ├── landscape-design.md
│   ├── revegetation.md
│   ├── environmental-enhancement.md
│   └── maintenance-planning.md
├── plans/                       # Landscaping plans
│   └── landscaping-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── LAND-AUTO/            # Automated landscaping workflows
│       └── issues/
│           └── LAND-AUTO-000-landscaping-automation.md
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
Location: `trigger/LAND-AUTO/issues/`
- Covers automation for landscaping processes
- Includes planting schedules, maintenance alerts, and compliance tracking

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific landscaping automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Landscaping procedures:
- `landscape-design.md` - Design coordination
- `revegetation.md` - Revegetation processes
- `environmental-enhancement.md` - Environmental improvement
- `maintenance-planning.md` - Maintenance scheduling

### plans/
Landscaping planning documents:
- `landscaping-plan.md` - Overall landscaping strategy

### knowledge/
Landscaping knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for landscaping knowledge

### projects/PROC-001/
Landscaping for procurement:
- `trigger/` - Project landscaping triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
