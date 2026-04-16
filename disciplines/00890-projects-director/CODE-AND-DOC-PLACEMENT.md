# Code and Documentation Placement Guide - 00890 Projects Director

This document defines the standard structure and placement for all code and documentation within the Projects Director discipline.

## Directory Structure

```
00890-projects-director/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Project governance procedures
│   ├── portfolio-management.md
│   ├── project-charter.md
│   ├── risk-management.md
│   └── stakeholder-management.md
├── plans/                       # Project plans
│   └── annual-portfolio-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── PROJ-AUTO/              # Automated project workflows
│       └── issues/
│           └── PROJ-AUTO-000-projects-automation.md
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
Location: `trigger/PROJ-AUTO/issues/`
- Covers automation for all projects
- Includes status reporting, escalation, and delivery workflows

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Project governance procedures:
- `portfolio-management.md` - Portfolio oversight methods
- `project-charter.md` - Project initiation standards
- `risk-management.md` - Risk identification and mitigation
- `stakeholder-management.md` - Stakeholder engagement

### plans/
Project planning documents:
- `annual-portfolio-plan.md` - Yearly portfolio strategy
- `resource-allocation-plan.md` - Resource planning

### knowledge/
Project management knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for project knowledge

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
