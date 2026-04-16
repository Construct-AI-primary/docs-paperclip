# Code and Documentation Placement Guide - 01400 Health

This document defines the standard structure and placement for all code and documentation within the Health discipline.

## Directory Structure

```
01400-health/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Health management procedures
│   ├── occupational-health.md
│   ├── health-surveillance.md
│   ├── wellness-programs.md
│   └── medical-assessments.md
├── plans/                       # Health management plans
│   └── health-management-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── HEALTH-AUTO/           # Automated health workflows
│       └── issues/
│           └── HEALTH-AUTO-000-health-automation.md
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
Location: `trigger/HEALTH-AUTO/issues/`
- Covers automation for health management
- Includes surveillance scheduling, wellness tracking, and reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific health automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Health management procedures:
- `occupational-health.md` - OH standards
- `health-surveillance.md` - Surveillance programs
- `wellness-programs.md` - Employee wellness
- `medical-assessments.md` - Fitness assessments

### plans/
Health management planning documents:
- `health-management-plan.md` - Overall health strategy

### knowledge/
Health knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for health knowledge

### projects/PROC-001/
Health management for procurement:
- `trigger/` - Project health triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
