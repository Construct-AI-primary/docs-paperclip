# Code and Documentation Placement Guide - 02035 Scheduling

This document defines the standard structure and placement for all code and documentation within the Scheduling discipline.

## Directory Structure

```
02035-scheduling/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Scheduling procedures
│   ├── schedule-development.md
│   ├── cpm-analysis.md
│   ├── resource-leveling.md
│   └── delay-analysis.md
├── plans/                       # Schedule plans
│   └── scheduling-operations-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── SCHED-AUTO/           # Automated scheduling workflows
│       └── issues/
│           └── SCHED-AUTO-000-scheduling-automation.md
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
Location: `trigger/SCHED-AUTO/issues/`
- Covers automation for scheduling processes
- Includes schedule updates, milestone tracking, and delay alerts

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific scheduling automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Scheduling procedures:
- `schedule-development.md` - Schedule creation
- `cpm-analysis.md` - Critical path analysis
- `resource-leveling.md` - Resource optimization
- `delay-analysis.md` - Delay assessment

### plans/
Scheduling planning documents:
- `scheduling-operations-plan.md` - Scheduling strategy

### knowledge/
Scheduling knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for scheduling knowledge

### projects/PROC-001/
Scheduling for procurement:
- `trigger/` - Project scheduling triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
