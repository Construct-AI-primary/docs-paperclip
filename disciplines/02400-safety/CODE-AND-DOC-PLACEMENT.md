# Code and Documentation Placement Guide - 02400 Safety

This document defines the standard structure and placement for all code and documentation within the Safety discipline.

## Directory Structure

```
02400-safety/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Safety procedures
│   ├── risk-assessment.md
│   ├── hazard-control.md
│   ├── incident-investigation.md
│   └── emergency-response.md
├── plans/                       # Safety plans
│   └── safety-management-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── SAFE-AUTO/            # Automated safety workflows
│       └── issues/
│           └── SAFE-AUTO-000-safety-automation.md
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
Location: `trigger/SAFE-AUTO/issues/`
- Covers automation for safety processes
- Includes incident alerts, permit workflows, and compliance tracking

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific safety automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Safety procedures:
- `risk-assessment.md` - Risk assessment processes
- `hazard-control.md` - Hazard control measures
- `incident-investigation.md` - Incident handling
- `emergency-response.md` - Emergency procedures

### plans/
Safety planning documents:
- `safety-management-plan.md` - Overall safety strategy

### knowledge/
Safety knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for safety knowledge

### projects/PROC-001/
Safety for procurement:
- `trigger/` - Project safety triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
